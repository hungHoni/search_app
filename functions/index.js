const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const { GoogleGenerativeAI } = require("@google/generative-ai");

// Define the Gemini API key as a Firebase secret
const geminiApiKey = defineSecret("GEMINI_API_KEY");

exports.geminiProxy = onCall(
  { secrets: [geminiApiKey] },
  async (request) => {
    // 1. Verify the user is authenticated
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "You must be signed in to use this function."
      );
    }

    // 2. Extract and validate request data
    const { query, type, contextData } = request.data;

    if (type !== "suggestions" && (!query || typeof query !== "string")) {
      throw new HttpsError(
        "invalid-argument",
        'The "query" field is required and must be a string.'
      );
    }

    if (!type || !["search", "flashcards", "suggestions"].includes(type)) {
      throw new HttpsError(
        "invalid-argument",
        'The "type" field must be "search", "flashcards", or "suggestions".'
      );
    }

    if (type === "flashcards" && (!Array.isArray(contextData) || contextData.length === 0)) {
      throw new HttpsError(
        "invalid-argument",
        'The "contextData" field is required for flashcard generation.'
      );
    }

    if (type === "suggestions" && (!Array.isArray(contextData) || contextData.length === 0)) {
      throw new HttpsError(
        "invalid-argument",
        'The "contextData" field (past topics) is required for suggestions.'
      );
    }

    // 3. Build the prompt based on type
    let prompt;

    if (type === "search") {
      prompt = `You are an expert technical educator. Provide a deep, 5-part educational analysis of the topic: "${query}".
Return the result strictly as a JSON array of 5 objects. Each object must have exactly two string fields: "title" and "summary".

IMPORTANT: Choose 5 section titles that are MOST RELEVANT to this specific topic. Do NOT use generic categories.
For example:
- For "Docker": "Container Architecture", "Dockerfile Best Practices", "Networking & Volumes", "Security Considerations", "Docker Compose Orchestration"
- For "Binary Search": "Algorithm Mechanics", "Time & Space Complexity", "Edge Cases & Off-by-One", "Variations (Lower/Upper Bound)", "Real-World Search Applications"
- For "REST APIs": "Resource Design Principles", "HTTP Methods & Status Codes", "Authentication Strategies", "Versioning & Pagination", "Rate Limiting & Caching"

Each title should be numbered (1-5) and specific to "${query}". The summary should be concise, highly educational, and 2-3 sentences max.`;
    } else if (type === "flashcards") {
      const contextText = contextData
        .map((c) => `${c.title}: ${c.summary}`)
        .join("\n");

      prompt = `You are an expert technical educator. I have provided a 5-part educational analysis of the topic: "${query}".
Based ONLY on the following context, generate exactly 5 highly educational Q&A flashcards.

Context:
${contextText}

Return the result strictly as a JSON array of exactly 5 objects. Each object must have exactly two string fields: "question" and "answer".
Keep the questions concise, and the answers thorough but easily readable (2-3 sentences max).`;
    } else {
      // type === "suggestions"
      const pastTopics = contextData.map((t) => `- ${t}`).join("\n");

      prompt = `You are an educational curriculum advisor. The user has previously studied these topics:

${pastTopics}

Based on their learning history, suggest exactly 6 new topics they should study next.
The suggestions should:
- Build naturally on what they've already learned
- Progress from foundational to advanced
- Cover related but unexplored areas
- Be concise (2-4 words each)

Return ONLY a valid JSON array of 6 strings. No markdown, no explanation.
Example: ["Neural Networks", "Database Indexing", "CI/CD Pipelines", "WebSocket APIs", "Kubernetes Basics", "OAuth 2.0"]`;
    }

    // 4. Call Gemini API
    try {
      const genAI = new GoogleGenerativeAI(geminiApiKey.value());
      const modelName = type === "suggestions" ? "gemini-2.0-flash" : "gemini-2.5-flash";
      const model = genAI.getGenerativeModel({
        model: modelName,
        generationConfig: { responseMimeType: "application/json" },
      });

      const result = await model.generateContent(prompt);
      const responseText = result.response.text();

      if (!responseText) {
        throw new HttpsError("internal", "Received an empty response from Gemini.");
      }

      const jsonList = JSON.parse(responseText);
      const expectedCount = type === "suggestions" ? 6 : 5;

      if (!Array.isArray(jsonList) || jsonList.length < expectedCount) {
        throw new HttpsError(
          "internal",
          `Gemini did not return the required ${expectedCount} items.`
        );
      }

      return { results: jsonList.slice(0, expectedCount) };
    } catch (error) {
      if (error instanceof HttpsError) {
        throw error;
      }
      console.error("Gemini API error:", error);
      throw new HttpsError(
        "internal",
        `Failed to fetch from Gemini: ${error.message}`
      );
    }
  }
);
