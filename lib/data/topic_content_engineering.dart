/// Pre-generated content for Web, DevOps, Databases, and Programming Paradigms topics.
const Map<String, List<Map<String, String>>> engineeringContent = {
  'api gateway': [
    {
      'title': '1. Single Entry Point',
      'summary':
          'An API gateway serves as the single entry point for all client requests, routing them to appropriate microservices. It simplifies client logic by providing a unified interface.',
    },
    {
      'title': '2. Cross-Cutting Concerns',
      'summary':
          'Handles authentication, rate limiting, SSL termination, and logging in one place. This avoids duplicating these concerns across every microservice.',
    },
    {
      'title': '3. Request Transformation',
      'summary':
          'Can aggregate responses from multiple services, transform protocols (REST to gRPC), and reshape payloads. This enables backend flexibility without breaking client contracts.',
    },
    {
      'title': '4. Popular Solutions',
      'summary':
          'Kong, AWS API Gateway, Nginx, and Envoy are widely used. Each offers different trade-offs in extensibility, performance, and managed vs self-hosted deployment.',
    },
    {
      'title': '5. Gateway vs Service Mesh',
      'summary':
          'Gateways handle north-south traffic (client to services). Service meshes handle east-west traffic (service to service). Modern architectures often use both together.',
    },
  ],
  'event-driven architecture': [
    {
      'title': '1. Event Producers & Consumers',
      'summary':
          'Producers emit events when state changes occur. Consumers subscribe to relevant events and react independently. This decouples components and enables asynchronous processing.',
    },
    {
      'title': '2. Event Types',
      'summary':
          'Domain events represent business facts (OrderPlaced). Integration events cross service boundaries. Commands request actions; events report what happened. The distinction drives clean architecture.',
    },
    {
      'title': '3. Event Brokers',
      'summary':
          'Kafka provides durable, ordered event logs. RabbitMQ offers flexible routing. AWS EventBridge handles serverless event routing. The broker choice impacts durability, ordering, and throughput.',
    },
    {
      'title': '4. Eventual Consistency',
      'summary':
          'Event-driven systems embrace eventual consistency. Services update independently and converge over time. Saga patterns coordinate multi-service transactions through compensating events.',
    },
    {
      'title': '5. Event Sourcing',
      'summary':
          'Instead of storing current state, store every event that led to it. This provides a complete audit trail, enables temporal queries, and allows rebuilding state from any point in time.',
    },
  ],
  'cap theorem': [
    {
      'title': '1. The Three Guarantees',
      'summary':
          'Consistency: every read receives the most recent write. Availability: every request gets a response. Partition tolerance: the system works despite network splits. You can only guarantee two of three.',
    },
    {
      'title': '2. CP Systems',
      'summary':
          'CP systems sacrifice availability during partitions. HBase and MongoDB (strong consistency mode) choose consistency — reads may fail during network issues, but never return stale data.',
    },
    {
      'title': '3. AP Systems',
      'summary':
          'AP systems sacrifice consistency during partitions. Cassandra and DynamoDB choose availability — they always respond but may return slightly stale data that eventually converges.',
    },
    {
      'title': '4. PACELC Extension',
      'summary':
          'PACELC adds: even without Partitions, there is a trade-off between Latency and Consistency. This better explains real-world systems where partition events are rare but latency matters always.',
    },
    {
      'title': '5. Practical Implications',
      'summary':
          'Choose CP for financial transactions and inventory counts. Choose AP for social media feeds and caching. Most real systems use different consistency levels for different data within the same application.',
    },
  ],
  'distributed systems': [
    {
      'title': '1. Fallacies of Distribution',
      'summary':
          'The network is reliable, latency is zero, bandwidth is infinite — these are all false. Distributed systems must handle partial failures, network delays, and message loss as normal conditions.',
    },
    {
      'title': '2. Consensus Protocols',
      'summary':
          'Paxos and Raft enable multiple nodes to agree on a value despite failures. Raft is more understandable and is used in etcd, CockroachDB, and Consul for leader election and state replication.',
    },
    {
      'title': '3. Clock Synchronization',
      'summary':
          'Physical clocks drift. Logical clocks (Lamport timestamps) and vector clocks establish causal ordering without synchronized time. Google\'s TrueTime uses GPS and atomic clocks for bounded uncertainty.',
    },
    {
      'title': '4. Replication Strategies',
      'summary':
          'Single-leader replication is simple but has a bottleneck. Multi-leader handles geo-distribution. Leaderless (Dynamo-style) uses quorum reads/writes for high availability.',
    },
    {
      'title': '5. Failure Detection',
      'summary':
          'Heartbeat mechanisms and phi-accrual failure detectors distinguish between crashed and slow nodes. Accurate failure detection is critical for maintaining cluster health and triggering failover.',
    },
  ],
  'consistent hashing': [
    {
      'title': '1. The Ring Concept',
      'summary':
          'Nodes and keys are mapped to positions on a circular hash space using a hash function. Each key is assigned to the first node encountered clockwise from its position on the ring.',
    },
    {
      'title': '2. Minimal Disruption',
      'summary':
          'When a node is added or removed, only K/N keys need to be remapped (K=keys, N=nodes). Traditional hashing would remap almost all keys, making it unsuitable for dynamic clusters.',
    },
    {
      'title': '3. Virtual Nodes',
      'summary':
          'Each physical node is mapped to multiple virtual positions on the ring. This ensures even distribution even with heterogeneous hardware and prevents hotspots from uneven hashing.',
    },
    {
      'title': '4. Use in Databases',
      'summary':
          'Cassandra, DynamoDB, and Riak use consistent hashing for data partitioning. It enables linear horizontal scaling by simply adding nodes to the ring without full data redistribution.',
    },
    {
      'title': '5. Load Balancing Applications',
      'summary':
          'Consistent hashing is used in CDNs and caches to route requests to the same server for a given key, enabling effective caching while handling server additions and removals gracefully.',
    },
  ],
  'rate limiting': [
    {
      'title': '1. Why Rate Limit',
      'summary':
          'Rate limiting prevents abuse, protects backend resources, ensures fair usage among users, and guards against DDoS attacks. It is essential for any public-facing API or service.',
    },
    {
      'title': '2. Token Bucket Algorithm',
      'summary':
          'A bucket holds tokens that are consumed per request and refilled at a fixed rate. Allows bursts up to bucket capacity while maintaining a long-term average rate. Most popular approach.',
    },
    {
      'title': '3. Sliding Window Counter',
      'summary':
          'Tracks request counts in time windows. The sliding variant smooths the boundary between windows by weighting the previous window. More accurate than fixed windows with reasonable memory cost.',
    },
    {
      'title': '4. Distributed Rate Limiting',
      'summary':
          'In multi-server deployments, rate limits must be coordinated. Redis is commonly used as a shared counter store. Race conditions are handled with Lua scripts or Redis transactions.',
    },
    {
      'title': '5. Response Headers',
      'summary':
          'APIs communicate rate limit status via headers: X-RateLimit-Limit, X-RateLimit-Remaining, and Retry-After. This enables clients to implement backoff strategies and avoid unnecessary rejections.',
    },
  ],
  'circuit breaker pattern': [
    {
      'title': '1. Three States',
      'summary':
          'Closed (normal operation), Open (requests fail immediately), Half-Open (limited requests test recovery). The circuit breaker transitions between states based on failure thresholds and timeouts.',
    },
    {
      'title': '2. Failure Detection',
      'summary':
          'Tracks consecutive failures or error rates. When the threshold is reached, the circuit opens to prevent cascading failures. This is faster and more reliable than individual request timeouts.',
    },
    {
      'title': '3. Cascading Failure Prevention',
      'summary':
          'Without circuit breakers, a failed downstream service causes callers to hang, exhausting thread pools and propagating the failure upstream. Circuit breakers fail fast, preserving system health.',
    },
    {
      'title': '4. Fallback Strategies',
      'summary':
          'When the circuit is open, return cached data, default values, or a degraded experience. Netflix\'s Hystrix popularized this pattern for resilient microservice communication.',
    },
    {
      'title': '5. Implementation Libraries',
      'summary':
          'Resilience4j (Java), Polly (.NET), and Istio (service mesh) provide circuit breaker implementations. Modern service meshes can apply circuit breaking at the infrastructure level transparently.',
    },
  ],
  'cqrs pattern': [
    {
      'title': '1. Read-Write Separation',
      'summary':
          'CQRS separates the command model (writes) from the query model (reads). Each can be optimized independently — normalized tables for writes, denormalized views for reads.',
    },
    {
      'title': '2. Separate Data Stores',
      'summary':
          'Commands write to a transactional database. Queries read from a read-optimized store (Elasticsearch, Redis, materialized views). Data synchronization happens via events or change data capture.',
    },
    {
      'title': '3. Event Sourcing Synergy',
      'summary':
          'CQRS pairs naturally with event sourcing. Commands produce events that update the write store. Read projections are rebuilt from the event stream, providing multiple query-optimized views.',
    },
    {
      'title': '4. Eventual Consistency Trade-off',
      'summary':
          'Read models may lag behind writes. This is acceptable for dashboards and feeds but requires careful UX design to handle stale data gracefully in user-facing applications.',
    },
    {
      'title': '5. When to Use CQRS',
      'summary':
          'Best for systems with asymmetric read/write loads, complex queries, or multiple read representations. Avoid for simple CRUD apps — CQRS adds significant complexity that must be justified.',
    },
  ],
  'service mesh': [
    {
      'title': '1. Sidecar Proxy Pattern',
      'summary':
          'Each service instance gets a sidecar proxy (Envoy) that handles all network communication. The application code is unaware of the mesh, keeping networking concerns out of business logic.',
    },
    {
      'title': '2. Traffic Management',
      'summary':
          'Service meshes handle load balancing, canary deployments, A/B testing, and traffic splitting between versions. Routing rules are configured declaratively, not coded into services.',
    },
    {
      'title': '3. Observability',
      'summary':
          'The mesh automatically collects metrics, distributed traces, and access logs for every service-to-service call. This provides deep visibility without any instrumentation code in your services.',
    },
    {
      'title': '4. Security (mTLS)',
      'summary':
          'Mutual TLS between services is handled automatically by the mesh. This ensures encrypted, authenticated communication without certificate management burden on individual service teams.',
    },
    {
      'title': '5. Istio vs Linkerd',
      'summary':
          'Istio is feature-rich but complex. Linkerd is lightweight and simpler to operate. Both use Envoy proxies. The choice depends on organizational complexity tolerance and required feature set.',
    },
  ],
  'rest apis': [
    {
      'title': '1. Resource Design Principles',
      'summary':
          'REST models everything as resources identified by URIs. Use nouns (not verbs) for endpoints: /users, /orders. Nested resources express relationships: /users/123/orders.',
    },
    {
      'title': '2. HTTP Methods & Status Codes',
      'summary':
          'GET (read), POST (create), PUT (replace), PATCH (partial update), DELETE (remove). Use 200 for success, 201 for created, 400 for bad input, 404 for missing, 500 for server errors.',
    },
    {
      'title': '3. Authentication Strategies',
      'summary':
          'API keys are simple but less secure. OAuth 2.0 provides delegated access with scopes. JWT tokens enable stateless authentication. Bearer tokens in the Authorization header are standard.',
    },
    {
      'title': '4. Versioning & Pagination',
      'summary':
          'Version via URL path (/v1/users) or Accept header. Paginate with cursor-based (more performant) or offset-based (simpler) pagination. Always include total count and next page links.',
    },
    {
      'title': '5. HATEOAS & Maturity',
      'summary':
          'Hypermedia As The Engine Of Application State embeds links in responses for discoverability. Richardson Maturity Model rates APIs from Level 0 (RPC) to Level 3 (full HATEOAS).',
    },
  ],
  'graphql': [
    {
      'title': '1. Query Language',
      'summary':
          'Clients specify exactly what data they need in a declarative query. This eliminates over-fetching (getting too much data) and under-fetching (needing multiple requests), common REST pain points.',
    },
    {
      'title': '2. Schema & Type System',
      'summary':
          'GraphQL schemas define types, queries, mutations, and subscriptions using SDL. The schema serves as a contract and enables powerful tooling like auto-generated documentation and IDE autocomplete.',
    },
    {
      'title': '3. Resolvers',
      'summary':
          'Each field in the schema has a resolver function that fetches its data. Resolvers can pull from databases, APIs, or in-memory caches. DataLoader batches and deduplicates resolver calls to prevent N+1 queries.',
    },
    {
      'title': '4. Mutations & Real-time',
      'summary':
          'Mutations handle writes with input types and return updated data. Subscriptions provide real-time updates via WebSockets. Together with queries, they cover all CRUD and streaming use cases.',
    },
    {
      'title': '5. Performance Considerations',
      'summary':
          'Complex nested queries can cause performance issues. Use query depth limiting, complexity analysis, and persisted queries to prevent abuse. Caching is harder than REST due to dynamic query shapes.',
    },
  ],
  'websockets': [
    {
      'title': '1. Full-Duplex Communication',
      'summary':
          'Unlike HTTP\'s request-response model, WebSockets maintain a persistent bidirectional connection. Both client and server can send messages at any time without the overhead of new HTTP requests.',
    },
    {
      'title': '2. Handshake Process',
      'summary':
          'The connection starts as an HTTP Upgrade request. The server responds with 101 Switching Protocols. From there, communication occurs over the raw TCP connection with WebSocket framing.',
    },
    {
      'title': '3. Use Cases',
      'summary':
          'Chat applications, live dashboards, collaborative editing (Google Docs), multiplayer games, and financial trading platforms. Any scenario needing real-time, low-latency, bidirectional data flow.',
    },
    {
      'title': '4. Scaling Challenges',
      'summary':
          'Each connection holds server memory. Scaling requires connection-aware load balancing (sticky sessions) or a pub/sub system (Redis) to broadcast messages across multiple server instances.',
    },
    {
      'title': '5. Socket.IO & Alternatives',
      'summary':
          'Socket.IO adds auto-reconnection, rooms, and HTTP fallback on top of WebSockets. For simpler needs, Server-Sent Events provide server-to-client streaming without the full WebSocket overhead.',
    },
  ],
  'http/2': [
    {
      'title': '1. Multiplexing',
      'summary':
          'HTTP/2 sends multiple requests and responses simultaneously over a single TCP connection using streams. This eliminates head-of-line blocking that plagued HTTP/1.1 and reduces connection overhead.',
    },
    {
      'title': '2. Header Compression',
      'summary':
          'HPACK compression reduces redundant header data between requests. Headers that don\'t change (like Authorization) are sent once and referenced by index, saving significant bandwidth.',
    },
    {
      'title': '3. Server Push',
      'summary':
          'The server can proactively push resources the client will need (CSS, JS) before the client requests them. This reduces round trips and improves page load times for known resource dependencies.',
    },
    {
      'title': '4. Binary Framing',
      'summary':
          'HTTP/2 uses a binary protocol instead of text. Frames carry data, headers, priorities, and settings. Binary parsing is faster, less error-prone, and more compact than text-based HTTP/1.1.',
    },
    {
      'title': '5. Migration from HTTP/1.1',
      'summary':
          'HTTP/2 is backward compatible — the same URLs and semantics work. Enable it via TLS (ALPN negotiation). Some HTTP/1.1 optimizations (domain sharding, sprite sheets) become anti-patterns in HTTP/2.',
    },
  ],
  'oauth 2.0': [
    {
      'title': '1. Authorization Framework',
      'summary':
          'OAuth 2.0 enables third-party applications to access resources on behalf of a user without sharing passwords. It defines roles: resource owner, client, authorization server, and resource server.',
    },
    {
      'title': '2. Grant Types',
      'summary':
          'Authorization Code (most secure, for server-side apps), Client Credentials (service-to-service), Implicit (deprecated for SPAs), and PKCE (secure flow for mobile/SPA without a secret).',
    },
    {
      'title': '3. Tokens & Scopes',
      'summary':
          'Access tokens grant limited access defined by scopes (read, write, admin). Refresh tokens obtain new access tokens without re-authentication. Keep access tokens short-lived (minutes, not hours).',
    },
    {
      'title': '4. OpenID Connect',
      'summary':
          'OIDC is an identity layer built on OAuth 2.0. It adds an ID token (JWT) containing user identity claims. This is what powers "Sign in with Google/Apple/GitHub" buttons.',
    },
    {
      'title': '5. Security Best Practices',
      'summary':
          'Always use PKCE for public clients. Validate tokens server-side. Store tokens securely (HttpOnly cookies or secure storage). Never expose client secrets in frontend code.',
    },
  ],
  'jwt authentication': [
    {
      'title': '1. Token Structure',
      'summary':
          'A JWT has three Base64-encoded parts: Header (algorithm, type), Payload (claims like user ID, expiry, roles), and Signature (HMAC or RSA). The signature prevents tampering.',
    },
    {
      'title': '2. Stateless Authentication',
      'summary':
          'The server doesn\'t need to store session data — the token itself carries all authentication info. This simplifies horizontal scaling since any server can validate the token independently.',
    },
    {
      'title': '3. Claims & Validation',
      'summary':
          'Standard claims include iss (issuer), exp (expiration), sub (subject), and aud (audience). Always validate expiration, issuer, and audience. Never trust unvalidated tokens.',
    },
    {
      'title': '4. Refresh Token Flow',
      'summary':
          'Short-lived access tokens (15 min) paired with long-lived refresh tokens (7 days). When the access token expires, the client uses the refresh token to get a new pair without re-login.',
    },
    {
      'title': '5. Security Pitfalls',
      'summary':
          'Never store sensitive data in JWT payloads (they are only encoded, not encrypted). Use RS256 for public key verification. Implement token revocation via short expiry and a deny list for compromised tokens.',
    },
  ],
  'cors': [
    {
      'title': '1. Same-Origin Policy',
      'summary':
          'Browsers block cross-origin requests by default. CORS (Cross-Origin Resource Sharing) relaxes this restriction by allowing servers to specify which origins, methods, and headers are permitted.',
    },
    {
      'title': '2. Preflight Requests',
      'summary':
          'For non-simple requests (PUT, DELETE, custom headers), the browser sends an OPTIONS preflight to check permissions. The server responds with allowed origins and methods before the actual request proceeds.',
    },
    {
      'title': '3. Response Headers',
      'summary':
          'Access-Control-Allow-Origin specifies allowed origins. Access-Control-Allow-Methods lists allowed HTTP methods. Access-Control-Allow-Credentials enables cookie transmission cross-origin.',
    },
    {
      'title': '4. Common Misconfigurations',
      'summary':
          'Using wildcard (*) with credentials is invalid. Reflecting the Origin header without validation creates security vulnerabilities. Always whitelist specific trusted origins in production.',
    },
    {
      'title': '5. Debugging CORS Errors',
      'summary':
          'CORS errors appear in the browser console, not in server logs. Check that the server sends correct headers, the origin matches exactly (including port), and preflight responses return 200.',
    },
  ],
  'server-sent events': [
    {
      'title': '1. Unidirectional Streaming',
      'summary':
          'SSE provides server-to-client streaming over a single HTTP connection. Unlike WebSockets, data flows only one way, making it simpler to implement and compatible with standard HTTP infrastructure.',
    },
    {
      'title': '2. EventSource API',
      'summary':
          'The browser\'s built-in EventSource API handles connection management, automatic reconnection, and event parsing. No special libraries needed — just new EventSource(\'/events\') in JavaScript.',
    },
    {
      'title': '3. Event Format',
      'summary':
          'Messages are plain text with fields: data (payload), event (type), id (tracking), and retry (reconnection interval). Multi-line data is supported. The simplicity of the format aids debugging.',
    },
    {
      'title': '4. Use Cases',
      'summary':
          'Live feeds, stock tickers, progress bars, log streaming, and notification systems. Any scenario where the server pushes updates and the client only needs to listen. Simpler than WebSockets for these cases.',
    },
    {
      'title': '5. Limitations',
      'summary':
          'Limited to text data (no binary). Maximum of 6 connections per domain in HTTP/1.1 browsers. No client-to-server messaging. For bidirectional needs or binary data, use WebSockets instead.',
    },
  ],
  'grpc': [
    {
      'title': '1. Protocol Buffers',
      'summary':
          'gRPC uses Protocol Buffers for interface definition and serialization. Protobuf is 3-10x smaller and faster than JSON, with strong typing and backward-compatible schema evolution.',
    },
    {
      'title': '2. Four Communication Patterns',
      'summary':
          'Unary (single request/response), server streaming, client streaming, and bidirectional streaming. These cover all inter-service communication patterns, from simple RPC to real-time data pipelines.',
    },
    {
      'title': '3. HTTP/2 Foundation',
      'summary':
          'gRPC runs on HTTP/2, providing multiplexing, header compression, and bidirectional streaming natively. This makes it significantly more efficient than REST over HTTP/1.1 for high-throughput services.',
    },
    {
      'title': '4. Code Generation',
      'summary':
          'The protoc compiler generates client and server stubs in 11+ languages from a single .proto file. This ensures type-safe, consistent APIs across polyglot microservice architectures.',
    },
    {
      'title': '5. When to Choose gRPC',
      'summary':
          'Ideal for internal microservice communication where performance matters. Less suitable for browser clients (limited support without gRPC-Web proxy) or when human-readable payloads are needed.',
    },
  ],
  'api versioning': [
    {
      'title': '1. Why Version APIs',
      'summary':
          'APIs evolve but clients depend on existing contracts. Versioning allows introducing breaking changes without disrupting existing consumers. It is essential for any API with external users.',
    },
    {
      'title': '2. URL Path Versioning',
      'summary':
          '/api/v1/users is explicit, easy to understand, and cacheable. Most popular approach. Downside: URL changes feel heavy and each version may require separate routing and controller logic.',
    },
    {
      'title': '3. Header-Based Versioning',
      'summary':
          'Using Accept: application/vnd.api+json;version=2 keeps URLs clean. Content negotiation is RESTful but harder to test (can\'t just change the URL in a browser) and less discoverable.',
    },
    {
      'title': '4. Deprecation Strategy',
      'summary':
          'Announce deprecation with Sunset headers and documentation. Provide a migration guide. Support old versions for at least 6-12 months. Monitor usage to know when it is safe to remove.',
    },
    {
      'title': '5. Avoiding Version Sprawl',
      'summary':
          'Prefer additive, non-breaking changes (new optional fields) over new versions. Use feature flags and API evolution strategies. Each active version multiplies maintenance cost.',
    },
  ],
  'docker': [
    {
      'title': '1. Container Architecture',
      'summary':
          'Docker uses OS-level virtualization with Linux namespaces and cgroups. Containers share the host kernel, making them far lighter than VMs — millisecond startup vs minutes for virtual machines.',
    },
    {
      'title': '2. Dockerfile Best Practices',
      'summary':
          'Use multi-stage builds to separate build and runtime images. Order instructions from least to most frequently changing for layer caching. Use .dockerignore to exclude unnecessary files.',
    },
    {
      'title': '3. Networking & Volumes',
      'summary':
          'Bridge networks isolate container communication. Volumes persist data beyond container lifecycle. Bind mounts map host directories for development. Named volumes are preferred for production data.',
    },
    {
      'title': '4. Image Optimization',
      'summary':
          'Use Alpine-based images for smaller footprint. Pin dependency versions for reproducibility. Each Dockerfile instruction creates a layer — combine RUN commands to reduce layer count and image size.',
    },
    {
      'title': '5. Docker Compose',
      'summary':
          'Defines multi-container applications in a YAML file. Manages service dependencies, networking, volumes, and environment variables. Essential for local development and testing of microservice architectures.',
    },
  ],
  'kubernetes': [
    {
      'title': '1. Pod Fundamentals',
      'summary':
          'A pod is the smallest deployable unit — one or more containers sharing network and storage. Pods are ephemeral; they can be killed and replaced at any time. Never assume pod persistence.',
    },
    {
      'title': '2. Controllers & Deployments',
      'summary':
          'Deployments manage ReplicaSets which manage Pods. They handle rolling updates, rollbacks, and scaling. StatefulSets add stable identity and persistent storage for databases.',
    },
    {
      'title': '3. Services & Networking',
      'summary':
          'ClusterIP exposes pods internally. NodePort opens a port on every node. LoadBalancer provisions a cloud load balancer. Ingress manages external HTTP routing with path and host-based rules.',
    },
    {
      'title': '4. ConfigMaps & Secrets',
      'summary':
          'ConfigMaps store non-sensitive configuration as key-value pairs. Secrets store sensitive data (encrypted at rest in etcd). Both are injected into pods as environment variables or mounted files.',
    },
    {
      'title': '5. Resource Management',
      'summary':
          'Set CPU and memory requests (guaranteed) and limits (maximum). Resource quotas prevent one team from consuming all cluster resources. Horizontal Pod Autoscaler adjusts replicas based on metrics.',
    },
  ],
  'ci/cd pipelines': [
    {
      'title': '1. Continuous Integration',
      'summary':
          'CI merges developer code changes into a shared branch multiple times daily. Each merge triggers automated builds and tests, catching integration issues early before they compound.',
    },
    {
      'title': '2. Continuous Delivery vs Deployment',
      'summary':
          'Continuous Delivery ensures code is always release-ready (manual deploy trigger). Continuous Deployment automatically deploys every passing change to production. The difference is the human gate.',
    },
    {
      'title': '3. Pipeline Stages',
      'summary':
          'Typical stages: lint → build → unit test → integration test → security scan → deploy to staging → smoke test → deploy to production. Each stage gates the next, preventing bad code from advancing.',
    },
    {
      'title': '4. Infrastructure as Code',
      'summary':
          'Define pipeline configuration in version-controlled files (Jenkinsfile, .github/workflows, .gitlab-ci.yml). This makes pipelines reproducible, reviewable, and auditable like any other code.',
    },
    {
      'title': '5. Deployment Strategies',
      'summary':
          'Blue-green switches traffic between two identical environments. Canary routes a small percentage to the new version. Rolling updates replace instances gradually. Each trades speed for safety differently.',
    },
  ],
  'terraform': [
    {
      'title': '1. Declarative Infrastructure',
      'summary':
          'Terraform defines infrastructure in HCL configuration files. You describe the desired end state, and Terraform figures out the changes needed. This eliminates manual provisioning and configuration drift.',
    },
    {
      'title': '2. Plan & Apply Workflow',
      'summary':
          'terraform plan shows what will change without modifying anything. terraform apply executes the changes. This preview step prevents accidental destruction of resources and enables code review.',
    },
    {
      'title': '3. State Management',
      'summary':
          'Terraform stores resource state in a state file. Remote backends (S3, GCS) enable team collaboration with state locking. Never edit state files manually — use terraform state commands.',
    },
    {
      'title': '4. Modules & Reusability',
      'summary':
          'Modules encapsulate reusable infrastructure patterns (VPC, EKS cluster, database). The Terraform Registry hosts community modules. Modules enable consistent infrastructure across environments.',
    },
    {
      'title': '5. Multi-Cloud Support',
      'summary':
          'Providers for AWS, GCP, Azure, Cloudflare, and 1000+ services. A single Terraform codebase can manage resources across multiple clouds, enabling true multi-cloud infrastructure strategies.',
    },
  ],
  'nginx': [
    {
      'title': '1. Web Server & Reverse Proxy',
      'summary':
          'Nginx serves static files with extreme efficiency and proxies dynamic requests to application servers. Its event-driven architecture handles thousands of concurrent connections with minimal memory.',
    },
    {
      'title': '2. Configuration Structure',
      'summary':
          'Configuration uses nested blocks: http → server → location. Server blocks handle virtual hosts. Location blocks match URL patterns. The directive-based syntax is powerful but has a learning curve.',
    },
    {
      'title': '3. Load Balancing',
      'summary':
          'The upstream block defines backend server groups with round-robin, least-connections, or IP-hash algorithms. Health checks remove failed servers. Weights distribute traffic unevenly when needed.',
    },
    {
      'title': '4. SSL/TLS Termination',
      'summary':
          'Nginx handles SSL certificate management, HTTPS termination, and HTTP/2 negotiation. Backend servers communicate in plain HTTP, offloading the encryption overhead to the proxy layer.',
    },
    {
      'title': '5. Caching & Performance',
      'summary':
          'Proxy caching stores upstream responses. Gzip compression reduces transfer size. Buffer tuning optimizes large file handling. These features make Nginx a cornerstone of high-performance web infrastructure.',
    },
  ],
  'linux fundamentals': [
    {
      'title': '1. File System Hierarchy',
      'summary':
          '/bin (essential binaries), /etc (configuration), /home (user data), /var (variable data like logs), /tmp (temporary files). Understanding this structure is essential for system administration.',
    },
    {
      'title': '2. Process Management',
      'summary':
          'ps, top, htop show running processes. kill sends signals (SIGTERM for graceful, SIGKILL for forced). systemd manages services with systemctl. Process states include running, sleeping, and zombie.',
    },
    {
      'title': '3. Permissions & Ownership',
      'summary':
          'chmod sets read/write/execute permissions (rwx). chown changes file ownership. The three permission groups are owner, group, and others. Understanding umask is critical for secure default permissions.',
    },
    {
      'title': '4. Shell Scripting',
      'summary':
          'Bash scripts automate repetitive tasks. Variables, loops, conditionals, pipes (|), and redirections (>, >>) are fundamental. Scripts should always start with a shebang (#!/bin/bash) and use set -euo pipefail.',
    },
    {
      'title': '5. Networking Commands',
      'summary':
          'curl/wget for HTTP requests. netstat/ss for port monitoring. iptables/nftables for firewall rules. ssh for remote access. dig/nslookup for DNS resolution. These are daily tools for any developer.',
    },
  ],
  'git internals': [
    {
      'title': '1. Object Model',
      'summary':
          'Git stores everything as objects: blobs (file content), trees (directories), commits (snapshots), and tags (named references). Each object is identified by its SHA-1 hash, ensuring content integrity.',
    },
    {
      'title': '2. Branching Is Cheap',
      'summary':
          'A branch is just a 40-character file pointing to a commit hash. Creating, switching, and deleting branches is O(1). This makes Git\'s branching model fundamentally different from SVN or CVS.',
    },
    {
      'title': '3. The Staging Area',
      'summary':
          'The index (staging area) sits between the working directory and the repository. git add stages changes for the next commit, allowing precise control over what goes into each commit.',
    },
    {
      'title': '4. Merge vs Rebase',
      'summary':
          'Merge creates a merge commit preserving branch history. Rebase replays commits onto another base, creating a linear history. Use merge for shared branches, rebase for local cleanup before pushing.',
    },
    {
      'title': '5. Reflog & Recovery',
      'summary':
          'The reflog records every HEAD movement for 90 days. Even after a hard reset or botched rebase, git reflog can recover lost commits. It is the ultimate safety net in Git.',
    },
  ],
  'monitoring & observability': [
    {
      'title': '1. Three Pillars',
      'summary':
          'Metrics (quantitative measurements over time), logs (discrete event records), and traces (request flows through services). Together they provide complete system visibility. Missing any one creates blind spots.',
    },
    {
      'title': '2. Metrics with Prometheus',
      'summary':
          'Prometheus scrapes metrics endpoints, stores time-series data, and supports powerful PromQL queries. Counters, gauges, histograms, and summaries are the four metric types. Grafana visualizes the data.',
    },
    {
      'title': '3. Distributed Tracing',
      'summary':
          'Trace IDs propagate through service calls, creating a timeline of every hop. Jaeger and Zipkin visualize traces as Gantt charts. This is essential for debugging latency and failures in microservices.',
    },
    {
      'title': '4. Alerting Best Practices',
      'summary':
          'Alert on symptoms (high error rate, slow response) not causes (high CPU). Use severity levels and escalation policies. Reduce alert fatigue by aggregating related alerts and suppressing known issues.',
    },
    {
      'title': '5. SLIs, SLOs, and SLAs',
      'summary':
          'Service Level Indicators measure performance. Service Level Objectives are targets (99.9% uptime). Service Level Agreements are contracts with penalties. Error budgets balance reliability with feature velocity.',
    },
  ],
  'infrastructure as code': [
    {
      'title': '1. Declarative vs Imperative',
      'summary':
          'Declarative (Terraform, CloudFormation) describes desired state. Imperative (Ansible, scripts) describes steps to reach it. Declarative is preferred for infrastructure; imperative works for configuration management.',
    },
    {
      'title': '2. Version Control Benefits',
      'summary':
          'Infrastructure changes go through pull requests, code review, and CI/CD just like application code. This provides audit trails, rollback capability, and collaboration on infrastructure changes.',
    },
    {
      'title': '3. Immutable Infrastructure',
      'summary':
          'Instead of updating servers in place, create new ones with the desired state and replace old ones. This eliminates configuration drift and makes rollbacks trivial — just deploy the previous image.',
    },
    {
      'title': '4. GitOps Workflow',
      'summary':
          'Git is the single source of truth for infrastructure state. Changes are made via pull requests. Automated controllers (Flux, ArgoCD) continuously reconcile the actual state with the desired state in Git.',
    },
    {
      'title': '5. Testing Infrastructure',
      'summary':
          'Static analysis (tflint, cfn-lint) catches errors early. Integration tests spin up real infrastructure in isolated environments. Terratest enables automated infrastructure testing with Go.',
    },
  ],
  'blue-green deployment': [
    {
      'title': '1. Dual Environment Setup',
      'summary':
          'Two identical production environments exist: Blue (current live) and Green (new version). Traffic is routed to one at a time. The idle environment serves as a staging area for the next release.',
    },
    {
      'title': '2. Zero-Downtime Switching',
      'summary':
          'Switching traffic from Blue to Green is instantaneous — typically a load balancer or DNS change. Users experience zero downtime during the deployment. The old environment remains available for instant rollback.',
    },
    {
      'title': '3. Instant Rollback',
      'summary':
          'If the new version has issues, switching back to the previous environment takes seconds. This dramatically reduces the risk of deployments compared to in-place updates.',
    },
    {
      'title': '4. Database Migrations',
      'summary':
          'Database changes must be backward-compatible since both versions may run simultaneously during transition. Use expand-and-contract migration patterns to evolve schemas safely.',
    },
    {
      'title': '5. Cost Considerations',
      'summary':
          'Running two full environments doubles infrastructure costs during deployment. Use cloud auto-scaling to spin up the green environment only during deployment windows to minimize expense.',
    },
  ],
};
