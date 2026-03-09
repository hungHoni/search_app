import '../../domain/models/saved_search.dart';

class MarkdownExporter {
  /// Transforms a `SavedSearch` object into a beautifully formatted Markdown string
  /// optimized for pasting directly into Notion or Obsidian.
  static String exportToNotion(SavedSearch search) {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('# ${search.query.toUpperCase()}');
    buffer.writeln('*Exported from Minimal Search App* \\');
    buffer.writeln(
      'Date: ${search.timestamp.toLocal().toString().split(' ')[0]}',
    );
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln();

    // Core Educational Content
    buffer.writeln('## Deep Analysis');
    buffer.writeln();
    for (final result in search.results) {
      buffer.writeln('### ${result.title}');
      buffer.writeln(result.summary);
      buffer.writeln();
    }

    // Flashcard Integration (If generated)
    if (search.flashcards != null && search.flashcards!.isNotEmpty) {
      buffer.writeln('---');
      buffer.writeln();
      buffer.writeln('## Spaced Repetition (Flashcards)');
      buffer.writeln();
      for (int i = 0; i < search.flashcards!.length; i++) {
        final card = search.flashcards![i];
        buffer.writeln('**Q${i + 1}: ${card.question}**');

        // Use Notion/GitHub compatible toggle block for answers
        buffer.writeln('<details><summary>Reveal Answer</summary>');
        buffer.writeln('');
        buffer.writeln('> ${card.answer}');
        buffer.writeln('</details>');
        buffer.writeln();
      }
    }

    return buffer.toString();
  }
}
