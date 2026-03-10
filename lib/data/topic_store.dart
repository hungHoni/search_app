/// A curated pool of 100 educational topics across Computer Science,
/// Software Engineering, and related fields. The pool is randomly sampled
/// to show 6 topics as suggestion chips on the home screen.
class TopicStore {
  /// The full pool of curated topic keywords.
  static const List<String> topics = [
    // --- Fundamentals ---
    'Binary Search',
    'Linked Lists',
    'Hash Tables',
    'Recursion',
    'Stack & Queue',
    'Binary Trees',
    'Sorting Algorithms',
    'Graph Theory',
    'Dynamic Programming',
    'Greedy Algorithms',
    'Big O Notation',
    'Bit Manipulation',
    'Tries',
    'Heaps',
    'Divide and Conquer',

    // --- System Design ---
    'System Design',
    'Load Balancing',
    'Caching Strategies',
    'Database Sharding',
    'Message Queues',
    'Microservices',
    'API Gateway',
    'Event-Driven Architecture',
    'CAP Theorem',
    'Distributed Systems',
    'Consistent Hashing',
    'Rate Limiting',
    'Circuit Breaker Pattern',
    'CQRS Pattern',
    'Service Mesh',

    // --- Web & APIs ---
    'REST APIs',
    'GraphQL',
    'WebSockets',
    'HTTP/2',
    'OAuth 2.0',
    'JWT Authentication',
    'CORS',
    'Server-Sent Events',
    'gRPC',
    'API Versioning',

    // --- DevOps & Infrastructure ---
    'Docker',
    'Kubernetes',
    'CI/CD Pipelines',
    'Terraform',
    'Nginx',
    'Linux Fundamentals',
    'Git Internals',
    'Monitoring & Observability',
    'Infrastructure as Code',
    'Blue-Green Deployment',

    // --- Databases ---
    'SQL Joins',
    'Database Indexing',
    'NoSQL Databases',
    'Redis',
    'PostgreSQL',
    'Database Transactions',
    'ACID Properties',
    'Database Normalization',
    'Time Series Databases',
    'Graph Databases',

    // --- Programming Paradigms ---
    'SOLID Principles',
    'Design Patterns',
    'Functional Programming',
    'Object-Oriented Design',
    'Test-Driven Development',
    'Clean Architecture',
    'Dependency Injection',
    'Reactive Programming',
    'Domain-Driven Design',
    'Hexagonal Architecture',

    // --- AI & Machine Learning ---
    'Machine Learning',
    'Neural Networks',
    'Natural Language Processing',
    'Computer Vision',
    'Reinforcement Learning',
    'Transformer Architecture',
    'Gradient Descent',
    'Feature Engineering',
    'Model Evaluation',
    'Transfer Learning',

    // --- Security ---
    'Cryptography Basics',
    'SQL Injection',
    'Cross-Site Scripting',
    'HTTPS & TLS',
    'Zero Trust Security',

    // --- Modern Concepts ---
    'Concurrency',
    'WebAssembly',
    'Edge Computing',
    'Blockchain Basics',
    'Serverless Architecture',
  ];
}
