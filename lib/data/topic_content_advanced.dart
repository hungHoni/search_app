/// Pre-generated content for Databases, Programming Paradigms, AI/ML, Security, and Modern topics.
const Map<String, List<Map<String, String>>> advancedContent = {
  'sql joins': [
    {
      'title': '1. Join Types Explained',
      'summary':
          'INNER JOIN returns matching rows from both tables. LEFT JOIN includes all left rows. RIGHT JOIN includes all right rows. FULL OUTER JOIN includes all rows from both tables.',
    },
    {
      'title': '2. Join Algorithms',
      'summary':
          'Nested loop joins compare every pair (O(n²)). Hash joins build a hash table on the smaller table (O(n+m)). Sort-merge joins work by sorting both tables first. The optimizer chooses based on data size.',
    },
    {
      'title': '3. Self Joins & Cross Joins',
      'summary':
          'Self joins relate rows within the same table (employee-manager hierarchies). Cross joins produce the Cartesian product of two tables. Both have legitimate but niche use cases.',
    },
    {
      'title': '4. Performance Optimization',
      'summary':
          'Index the join columns for dramatic speedup. Avoid joining on computed expressions. Use EXPLAIN to verify the query plan. Denormalize for read-heavy workloads where join performance is critical.',
    },
    {
      'title': '5. Anti-Patterns',
      'summary':
          'Implicit joins (comma-separated FROM) are harder to read. SELECT * with joins wastes bandwidth. Multiple joins without proper indexing create quadratic slowdowns. Always profile complex join queries.',
    },
  ],
  'database indexing': [
    {
      'title': '1. B-Tree Index Structure',
      'summary':
          'B-trees maintain sorted data in a balanced tree with high fanout. Leaf nodes contain pointers to actual rows. B-tree indexes support equality, range, and prefix queries efficiently in O(log n).',
    },
    {
      'title': '2. Composite Indexes',
      'summary':
          'Multi-column indexes follow the leftmost prefix rule: an index on (A, B, C) speeds up queries filtering on A, (A, B), or (A, B, C), but not B alone or C alone.',
    },
    {
      'title': '3. Covering Indexes',
      'summary':
          'A covering index contains all columns needed by a query, avoiding the table lookup entirely. This is the fastest possible query path since all data is served from the index itself.',
    },
    {
      'title': '4. When NOT to Index',
      'summary':
          'Indexes slow down writes since every insert/update/delete must also update the index. Small tables, low-selectivity columns (boolean), and rarely-queried columns are poor indexing candidates.',
    },
    {
      'title': '5. Specialized Index Types',
      'summary':
          'Hash indexes for equality-only lookups. GIN/GiST for full-text search and JSON. R-tree for spatial data. Bloom filters for probabilistic existence checks. Each targets specific query patterns.',
    },
  ],
  'nosql databases': [
    {
      'title': '1. Document Stores',
      'summary':
          'MongoDB and Firestore store data as JSON-like documents. Flexible schemas enable rapid development. Nested documents reduce joins. Best for content management, user profiles, and catalog systems.',
    },
    {
      'title': '2. Key-Value Stores',
      'summary':
          'Redis and DynamoDB store data as simple key-value pairs. Extremely fast (O(1) reads/writes). Used for caching, session management, and real-time leaderboards where data structure is simple.',
    },
    {
      'title': '3. Column-Family Stores',
      'summary':
          'Cassandra and HBase store data in column families, optimized for writes and time-series data. Excellent for IoT sensor data, event logging, and any write-heavy workload at massive scale.',
    },
    {
      'title': '4. Graph Databases',
      'summary':
          'Neo4j and Amazon Neptune store relationships as first-class citizens. Traversing relationships is O(1) per hop regardless of database size, making them ideal for social networks and recommendation engines.',
    },
    {
      'title': '5. Choosing SQL vs NoSQL',
      'summary':
          'Use SQL when you need ACID transactions, complex joins, or strict schema. Use NoSQL when you need horizontal scalability, flexible schema, or specific data model alignment (graphs, time-series).',
    },
  ],
  'redis': [
    {
      'title': '1. In-Memory Data Store',
      'summary':
          'Redis stores all data in RAM, providing sub-millisecond read/write latency. It supports optional disk persistence via RDB snapshots and AOF (Append Only File) for durability.',
    },
    {
      'title': '2. Data Structures',
      'summary':
          'Beyond strings: Lists (queues), Sets (unique members), Sorted Sets (leaderboards), Hashes (objects), Streams (event logs), and HyperLogLog (cardinality estimation). This richness is Redis\'s killer feature.',
    },
    {
      'title': '3. Caching Patterns',
      'summary':
          'Cache-aside with TTL is the most common pattern. Use Redis as a session store for stateless web servers. Pub/Sub enables real-time messaging. Lua scripting provides atomic multi-step operations.',
    },
    {
      'title': '4. Cluster Architecture',
      'summary':
          'Redis Cluster partitions data across multiple nodes using hash slots (16384 total). Sentinel provides high availability with automatic failover. Replication ensures data safety.',
    },
    {
      'title': '5. Common Use Cases',
      'summary':
          'Rate limiting (INCR + EXPIRE), distributed locks (SETNX + TTL), real-time analytics (Sorted Sets), job queues (BRPOP/BLPOP), and feature flags. Redis solves a wide array of systems problems.',
    },
  ],
  'postgresql': [
    {
      'title': '1. MVCC Architecture',
      'summary':
          'PostgreSQL uses Multi-Version Concurrency Control: readers never block writers and vice versa. Each transaction sees a snapshot of the database, enabling high concurrency without lock contention.',
    },
    {
      'title': '2. Advanced Data Types',
      'summary':
          'Native support for JSONB (indexed JSON), arrays, hstore (key-value), ranges, and geometric types. JSONB enables document-store flexibility within a relational database.',
    },
    {
      'title': '3. Query Optimization',
      'summary':
          'EXPLAIN ANALYZE shows actual vs estimated row counts and execution time. The query planner chooses between sequential scans, index scans, and bitmap scans based on statistics and cost estimation.',
    },
    {
      'title': '4. Extensions Ecosystem',
      'summary':
          'PostGIS adds geospatial queries. pg_trgm enables fuzzy text search. TimescaleDB adds time-series optimization. pgvector enables AI embedding similarity search. Extensions are PostgreSQL\'s superpower.',
    },
    {
      'title': '5. Replication & Scaling',
      'summary':
          'Streaming replication creates hot standby replicas for read scaling. Logical replication enables selective table replication. For writes, use Citus for distributed PostgreSQL or partitioning for large tables.',
    },
  ],
  'database transactions': [
    {
      'title': '1. ACID Properties',
      'summary':
          'Atomicity: all or nothing. Consistency: valid state to valid state. Isolation: concurrent transactions don\'t interfere. Durability: committed data survives crashes. ACID guarantees data integrity.',
    },
    {
      'title': '2. Isolation Levels',
      'summary':
          'Read Uncommitted (dirty reads possible). Read Committed (no dirty reads). Repeatable Read (no phantom reads in some DBs). Serializable (full isolation, lowest performance). Each level trades correctness for speed.',
    },
    {
      'title': '3. Locking Mechanisms',
      'summary':
          'Shared locks allow concurrent reads. Exclusive locks block other access. Row-level locking is finer-grained than table-level. Deadlocks occur when two transactions wait for each other\'s locks.',
    },
    {
      'title': '4. Optimistic vs Pessimistic',
      'summary':
          'Pessimistic locking acquires locks upfront (safe but slow). Optimistic concurrency checks for conflicts at commit time using version numbers. Optimistic is better for low-contention workloads.',
    },
    {
      'title': '5. Distributed Transactions',
      'summary':
          'Two-phase commit (2PC) coordinates transactions across multiple databases but is slow and blocking. Modern alternatives include the Saga pattern with compensating transactions for microservices.',
    },
  ],
  'acid properties': [
    {
      'title': '1. Atomicity',
      'summary':
          'A transaction is an indivisible unit — either all operations succeed or none do. If a bank transfer debits one account, it must credit the other. Partial completion is rolled back completely.',
    },
    {
      'title': '2. Consistency',
      'summary':
          'Transactions move the database from one valid state to another. All constraints (foreign keys, unique, check) must be satisfied after the transaction. Violations cause the transaction to abort.',
    },
    {
      'title': '3. Isolation',
      'summary':
          'Concurrent transactions appear to execute serially. Without isolation, one transaction might read another\'s uncommitted changes (dirty read) or see different values on re-read (phantom read).',
    },
    {
      'title': '4. Durability',
      'summary':
          'Once committed, data persists even after power failures or crashes. Databases achieve this through write-ahead logging (WAL) — changes are written to a durable log before being applied to data files.',
    },
    {
      'title': '5. BASE Alternative',
      'summary':
          'NoSQL systems often use BASE: Basically Available, Soft state, Eventually consistent. BASE trades strict ACID guarantees for higher availability and horizontal scalability in distributed systems.',
    },
  ],
  'database normalization': [
    {
      'title': '1. First Normal Form (1NF)',
      'summary':
          'Each column contains atomic (indivisible) values and each row is unique. No repeating groups or arrays within cells. This is the foundation — most tables naturally satisfy 1NF.',
    },
    {
      'title': '2. Second Normal Form (2NF)',
      'summary':
          '1NF plus every non-key column depends on the entire primary key, not just part of it. This eliminates partial dependencies in tables with composite primary keys.',
    },
    {
      'title': '3. Third Normal Form (3NF)',
      'summary':
          '2NF plus no transitive dependencies — non-key columns depend only on the primary key, not on other non-key columns. Example: remove city-to-zip dependencies from a customer table.',
    },
    {
      'title': '4. Denormalization Trade-offs',
      'summary':
          'Intentionally adding redundancy to reduce joins and improve read performance. Data warehouses and read-heavy applications often denormalize. This trades storage and write complexity for query speed.',
    },
    {
      'title': '5. Practical Guidelines',
      'summary':
          'Normalize to 3NF by default for transactional systems. Denormalize only when measured performance demands it. Over-normalization creates excessive joins; under-normalization causes update anomalies.',
    },
  ],
  'time series databases': [
    {
      'title': '1. Time-Stamped Data Model',
      'summary':
          'Every data point has a timestamp, metric name, value, and optional tags. This model optimizes for append-heavy writes and range queries over time windows, unlike general-purpose row stores.',
    },
    {
      'title': '2. Compression Techniques',
      'summary':
          'Delta encoding stores differences between consecutive timestamps. Gorilla compression (Facebook) achieves 12x compression for floating-point values. Compression is critical since time-series data grows rapidly.',
    },
    {
      'title': '3. Retention & Downsampling',
      'summary':
          'Raw data is retained for days/weeks, then downsampled to lower resolution (1-minute averages → 1-hour averages) for long-term storage. This balances detail with storage cost.',
    },
    {
      'title': '4. Popular Solutions',
      'summary':
          'InfluxDB (standalone, InfluxQL/Flux), TimescaleDB (PostgreSQL extension), Prometheus (metrics-focused), and ClickHouse (analytics). The choice depends on query patterns, scale, and existing infrastructure.',
    },
    {
      'title': '5. IoT & Monitoring Use Cases',
      'summary':
          'Sensor data, application metrics, financial tick data, and server monitoring are classic time-series workloads. The write-once, read-by-time-range pattern is what these databases optimize for.',
    },
  ],
  'graph databases': [
    {
      'title': '1. Property Graph Model',
      'summary':
          'Nodes represent entities, edges represent relationships, and both can have key-value properties. This model naturally maps to real-world concepts like social networks, org charts, and product catalogs.',
    },
    {
      'title': '2. Traversal Performance',
      'summary':
          'Graph databases store relationships as direct pointers (index-free adjacency). Traversing relationships is O(1) per hop regardless of total data size, unlike SQL joins which degrade with table size.',
    },
    {
      'title': '3. Cypher Query Language',
      'summary':
          'Neo4j\'s Cypher uses pattern matching: MATCH (a:Person)-[:KNOWS]->(b:Person) RETURN b. This visual syntax makes graph queries intuitive compared to recursive SQL CTEs.',
    },
    {
      'title': '4. Knowledge Graphs',
      'summary':
          'Google Knowledge Graph, Wikidata, and enterprise knowledge graphs connect entities with semantic relationships. Graph databases power search enrichment, recommendation engines, and fraud detection.',
    },
    {
      'title': '5. When to Use Graphs',
      'summary':
          'Use graph databases when relationships are the primary query target — social networks, recommendation engines, dependency analysis, and identity/access management. Avoid for simple CRUD or analytical aggregations.',
    },
  ],
  'solid principles': [
    {
      'title': '1. Single Responsibility',
      'summary':
          'A class should have only one reason to change. If a class handles both data persistence and email sending, split it into two. This reduces coupling and makes each class easier to test and maintain.',
    },
    {
      'title': '2. Open/Closed Principle',
      'summary':
          'Software entities should be open for extension but closed for modification. Add new behavior through new classes or modules, not by editing existing working code. Strategy and decorator patterns enable this.',
    },
    {
      'title': '3. Liskov Substitution',
      'summary':
          'Subclasses must be substitutable for their base classes without altering correctness. If a Square extends Rectangle but breaks when setWidth is called, the inheritance hierarchy is wrong.',
    },
    {
      'title': '4. Interface Segregation',
      'summary':
          'Clients should not be forced to depend on interfaces they don\'t use. Split large interfaces into smaller, focused ones. A Printer interface shouldn\'t force implementation of fax methods.',
    },
    {
      'title': '5. Dependency Inversion',
      'summary':
          'High-level modules should depend on abstractions, not concrete implementations. Inject dependencies through constructors or service locators. This enables testing with mocks and swapping implementations.',
    },
  ],
  'design patterns': [
    {
      'title': '1. Creational Patterns',
      'summary':
          'Singleton ensures one instance. Factory Method delegates instantiation. Builder separates construction from representation. Abstract Factory creates families of related objects. These control how objects are created.',
    },
    {
      'title': '2. Structural Patterns',
      'summary':
          'Adapter bridges incompatible interfaces. Decorator adds behavior dynamically. Facade simplifies complex subsystems. Proxy controls access to objects. These patterns compose objects to form larger structures.',
    },
    {
      'title': '3. Behavioral Patterns',
      'summary':
          'Observer enables pub/sub notifications. Strategy swaps algorithms at runtime. Command encapsulates actions as objects. State manages object behavior based on internal state. These manage object interactions.',
    },
    {
      'title': '4. Pattern Selection',
      'summary':
          'Don\'t force patterns — recognize when a problem matches one. The Observer pattern fits event systems. Strategy fits interchangeable algorithms. Repository fits data access abstraction.',
    },
    {
      'title': '5. Anti-Pattern Awareness',
      'summary':
          'God Object (does everything), Spaghetti Code (tangled dependencies), Golden Hammer (using one solution for everything). Recognizing anti-patterns is as important as knowing design patterns.',
    },
  ],
  'functional programming': [
    {
      'title': '1. Pure Functions',
      'summary':
          'A pure function always returns the same output for the same input and has no side effects. This makes functions predictable, testable, and safe for parallel execution.',
    },
    {
      'title': '2. Immutability',
      'summary':
          'Data structures are never modified — new copies are created instead. This eliminates entire categories of bugs related to shared mutable state and makes concurrent programming safe.',
    },
    {
      'title': '3. Higher-Order Functions',
      'summary':
          'Functions that take other functions as arguments or return functions. map, filter, reduce, and compose are fundamental. They enable powerful data transformation pipelines in a declarative style.',
    },
    {
      'title': '4. Pattern Matching & ADTs',
      'summary':
          'Algebraic Data Types (sum and product types) model data precisely. Pattern matching destructures data exhaustively. Together they provide type-safe handling of all possible cases.',
    },
    {
      'title': '5. Monads & Error Handling',
      'summary':
          'Maybe/Option handles nullable values. Either/Result handles errors. Future/Promise handles async operations. Monads chain computations while handling context (nullability, errors, async) transparently.',
    },
  ],
  'object-oriented design': [
    {
      'title': '1. Encapsulation',
      'summary':
          'Bundle data with the methods that operate on it. Hide internal state behind public interfaces. This protects invariants and allows internal implementation changes without breaking external code.',
    },
    {
      'title': '2. Inheritance vs Composition',
      'summary':
          'Inheritance creates "is-a" relationships but can lead to fragile hierarchies. Composition creates "has-a" relationships and is more flexible. Favor composition over inheritance as a default principle.',
    },
    {
      'title': '3. Polymorphism',
      'summary':
          'Objects of different types respond to the same method call in type-specific ways. This enables writing code against abstractions, with concrete behavior determined at runtime.',
    },
    {
      'title': '4. Abstraction Layers',
      'summary':
          'Define interfaces that hide complexity. A Repository interface abstracts database access. A Logger interface abstracts log destinations. Consumers code against interfaces, not implementations.',
    },
    {
      'title': '5. Class Design Heuristics',
      'summary':
          'Keep classes small (Single Responsibility). Minimize public API surface. Prefer immutable objects. Make illegal states unrepresentable through type design. Design for testability from the start.',
    },
  ],
  'test-driven development': [
    {
      'title': '1. Red-Green-Refactor',
      'summary':
          'Write a failing test (Red). Write the minimum code to make it pass (Green). Improve the code without changing behavior (Refactor). This cycle ensures every behavior is tested and code stays clean.',
    },
    {
      'title': '2. Test Pyramid',
      'summary':
          'Many unit tests (fast, isolated), fewer integration tests (component interaction), fewest end-to-end tests (full system). The pyramid balances coverage, speed, and maintenance cost.',
    },
    {
      'title': '3. Writing Good Tests',
      'summary':
          'Tests should be fast, isolated, repeatable, and self-checking. Use Arrange-Act-Assert structure. Test behavior, not implementation details. One assertion per test keeps failures clear.',
    },
    {
      'title': '4. Mocking & Stubbing',
      'summary':
          'Mocks verify interactions (was this method called?). Stubs provide canned responses. Fakes provide working implementations. Use mocking sparingly — over-mocking leads to brittle, tightly-coupled tests.',
    },
    {
      'title': '5. TDD Benefits & Criticism',
      'summary':
          'Benefits: better design, living documentation, regression safety, confident refactoring. Criticism: slower initial development, learning curve, not suitable for exploratory work. Use TDD where it adds value.',
    },
  ],
  'clean architecture': [
    {
      'title': '1. Dependency Rule',
      'summary':
          'Dependencies point inward — outer layers depend on inner layers, never the reverse. Domain entities are at the center, independent of frameworks, databases, and UI. This makes business logic portable.',
    },
    {
      'title': '2. Layer Structure',
      'summary':
          'Entities (business rules) → Use Cases (application logic) → Interface Adapters (controllers, presenters) → Frameworks (UI, database, web). Each layer has a clear responsibility and boundary.',
    },
    {
      'title': '3. Use Cases as First Class',
      'summary':
          'Each use case is an explicit class that orchestrates business logic. This makes application behavior discoverable, testable, and independent of delivery mechanism (web, CLI, mobile).',
    },
    {
      'title': '4. Interface Adapters',
      'summary':
          'Controllers convert external requests to use case inputs. Presenters convert use case outputs to view models. Gateways abstract data access. These adapters protect core logic from external change.',
    },
    {
      'title': '5. Testing Strategy',
      'summary':
          'Business rules are tested with unit tests (no framework dependencies). Use cases are tested with mocked gateways. Integration tests verify adapters. This gives fast, reliable test suites.',
    },
  ],
  'dependency injection': [
    {
      'title': '1. Inversion of Control',
      'summary':
          'Instead of a class creating its own dependencies, they are provided (injected) from the outside. This inverts the typical control flow and is the foundation of testable, modular architecture.',
    },
    {
      'title': '2. Injection Types',
      'summary':
          'Constructor injection (preferred — dependencies are required). Setter injection (optional dependencies). Interface injection (the dependency provides an injector method). Constructor injection makes dependencies explicit.',
    },
    {
      'title': '3. DI Containers',
      'summary':
          'Frameworks like Dagger, Spring, and GetIt manage object creation and lifetime. They resolve dependency graphs automatically, creating and wiring objects based on registered bindings.',
    },
    {
      'title': '4. Testability Benefits',
      'summary':
          'DI enables swapping real implementations with test doubles (mocks, stubs, fakes). A service that accepts a Repository interface can be tested with an in-memory implementation instead of a real database.',
    },
    {
      'title': '5. Scope & Lifetime',
      'summary':
          'Singleton scope creates one instance for the app lifetime. Transient scope creates a new instance per request. Scoped creates one per logical scope (e.g., per HTTP request). Mismatched scopes cause subtle bugs.',
    },
  ],
  'reactive programming': [
    {
      'title': '1. Observable Streams',
      'summary':
          'Data flows as streams of events over time. Observables emit values, errors, and completion signals. Subscribers react to these emissions asynchronously, enabling responsive and resilient applications.',
    },
    {
      'title': '2. Operators',
      'summary':
          'map transforms values. filter selects values. debounce waits for pauses. merge combines streams. switchMap cancels previous work. These operators compose to build complex async data pipelines declaratively.',
    },
    {
      'title': '3. Backpressure',
      'summary':
          'When producers emit faster than consumers can process, backpressure strategies handle the overflow: buffer (store), drop (discard), throttle (slow down), or signal the producer to pause.',
    },
    {
      'title': '4. RxDart & Flutter',
      'summary':
          'RxDart extends Dart\'s Stream with Observable operators. BehaviorSubject caches the latest value. CombineLatest merges multiple streams. StreamBuilder connects reactive streams to Flutter widgets.',
    },
    {
      'title': '5. Error Handling',
      'summary':
          'Errors propagate through the stream pipeline. onErrorReturn provides fallback values. retry resubscribes on failure. catchError transforms errors. Unhandled stream errors can crash the application.',
    },
  ],
  'domain-driven design': [
    {
      'title': '1. Ubiquitous Language',
      'summary':
          'Developers and domain experts use the same vocabulary in code, documentation, and conversation. If the business calls it an "Order", the code class is Order, not PurchaseTransaction.',
    },
    {
      'title': '2. Bounded Contexts',
      'summary':
          'Large systems are divided into bounded contexts, each with its own model and language. A "User" in the Authentication context differs from a "User" in the Billing context. Context maps define relationships.',
    },
    {
      'title': '3. Entities & Value Objects',
      'summary':
          'Entities have identity (two Users with same name are different). Value Objects have no identity (two Money(10, USD) are interchangeable). Value Objects should be immutable.',
    },
    {
      'title': '4. Aggregates',
      'summary':
          'An Aggregate is a cluster of domain objects treated as a unit for data changes. The Aggregate Root is the only entry point. Order (root) contains OrderItems. External references go through the root.',
    },
    {
      'title': '5. Domain Events',
      'summary':
          'Events capture meaningful business occurrences: OrderPlaced, PaymentReceived, ShipmentDispatched. They enable loose coupling between bounded contexts and are the foundation of event-driven architectures.',
    },
  ],
  'hexagonal architecture': [
    {
      'title': '1. Ports & Adapters',
      'summary':
          'The application core defines ports (interfaces). Adapters implement these ports for specific technologies. A DatabasePort might have a PostgresAdapter and a MongoAdapter. The core never references adapters directly.',
    },
    {
      'title': '2. Inside vs Outside',
      'summary':
          'The inside (hexagon) contains business logic and is technology-agnostic. The outside contains HTTP controllers, database implementations, and message queue consumers. Dependencies point inward only.',
    },
    {
      'title': '3. Driving vs Driven',
      'summary':
          'Driving adapters initiate actions (REST controller calls use case). Driven adapters are called by the core (use case calls database port). This distinction clarifies the flow of control.',
    },
    {
      'title': '4. Testing Benefits',
      'summary':
          'The core is tested with unit tests using in-memory adapters. No database, HTTP, or framework needed. Integration tests verify real adapters. This separation provides fast, reliable test suites.',
    },
    {
      'title': '5. Relationship to Clean Architecture',
      'summary':
          'Hexagonal architecture and Clean Architecture express the same principle: protect business logic from infrastructure. Hexagonal emphasizes ports/adapters; Clean Architecture emphasizes concentric layers.',
    },
  ],
  'machine learning': [
    {
      'title': '1. Supervised vs Unsupervised',
      'summary':
          'Supervised learning trains on labeled data (input→output pairs). Unsupervised learning finds patterns in unlabeled data (clustering, dimensionality reduction). Semi-supervised combines both approaches.',
    },
    {
      'title': '2. Training Pipeline',
      'summary':
          'Data collection → preprocessing → feature engineering → model selection → training → evaluation → deployment. Each step requires careful attention; garbage data in means garbage predictions out.',
    },
    {
      'title': '3. Bias-Variance Trade-off',
      'summary':
          'High bias (underfitting) means the model is too simple. High variance (overfitting) means it memorizes training data. The goal is finding the sweet spot through cross-validation and regularization.',
    },
    {
      'title': '4. Classification vs Regression',
      'summary':
          'Classification predicts categories (spam/not spam). Regression predicts continuous values (house price). Logistic regression, decision trees, and SVMs handle classification. Linear regression handles continuous predictions.',
    },
    {
      'title': '5. Model Deployment',
      'summary':
          'Trained models are served via REST APIs, embedded in mobile apps (TensorFlow Lite), or run at the edge. Model monitoring detects drift — when real-world data diverges from training data.',
    },
  ],
  'neural networks': [
    {
      'title': '1. Neuron & Activation',
      'summary':
          'A neuron computes a weighted sum of inputs plus a bias, then applies an activation function. ReLU (max(0,x)) is the most common activation. Networks of neurons learn complex non-linear mappings.',
    },
    {
      'title': '2. Backpropagation',
      'summary':
          'The chain rule computes gradients of the loss with respect to each weight, flowing backward through the network. These gradients tell each weight how to adjust to reduce prediction error.',
    },
    {
      'title': '3. Architecture Choices',
      'summary':
          'Feedforward networks for tabular data. CNNs for images (spatial patterns). RNNs/LSTMs for sequences (text, time series). Transformers for attention-based processing (GPT, BERT).',
    },
    {
      'title': '4. Regularization',
      'summary':
          'Dropout randomly disables neurons during training, preventing co-adaptation. L1/L2 regularization penalizes large weights. Batch normalization stabilizes training. All combat overfitting.',
    },
    {
      'title': '5. Training Challenges',
      'summary':
          'Vanishing gradients make deep networks hard to train (solved by ReLU, residual connections). Exploding gradients cause instability (solved by gradient clipping). Learning rate scheduling optimizes convergence.',
    },
  ],
  'natural language processing': [
    {
      'title': '1. Text Preprocessing',
      'summary':
          'Tokenization splits text into words/subwords. Lowercasing, stopword removal, and stemming/lemmatization normalize text. Byte Pair Encoding (BPE) handles unknown words in neural models.',
    },
    {
      'title': '2. Word Embeddings',
      'summary':
          'Word2Vec and GloVe map words to dense vectors where similar words have similar vectors. "King - Man + Woman ≈ Queen" demonstrates semantic relationships captured in vector space.',
    },
    {
      'title': '3. Sequence Models',
      'summary':
          'RNNs process text sequentially but struggle with long dependencies. LSTMs add gating mechanisms to remember long-range context. Attention mechanisms let the model focus on relevant parts of the input.',
    },
    {
      'title': '4. Transformers & LLMs',
      'summary':
          'Self-attention processes all tokens simultaneously, enabling parallelism. GPT (autoregressive) generates text. BERT (bidirectional) understands context. These models are the foundation of modern NLP.',
    },
    {
      'title': '5. Applications',
      'summary':
          'Machine translation, sentiment analysis, named entity recognition, question answering, summarization, and chatbots. Pre-trained models (fine-tuned on specific data) have democratized NLP capabilities.',
    },
  ],
  'computer vision': [
    {
      'title': '1. Convolutional Neural Networks',
      'summary':
          'CNNs use learnable filters that slide over images to detect edges, textures, and shapes. Deeper layers combine these features into high-level concepts like faces, objects, and scenes.',
    },
    {
      'title': '2. Image Classification',
      'summary':
          'Assigns labels to images (cat, dog, car). Architectures like ResNet, VGG, and EfficientNet achieve human-level accuracy. Transfer learning from ImageNet pre-training accelerates custom classification tasks.',
    },
    {
      'title': '3. Object Detection',
      'summary':
          'Locates and classifies multiple objects in an image with bounding boxes. YOLO (real-time), SSD, and Faster R-CNN are popular architectures. Applications include autonomous driving and security surveillance.',
    },
    {
      'title': '4. Image Segmentation',
      'summary':
          'Pixel-level classification: semantic segmentation labels every pixel, instance segmentation distinguishes individual objects. U-Net and Mask R-CNN are key architectures for medical imaging and autonomous vehicles.',
    },
    {
      'title': '5. Data Augmentation',
      'summary':
          'Random flips, rotations, crops, color jittering, and mixup artificially expand training data. This reduces overfitting and improves model robustness. Augmentation is critical when labeled data is limited.',
    },
  ],
  'reinforcement learning': [
    {
      'title': '1. Agent-Environment Loop',
      'summary':
          'An agent takes actions in an environment, receives rewards, and updates its policy to maximize cumulative reward. This trial-and-error learning requires no labeled data, unlike supervised learning.',
    },
    {
      'title': '2. Exploration vs Exploitation',
      'summary':
          'Exploration tries new actions to discover better strategies. Exploitation uses known good actions for immediate reward. Epsilon-greedy balances both: explore with probability ε, exploit otherwise.',
    },
    {
      'title': '3. Q-Learning',
      'summary':
          'Learns a Q-function mapping (state, action) pairs to expected rewards. Deep Q-Networks (DQN) use neural networks to approximate Q-values for high-dimensional state spaces like Atari games.',
    },
    {
      'title': '4. Policy Gradient Methods',
      'summary':
          'Directly optimize the policy (action probabilities given state) using gradient ascent. PPO and A3C are popular algorithms. Policy gradients handle continuous action spaces better than Q-learning.',
    },
    {
      'title': '5. Applications',
      'summary':
          'Game playing (AlphaGo, chess), robotics (manipulation, locomotion), recommendation systems, resource management, and drug discovery. RL excels where the reward signal is clear but the optimal strategy is unknown.',
    },
  ],
  'transformer architecture': [
    {
      'title': '1. Self-Attention Mechanism',
      'summary':
          'Each token attends to every other token, computing attention weights based on query-key-value projections. This captures long-range dependencies without the sequential bottleneck of RNNs.',
    },
    {
      'title': '2. Multi-Head Attention',
      'summary':
          'Multiple attention heads learn different relationship types simultaneously — one head might capture syntax, another semantics. Outputs are concatenated and projected, providing rich representations.',
    },
    {
      'title': '3. Positional Encoding',
      'summary':
          'Since self-attention is permutation-invariant, positional encodings (sinusoidal or learned) inject sequence order information. Without them, the model couldn\'t distinguish "dog bites man" from "man bites dog".',
    },
    {
      'title': '4. Encoder-Decoder Structure',
      'summary':
          'The encoder processes input (BERT-style). The decoder generates output autoregressively (GPT-style). Translation models use both. Modern LLMs often use decoder-only architectures for simplicity.',
    },
    {
      'title': '5. Scaling Laws',
      'summary':
          'Model performance improves predictably with more parameters, data, and compute (Chinchilla scaling laws). This insight drives the trend toward larger models and has defined the modern AI scaling paradigm.',
    },
  ],
  'gradient descent': [
    {
      'title': '1. Optimization Objective',
      'summary':
          'Gradient descent minimizes a loss function by iteratively moving in the direction of steepest decrease (negative gradient). The loss measures how wrong the model\'s predictions are.',
    },
    {
      'title': '2. Learning Rate',
      'summary':
          'The step size in each iteration. Too large: overshoots the minimum and diverges. Too small: converges painfully slowly. Learning rate schedulers (cosine annealing, warm-up) adapt the rate during training.',
    },
    {
      'title': '3. Stochastic & Mini-Batch',
      'summary':
          'Batch GD uses all data per step (accurate but slow). SGD uses one sample (fast but noisy). Mini-batch (32-256 samples) balances speed and stability, and is the standard in deep learning.',
    },
    {
      'title': '4. Advanced Optimizers',
      'summary':
          'Adam combines momentum (past gradients) with RMSprop (adaptive learning rates). AdamW adds proper weight decay. These converge faster than vanilla SGD and require less learning rate tuning.',
    },
    {
      'title': '5. Convergence Challenges',
      'summary':
          'Saddle points, local minima, and plateaus can trap optimization. Skip connections, batch normalization, and proper initialization help navigate these challenges in deep neural networks.',
    },
  ],
  'feature engineering': [
    {
      'title': '1. Domain Knowledge Encoding',
      'summary':
          'Transform raw data into informative features using domain expertise. For housing prices: distance to school, crime rate, lot area ratio. Good features can outperform complex models with poor features.',
    },
    {
      'title': '2. Numerical Transformations',
      'summary':
          'Scaling (min-max, standard), log transforms for skewed data, polynomial features for non-linear relationships, and binning continuous values into categories. These help models learn patterns more effectively.',
    },
    {
      'title': '3. Categorical Encoding',
      'summary':
          'One-hot encoding for nominal categories. Ordinal encoding for ordered categories. Target encoding for high-cardinality features. Embedding layers learn dense representations in neural networks.',
    },
    {
      'title': '4. Feature Selection',
      'summary':
          'Remove irrelevant and redundant features to reduce overfitting. Correlation analysis, mutual information, and L1 regularization identify important features. Fewer good features often beat many mediocre ones.',
    },
    {
      'title': '5. Automated Feature Engineering',
      'summary':
          'Tools like Featuretools and AutoML frameworks generate features automatically through aggregation, time-windowing, and cross-feature operations. These complement but don\'t replace domain expertise.',
    },
  ],
  'model evaluation': [
    {
      'title': '1. Train-Test Split',
      'summary':
          'Never evaluate on training data — it hides overfitting. Use 80/20 or 70/30 splits. K-fold cross-validation uses all data for both training and testing, providing more robust estimates.',
    },
    {
      'title': '2. Classification Metrics',
      'summary':
          'Accuracy is misleading for imbalanced data. Precision (of predicted positives, how many are correct) and recall (of actual positives, how many were found) trade off. F1 score balances both.',
    },
    {
      'title': '3. Regression Metrics',
      'summary':
          'MAE (mean absolute error) is interpretable. MSE/RMSE penalizes large errors more. R² measures explained variance (1.0 is perfect). Choose the metric that aligns with your business cost of errors.',
    },
    {
      'title': '4. Confusion Matrix',
      'summary':
          'A 2x2 table of true positives, false positives, true negatives, and false negatives. It reveals error patterns: is the model missing positives (low recall) or raising false alarms (low precision)?',
    },
    {
      'title': '5. ROC & AUC',
      'summary':
          'The ROC curve plots true positive rate vs false positive rate at various thresholds. AUC (Area Under Curve) summarizes overall discrimination ability. AUC = 1.0 is perfect; 0.5 is random guessing.',
    },
  ],
  'transfer learning': [
    {
      'title': '1. Pre-Trained Models',
      'summary':
          'Models trained on large datasets (ImageNet, WebText) learn general features transferable to new tasks. Fine-tuning a pre-trained model requires far less data and compute than training from scratch.',
    },
    {
      'title': '2. Feature Extraction',
      'summary':
          'Freeze pre-trained layers and only train a new output head. The pre-trained network acts as a fixed feature extractor. This works well when your dataset is small and similar to the pre-training data.',
    },
    {
      'title': '3. Fine-Tuning Strategies',
      'summary':
          'Unfreeze some or all layers and train with a small learning rate. Fine-tune later layers first (task-specific) before earlier layers (general features). Gradual unfreezing prevents catastrophic forgetting.',
    },
    {
      'title': '4. Domain Adaptation',
      'summary':
          'When source and target domains differ significantly, domain adaptation techniques align feature distributions. This is critical when pre-training data (web images) differs from deployment data (medical scans).',
    },
    {
      'title': '5. Foundation Models',
      'summary':
          'Large pre-trained models (GPT, BERT, CLIP) serve as foundations adapted to countless downstream tasks. This paradigm has transformed NLP, computer vision, and increasingly science and engineering.',
    },
  ],
  'cryptography basics': [
    {
      'title': '1. Symmetric Encryption',
      'summary':
          'The same key encrypts and decrypts data. AES-256 is the gold standard. Fast and efficient for bulk data. The challenge is securely sharing the secret key between parties.',
    },
    {
      'title': '2. Asymmetric Encryption',
      'summary':
          'Public key encrypts; private key decrypts. RSA and elliptic curve (ECC) are common. Slower than symmetric but solves key distribution. Used for key exchange, digital signatures, and TLS handshakes.',
    },
    {
      'title': '3. Hashing',
      'summary':
          'One-way functions that produce fixed-size digests. SHA-256 is widely used. Properties: deterministic, fast, and collision-resistant. Used for password storage (with salt), data integrity, and digital signatures.',
    },
    {
      'title': '4. Digital Signatures',
      'summary':
          'The sender hashes a message and encrypts the hash with their private key. The recipient decrypts with the public key and verifies the hash matches. This provides authentication and non-repudiation.',
    },
    {
      'title': '5. Key Management',
      'summary':
          'Keys must be generated securely, stored safely (HSMs, vaults), rotated periodically, and revoked when compromised. Key management is the hardest part of cryptography — most breaches target keys, not algorithms.',
    },
  ],
  'sql injection': [
    {
      'title': '1. Attack Mechanism',
      'summary':
          'Attackers insert malicious SQL into user inputs. If the app concatenates input directly into queries, the injected SQL executes with the database\'s privileges, potentially exposing or destroying all data.',
    },
    {
      'title': '2. Types of SQL Injection',
      'summary':
          'Classic (visible error messages). Blind (no errors shown, uses true/false queries). Time-based blind (uses sleep delays to infer data). Second-order (payload stored and triggered later).',
    },
    {
      'title': '3. Parameterized Queries',
      'summary':
          'The primary defense. Use placeholders (?  or :name) and bind parameters separately. The database treats parameters as data, never as executable SQL. This prevents injection by design.',
    },
    {
      'title': '4. Additional Defenses',
      'summary':
          'Input validation (whitelist allowed characters). Least privilege database accounts. Web Application Firewalls (WAFs). Escaping special characters. Defense in depth uses multiple layers.',
    },
    {
      'title': '5. Detection & Testing',
      'summary':
          'SQLMap automates injection detection and exploitation. OWASP ZAP provides proxy-based scanning. Code review and static analysis tools catch vulnerable query construction in source code.',
    },
  ],
  'cross-site scripting': [
    {
      'title': '1. XSS Attack Types',
      'summary':
          'Stored XSS persists in the database (comments, profiles). Reflected XSS comes from URL parameters. DOM-based XSS manipulates client-side scripts without server involvement. Stored is most dangerous.',
    },
    {
      'title': '2. Impact',
      'summary':
          'Stolen session cookies enable account hijacking. Keyloggers capture credentials. Defaced pages damage trust. Worm propagation (Samy worm) can compromise entire platforms. XSS is consistently in the OWASP Top 10.',
    },
    {
      'title': '3. Output Encoding',
      'summary':
          'The primary defense: encode all dynamic content before rendering in HTML, JavaScript, CSS, or URLs. < becomes &lt;, " becomes &quot;. Context-specific encoding prevents script execution.',
    },
    {
      'title': '4. Content Security Policy',
      'summary':
          'CSP headers restrict which scripts can execute. script-src \'self\' blocks inline scripts and external sources. This is a powerful second line of defense even if encoding is missed somewhere.',
    },
    {
      'title': '5. Framework Protections',
      'summary':
          'Modern frameworks (React, Angular, Flutter) auto-escape output by default. Never use dangerouslySetInnerHTML (React) or bypass sanitization without careful review. Trust no user input.',
    },
  ],
  'https & tls': [
    {
      'title': '1. TLS Handshake',
      'summary':
          'Client Hello → Server Hello + Certificate → Key Exchange → Finished. The handshake negotiates cipher suites, authenticates the server via certificates, and establishes a shared session key for encryption.',
    },
    {
      'title': '2. Certificate Authority System',
      'summary':
          'CAs verify domain ownership and issue signed certificates. Browsers trust a set of root CAs. Let\'s Encrypt provides free automated certificates. Certificate transparency logs prevent rogue certificates.',
    },
    {
      'title': '3. TLS 1.3 Improvements',
      'summary':
          'Reduced handshake to 1 round trip (from 2 in TLS 1.2). Removed insecure cipher suites. 0-RTT resumption for returning clients. All modern deployments should use TLS 1.3 exclusively.',
    },
    {
      'title': '4. HSTS & Security Headers',
      'summary':
          'HTTP Strict Transport Security forces HTTPS for all future visits. Prevents SSL-stripping attacks. Combined with preload lists, the browser never makes an insecure request to your domain.',
    },
    {
      'title': '5. Certificate Pinning',
      'summary':
          'Mobile apps can pin expected certificates, rejecting connections from unexpected CAs (even if trusted by the OS). This prevents man-in-the-middle attacks but complicates certificate rotation.',
    },
  ],
  'zero trust security': [
    {
      'title': '1. Never Trust, Always Verify',
      'summary':
          'Traditional security trusts everything inside the network perimeter. Zero Trust assumes no implicit trust — every request is authenticated, authorized, and encrypted regardless of network location.',
    },
    {
      'title': '2. Identity-Centric Access',
      'summary':
          'Identity replaces network location as the security perimeter. Multi-factor authentication, single sign-on, and continuous authentication verify users. Device health is also evaluated before granting access.',
    },
    {
      'title': '3. Least Privilege Access',
      'summary':
          'Users and services get the minimum permissions needed for their role. Just-in-time access grants elevated privileges temporarily. This limits blast radius when credentials are compromised.',
    },
    {
      'title': '4. Microsegmentation',
      'summary':
          'Network segments are granularly divided so resources are isolated. Even if an attacker breaches one segment, lateral movement is blocked. Service meshes and software-defined networking enable microsegmentation.',
    },
    {
      'title': '5. Continuous Monitoring',
      'summary':
          'Every access is logged and analyzed in real-time. Anomaly detection flags unusual behavior (login from new location, unusual data access). SIEM systems correlate events across the entire infrastructure.',
    },
  ],
  'concurrency': [
    {
      'title': '1. Threads vs Processes',
      'summary':
          'Processes have separate memory spaces (safe but expensive to create). Threads share memory within a process (dangerous but efficient). Languages like Go use lightweight goroutines for massive concurrency.',
    },
    {
      'title': '2. Race Conditions',
      'summary':
          'When multiple threads access shared data without synchronization, results depend on execution order. Read-modify-write operations are especially vulnerable. Race conditions cause subtle, hard-to-reproduce bugs.',
    },
    {
      'title': '3. Synchronization Primitives',
      'summary':
          'Mutexes ensure exclusive access. Semaphores control concurrent access count. Condition variables enable waiting for conditions. Read-write locks allow concurrent reads but exclusive writes.',
    },
    {
      'title': '4. Deadlock Prevention',
      'summary':
          'Deadlock occurs when threads wait for each other\'s locks in a cycle. Prevention strategies: lock ordering (always acquire in the same order), timeouts, and lock-free data structures.',
    },
    {
      'title': '5. Async/Await Pattern',
      'summary':
          'Non-blocking concurrency using futures/promises. The event loop handles I/O without threads. Dart, JavaScript, and Python use async/await for readable asynchronous code. Ideal for I/O-bound tasks.',
    },
  ],
  'webassembly': [
    {
      'title': '1. Binary Instruction Format',
      'summary':
          'WebAssembly (Wasm) is a portable binary format designed to run at near-native speed. It compiles from C, C++, Rust, and Go, bringing their performance to the browser.',
    },
    {
      'title': '2. Browser Integration',
      'summary':
          'Wasm modules are loaded via JavaScript and run in a sandboxed environment. They can access DOM through JS interop. This enables compute-heavy tasks (image processing, games) in the browser.',
    },
    {
      'title': '3. Performance Characteristics',
      'summary':
          'Wasm is 10-100x faster than JavaScript for CPU-intensive tasks. Predictable performance (no garbage collection pauses). Linear memory model enables efficient C-style memory access.',
    },
    {
      'title': '4. Beyond the Browser',
      'summary':
          'WASI (WebAssembly System Interface) enables Wasm outside browsers — serverless functions, plugins, and edge computing. Wasmtime and Wasmer provide standalone Wasm runtimes.',
    },
    {
      'title': '5. Use Cases',
      'summary':
          'Game engines (Unity WebGL), video/audio processing, CAD applications, scientific computing, and extending applications with sandboxed plugins. Any performance-critical browser task benefits from Wasm.',
    },
  ],
  'edge computing': [
    {
      'title': '1. Computing at the Periphery',
      'summary':
          'Edge computing processes data closer to its source (IoT devices, cell towers) rather than sending it to centralized cloud data centers. This reduces latency, bandwidth costs, and enables offline processing.',
    },
    {
      'title': '2. vs Cloud Computing',
      'summary':
          'Cloud is centralized with vast resources. Edge is distributed with limited resources. The right architecture is usually hybrid: edge handles time-sensitive processing, cloud handles heavy analytics.',
    },
    {
      'title': '3. CDN Evolution',
      'summary':
          'Modern CDN workers (Cloudflare Workers, AWS Lambda@Edge) run application code at edge locations. This enables personalization, A/B testing, and API responses with sub-10ms latency globally.',
    },
    {
      'title': '4. IoT Applications',
      'summary':
          'Self-driving cars can\'t wait for cloud round-trips. Manufacturing sensors need real-time anomaly detection. Security cameras process video locally. Edge computing makes latency-critical IoT feasible.',
    },
    {
      'title': '5. Challenges',
      'summary':
          'Limited compute and storage at the edge. Firmware updates across thousands of devices. Data consistency between edge and cloud. Security of physically accessible hardware. Device heterogeneity complicates deployment.',
    },
  ],
  'blockchain basics': [
    {
      'title': '1. Distributed Ledger',
      'summary':
          'A blockchain is an append-only chain of blocks, each containing a hash of the previous block. This creates a tamper-evident record distributed across many nodes with no central authority.',
    },
    {
      'title': '2. Consensus Mechanisms',
      'summary':
          'Proof of Work (mining, energy-intensive). Proof of Stake (validators stake tokens). Both solve the double-spending problem. PoS is more energy-efficient and is now used by Ethereum.',
    },
    {
      'title': '3. Smart Contracts',
      'summary':
          'Self-executing code deployed on the blockchain. Solidity is Ethereum\'s smart contract language. Once deployed, the code is immutable and executes exactly as written, enabling trustless agreements.',
    },
    {
      'title': '4. Beyond Cryptocurrency',
      'summary':
          'Supply chain tracking, digital identity, NFTs (unique digital ownership), decentralized finance (DeFi), and voting systems. Blockchain\'s value is in trustless, transparent, immutable record-keeping.',
    },
    {
      'title': '5. Limitations',
      'summary':
          'Low transaction throughput compared to traditional databases. High energy consumption (PoW). Immutability makes bug fixes difficult. Regulatory uncertainty. Most applications don\'t actually need blockchain.',
    },
  ],
  'serverless architecture': [
    {
      'title': '1. Functions as a Service',
      'summary':
          'Write individual functions that run in response to events. AWS Lambda, Google Cloud Functions, and Azure Functions handle all infrastructure. You pay only for actual execution time, not idle servers.',
    },
    {
      'title': '2. Event-Driven Execution',
      'summary':
          'Functions are triggered by HTTP requests, database changes, file uploads, queue messages, or scheduled timers. This event-driven model eliminates the need for always-on servers waiting for requests.',
    },
    {
      'title': '3. Scaling & Cold Starts',
      'summary':
          'Serverless auto-scales from zero to thousands of concurrent instances. Cold starts (initialization delay) affect latency for the first request. Provisioned concurrency and smaller runtimes mitigate this.',
    },
    {
      'title': '4. Vendor Lock-In & Portability',
      'summary':
          'Each cloud provider has proprietary APIs and integrations. Serverless Framework and SAM abstract some differences. Business logic should be isolated from cloud-specific glue code for portability.',
    },
    {
      'title': '5. When to Use Serverless',
      'summary':
          'Ideal for event processing, APIs with variable traffic, background jobs, and prototypes. Less suitable for long-running processes, real-time WebSocket connections, or compute-intensive workloads.',
    },
  ],
};
