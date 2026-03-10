/// Pre-generated content for CS Fundamentals & System Design topics.
const Map<String, List<Map<String, String>>> fundamentalsContent = {
  'binary search': [
    {
      'title': '1. Algorithm Mechanics',
      'summary':
          'Binary search works by repeatedly dividing a sorted array in half, comparing the target with the middle element. If the target is smaller, search the left half; if larger, search the right.',
    },
    {
      'title': '2. Time & Space Complexity',
      'summary':
          'Runs in O(log n) time since each step halves the search space. Uses O(1) space iteratively or O(log n) with recursion due to call stack frames.',
    },
    {
      'title': '3. Edge Cases & Off-by-One',
      'summary':
          'Common bugs include incorrect mid calculation (use lo + (hi - lo) / 2 to avoid overflow) and wrong boundary updates. Always verify with arrays of size 0, 1, and 2.',
    },
    {
      'title': '4. Variations',
      'summary':
          'Lower bound finds the first element >= target; upper bound finds the first element > target. These are essential for range queries and counting occurrences in sorted data.',
    },
    {
      'title': '5. Real-World Applications',
      'summary':
          'Used in database index lookups, autocomplete systems, and Git bisect for finding bug-introducing commits. Any sorted dataset benefits from binary search.',
    },
  ],
  'linked lists': [
    {
      'title': '1. Node-Based Structure',
      'summary':
          'A linked list stores data in nodes, each containing a value and a pointer to the next node. Unlike arrays, elements are not contiguous in memory.',
    },
    {
      'title': '2. Singly vs Doubly Linked',
      'summary':
          'Singly linked lists have one pointer per node (next). Doubly linked lists add a previous pointer, enabling O(1) deletion and reverse traversal at the cost of extra memory.',
    },
    {
      'title': '3. Insertion & Deletion',
      'summary':
          'Inserting or deleting at the head is O(1). Middle operations require traversal (O(n)) since there is no random access like arrays.',
    },
    {
      'title': '4. The Runner Technique',
      'summary':
          'Using two pointers (slow and fast) enables cycle detection (Floyd\'s algorithm), finding the middle node, and detecting the kth-from-end element in a single pass.',
    },
    {
      'title': '5. Memory Trade-offs',
      'summary':
          'Linked lists avoid the resizing cost of dynamic arrays but have higher per-element overhead due to pointer storage and poor cache locality.',
    },
  ],
  'hash tables': [
    {
      'title': '1. Hash Function Design',
      'summary':
          'A hash function maps keys to bucket indices. Good hash functions distribute keys uniformly, minimize collisions, and compute quickly. Common choices include MurmurHash and FNV.',
    },
    {
      'title': '2. Collision Resolution',
      'summary':
          'Chaining stores colliding keys in a linked list per bucket. Open addressing probes for the next empty slot. Robin Hood hashing reduces variance by redistributing entries.',
    },
    {
      'title': '3. Load Factor & Resizing',
      'summary':
          'The load factor (n/buckets) determines fullness. When it exceeds ~0.75, the table doubles in size and rehashes all entries, an O(n) amortized operation.',
    },
    {
      'title': '4. Average vs Worst Case',
      'summary':
          'Average operations are O(1) for insert, lookup, and delete. Worst case degrades to O(n) if all keys hash to the same bucket, which is why hash function quality matters.',
    },
    {
      'title': '5. Language Implementations',
      'summary':
          'Python\'s dict, JavaScript\'s Map/Object, Java\'s HashMap, and Dart\'s Map all use hash tables internally. They are the backbone of almost every key-value data structure.',
    },
  ],
  'recursion': [
    {
      'title': '1. Base Case & Recursive Case',
      'summary':
          'Every recursive function needs a base case that stops recursion and a recursive case that breaks the problem into smaller subproblems. Missing the base case causes infinite recursion and stack overflow.',
    },
    {
      'title': '2. Call Stack Mechanics',
      'summary':
          'Each recursive call pushes a new frame onto the call stack. Deep recursion (>10,000 frames) can exhaust stack memory. Understanding the stack helps debug and optimize recursive solutions.',
    },
    {
      'title': '3. Tail Recursion Optimization',
      'summary':
          'Tail recursive functions make the recursive call as their last operation, allowing compilers to reuse the current stack frame. Not all languages support this optimization.',
    },
    {
      'title': '4. Recursion vs Iteration',
      'summary':
          'Any recursive solution can be converted to iteration using an explicit stack. Iteration is often faster due to lower overhead, but recursion is more natural for tree/graph problems.',
    },
    {
      'title': '5. Common Patterns',
      'summary':
          'Tree traversal, divide-and-conquer (merge sort), backtracking (N-Queens), and mathematical sequences (Fibonacci) are classic recursion applications that every developer should master.',
    },
  ],
  'stack & queue': [
    {
      'title': '1. LIFO vs FIFO Principles',
      'summary':
          'Stacks follow Last-In-First-Out: the most recent element is removed first. Queues follow First-In-First-Out: the oldest element is removed first. Both are fundamental to algorithm design.',
    },
    {
      'title': '2. Array vs Linked List Backing',
      'summary':
          'Both can be backed by arrays (circular buffer for queues) or linked lists. Array-based implementations offer better cache performance; linked list versions avoid resizing.',
    },
    {
      'title': '3. Stack Applications',
      'summary':
          'Stacks power function call management, expression evaluation (postfix notation), undo operations, and balanced parentheses checking. DFS uses a stack explicitly or via recursion.',
    },
    {
      'title': '4. Queue Variants',
      'summary':
          'Priority queues serve the highest-priority element first (implemented via heaps). Deques (double-ended queues) allow insertion and removal from both ends in O(1).',
    },
    {
      'title': '5. BFS & Task Scheduling',
      'summary':
          'Queues are essential for Breadth-First Search, print job scheduling, and message buffering in producers-consumer patterns. They ensure fair ordering of operations.',
    },
  ],
  'binary trees': [
    {
      'title': '1. Tree Terminology',
      'summary':
          'A binary tree has nodes with at most two children (left and right). Key terms include root, leaf, depth, height, and subtree. The height of a balanced tree is O(log n).',
    },
    {
      'title': '2. Traversal Orders',
      'summary':
          'In-order (left, root, right) gives sorted output for BSTs. Pre-order (root, left, right) is used for serialization. Post-order (left, right, root) is used for deletion. Level-order uses BFS.',
    },
    {
      'title': '3. Binary Search Trees',
      'summary':
          'BSTs maintain the invariant: left child < parent < right child. This enables O(log n) search, insert, and delete in balanced trees, but degrades to O(n) if unbalanced.',
    },
    {
      'title': '4. Self-Balancing Trees',
      'summary':
          'AVL trees and Red-Black trees automatically rebalance after insertions/deletions to maintain O(log n) height. Red-Black trees are used in Java TreeMap and C++ std::map.',
    },
    {
      'title': '5. Practical Uses',
      'summary':
          'Binary trees power file system hierarchies, expression parsing, Huffman encoding for compression, and decision trees in machine learning. They are a universal data structure.',
    },
  ],
  'sorting algorithms': [
    {
      'title': '1. Comparison-Based Sorts',
      'summary':
          'Merge sort (O(n log n), stable) and quicksort (O(n log n) average, in-place) are the two dominant comparison sorts. The theoretical lower bound for comparison sorts is Ω(n log n).',
    },
    {
      'title': '2. Non-Comparison Sorts',
      'summary':
          'Counting sort, radix sort, and bucket sort can achieve O(n) time by exploiting constraints on input data (e.g., limited range integers). They break the comparison sort lower bound.',
    },
    {
      'title': '3. Stability Matters',
      'summary':
          'A stable sort preserves the relative order of equal elements. Merge sort is stable; quicksort is not. Stability is critical when sorting objects by multiple keys sequentially.',
    },
    {
      'title': '4. In-Place vs Extra Memory',
      'summary':
          'Quicksort uses O(log n) stack space. Merge sort requires O(n) auxiliary space for merging. Heap sort is in-place and O(n log n) but has poor cache performance.',
    },
    {
      'title': '5. Choosing the Right Sort',
      'summary':
          'Use quicksort for general-purpose speed, merge sort when stability matters, insertion sort for nearly-sorted or small arrays, and radix sort for fixed-length integer/string keys.',
    },
  ],
  'graph theory': [
    {
      'title': '1. Representations',
      'summary':
          'Graphs are stored as adjacency matrices (O(V²) space, O(1) edge lookup) or adjacency lists (O(V+E) space, efficient iteration). Adjacency lists are preferred for sparse graphs.',
    },
    {
      'title': '2. BFS & DFS',
      'summary':
          'Breadth-First Search finds shortest paths in unweighted graphs using a queue. Depth-First Search explores as deep as possible using a stack, useful for topological sort and cycle detection.',
    },
    {
      'title': '3. Shortest Path Algorithms',
      'summary':
          'Dijkstra\'s handles non-negative weights in O((V+E) log V). Bellman-Ford handles negative weights in O(VE). Floyd-Warshall finds all-pairs shortest paths in O(V³).',
    },
    {
      'title': '4. Minimum Spanning Trees',
      'summary':
          'Kruskal\'s algorithm sorts edges and greedily adds them (uses Union-Find). Prim\'s algorithm grows the tree from a vertex using a priority queue. Both produce optimal spanning trees.',
    },
    {
      'title': '5. Network Flow & Matching',
      'summary':
          'Max-flow algorithms (Ford-Fulkerson, Edmonds-Karp) solve capacity problems in networks. Bipartite matching assigns tasks to workers optimally. These model real logistics and resource allocation.',
    },
  ],
  'dynamic programming': [
    {
      'title': '1. Overlapping Subproblems',
      'summary':
          'DP applies when a problem can be broken into subproblems that are solved repeatedly. Unlike divide-and-conquer, DP stores results to avoid redundant computation.',
    },
    {
      'title': '2. Top-Down vs Bottom-Up',
      'summary':
          'Top-down (memoization) uses recursion with a cache. Bottom-up (tabulation) fills a table iteratively. Bottom-up often has better constant factors and avoids stack overflow.',
    },
    {
      'title': '3. State Design',
      'summary':
          'The hardest part of DP is defining the state. Ask: what information do I need to make a decision? Common states include index, remaining capacity, and previous choice.',
    },
    {
      'title': '4. Space Optimization',
      'summary':
          'Many DP problems only depend on the previous row of the table. Rolling arrays reduce O(n²) space to O(n). The 0/1 knapsack can be solved in O(W) space using this technique.',
    },
    {
      'title': '5. Classic Problems',
      'summary':
          'Fibonacci, longest common subsequence, edit distance, coin change, and knapsack are essential DP problems. Mastering these patterns covers most interview and real-world DP scenarios.',
    },
  ],
  'greedy algorithms': [
    {
      'title': '1. The Greedy Choice Property',
      'summary':
          'Greedy algorithms make the locally optimal choice at each step, hoping to find a global optimum. They work when the greedy choice property and optimal substructure both hold.',
    },
    {
      'title': '2. Proving Correctness',
      'summary':
          'Use an exchange argument: show that swapping any non-greedy choice with the greedy one doesn\'t worsen the solution. Without proof, a greedy approach may produce suboptimal results.',
    },
    {
      'title': '3. Activity Selection',
      'summary':
          'Sort activities by finish time and greedily select non-overlapping ones. This classic problem models scheduling of rooms, CPU tasks, and event planning.',
    },
    {
      'title': '4. Huffman Coding',
      'summary':
          'Builds an optimal prefix code by repeatedly merging the two lowest-frequency characters. Used in ZIP, GZIP, and JPEG compression. It\'s a perfect example of greedy optimality.',
    },
    {
      'title': '5. Greedy vs DP',
      'summary':
          'Greedy is faster (often O(n log n)) but only works for problems with the greedy property. DP handles all optimal substructure problems at higher computational cost.',
    },
  ],
  'big o notation': [
    {
      'title': '1. Asymptotic Analysis',
      'summary':
          'Big O describes the upper bound of an algorithm\'s growth rate as input size approaches infinity. It ignores constants and lower-order terms to focus on scalability.',
    },
    {
      'title': '2. Common Complexities',
      'summary':
          'O(1) constant, O(log n) logarithmic, O(n) linear, O(n log n) linearithmic, O(n²) quadratic, O(2ⁿ) exponential. Each represents a fundamentally different scaling behavior.',
    },
    {
      'title': '3. Big O vs Big Ω vs Big Θ',
      'summary':
          'Big O is upper bound (worst case). Big Ω is lower bound (best case). Big Θ is tight bound (exact growth rate). Interviews typically focus on Big O for worst-case analysis.',
    },
    {
      'title': '4. Amortized Analysis',
      'summary':
          'Some operations are expensive occasionally but cheap on average. Dynamic array resizing is O(n) per resize but O(1) amortized per insertion over all operations combined.',
    },
    {
      'title': '5. Space Complexity',
      'summary':
          'Measures the memory an algorithm uses relative to input size. In-place algorithms use O(1) extra space. Recursive algorithms use O(depth) stack space. Space is often the binding constraint.',
    },
  ],
  'bit manipulation': [
    {
      'title': '1. Bitwise Operators',
      'summary':
          'AND (&), OR (|), XOR (^), NOT (~), left shift (<<), and right shift (>>). These operate on individual bits and are the fastest operations a CPU can perform.',
    },
    {
      'title': '2. Common Tricks',
      'summary':
          'Check if n is power of 2: n & (n-1) == 0. Toggle bit: n ^ (1 << i). Clear lowest set bit: n & (n-1). Count set bits: Brian Kernighan\'s algorithm runs in O(set bits) time.',
    },
    {
      'title': '3. Bitmasks for Sets',
      'summary':
          'An integer can represent a set where each bit indicates membership. Subset enumeration, intersection (AND), union (OR), and difference use only bitwise operations, enabling O(1) set operations.',
    },
    {
      'title': '4. XOR Properties',
      'summary':
          'XOR is self-inverse: a ^ a = 0, a ^ 0 = a. This enables finding the single unique element in an array of pairs, and swapping two variables without a temp variable.',
    },
    {
      'title': '5. Systems Programming',
      'summary':
          'Bit manipulation is essential in network protocols (IP masking), graphics (color channels), cryptography (block ciphers), and embedded systems where every byte counts.',
    },
  ],
  'tries': [
    {
      'title': '1. Prefix Tree Structure',
      'summary':
          'A trie is a tree where each node represents a character. Paths from root to marked nodes form stored strings. This structure enables O(L) lookup where L is the key length, independent of dataset size.',
    },
    {
      'title': '2. Insertion & Search',
      'summary':
          'Inserting a word creates nodes for each character along the path. Searching follows the path character by character. Both operations are O(L) where L is the word length.',
    },
    {
      'title': '3. Autocomplete Systems',
      'summary':
          'Tries naturally support prefix matching. To autocomplete, traverse to the prefix node and enumerate all descendants. This is why tries power search bars, IDEs, and spell checkers.',
    },
    {
      'title': '4. Memory Optimization',
      'summary':
          'Standard tries can be memory-heavy (26 pointers per node for lowercase letters). Compressed tries (radix trees) merge single-child chains into one node, dramatically reducing space.',
    },
    {
      'title': '5. IP Routing Tables',
      'summary':
          'Network routers use binary tries (Patricia tries) for longest-prefix matching on IP addresses. This enables O(32) lookup for IPv4 routing decisions, critical for internet infrastructure.',
    },
  ],
  'heaps': [
    {
      'title': '1. Heap Property',
      'summary':
          'A min-heap ensures every parent is smaller than its children; a max-heap ensures every parent is larger. This makes the minimum (or maximum) accessible in O(1) at the root.',
    },
    {
      'title': '2. Array Representation',
      'summary':
          'Heaps are stored in arrays where the children of index i are at 2i+1 and 2i+2. This avoids pointer overhead and provides excellent cache locality for fast operations.',
    },
    {
      'title': '3. Heapify & Build',
      'summary':
          'Sift-up inserts an element in O(log n). Sift-down restores the heap property after removal. Building a heap from an unsorted array is O(n) using bottom-up heapify, not O(n log n).',
    },
    {
      'title': '4. Priority Queues',
      'summary':
          'Heaps are the standard implementation of priority queues. They power Dijkstra\'s algorithm, A* search, job schedulers, and any system needing efficient access to the most important element.',
    },
    {
      'title': '5. Heap Sort',
      'summary':
          'Heap sort builds a max-heap then repeatedly extracts the maximum. It runs in O(n log n) with O(1) extra space, but has poor cache performance compared to quicksort in practice.',
    },
  ],
  'divide and conquer': [
    {
      'title': '1. The Three Steps',
      'summary':
          'Divide: split the problem into smaller subproblems. Conquer: solve each subproblem recursively. Combine: merge the subproblem solutions into the final answer.',
    },
    {
      'title': '2. Master Theorem',
      'summary':
          'The Master Theorem solves recurrences of the form T(n) = aT(n/b) + O(nᵈ). It classifies the solution into three cases based on the relationship between a, b, and d.',
    },
    {
      'title': '3. Merge Sort',
      'summary':
          'The quintessential divide-and-conquer algorithm. It splits the array, recursively sorts both halves, and merges them in O(n). Total complexity is O(n log n) with O(n) space.',
    },
    {
      'title': '4. Quick Select',
      'summary':
          'Finds the kth smallest element in O(n) average time using partitioning. Unlike sorting, it only recurses into one half, reducing the recurrence to T(n) = T(n/2) + O(n).',
    },
    {
      'title': '5. Beyond Sorting',
      'summary':
          'Closest pair of points (O(n log n)), Strassen\'s matrix multiplication (O(n²·⁸¹)), and FFT (O(n log n)) all use divide and conquer to beat naive algorithms by orders of magnitude.',
    },
  ],
  'system design': [
    {
      'title': '1. Requirements Gathering',
      'summary':
          'Start with functional requirements (what the system does) and non-functional requirements (scalability, latency, availability). Clarify scope and constraints before designing anything.',
    },
    {
      'title': '2. High-Level Architecture',
      'summary':
          'Draw the major components: clients, load balancers, application servers, databases, caches, and message queues. Show how data flows through the system and where scaling points exist.',
    },
    {
      'title': '3. Data Model & Storage',
      'summary':
          'Choose between SQL (relational, ACID, joins) and NoSQL (flexible schema, horizontal scaling). Consider read/write patterns, data volume, and consistency requirements.',
    },
    {
      'title': '4. Scaling Strategies',
      'summary':
          'Vertical scaling adds resources to one machine. Horizontal scaling adds more machines. Use sharding for databases, replication for reads, and CDNs for static content.',
    },
    {
      'title': '5. Bottleneck Analysis',
      'summary':
          'Identify single points of failure and bottlenecks. Use back-of-the-envelope calculations to estimate traffic, storage, and bandwidth. Design for 10x the current load.',
    },
  ],
  'load balancing': [
    {
      'title': '1. Why Load Balance',
      'summary':
          'Load balancers distribute incoming traffic across multiple servers to prevent any single server from being overwhelmed. They improve availability, reliability, and response times.',
    },
    {
      'title': '2. Algorithms',
      'summary':
          'Round Robin distributes requests sequentially. Least Connections sends to the least-busy server. IP Hash ensures the same client always hits the same server (useful for sessions).',
    },
    {
      'title': '3. Layer 4 vs Layer 7',
      'summary':
          'L4 balancers route based on IP/port (faster, less flexible). L7 balancers inspect HTTP headers, URLs, and cookies (slower, but can route based on content type or user identity).',
    },
    {
      'title': '4. Health Checks',
      'summary':
          'Active health checks periodically ping servers. Passive checks monitor response codes. Unhealthy servers are removed from the pool automatically and re-added when recovered.',
    },
    {
      'title': '5. Global Server Load Balancing',
      'summary':
          'GSLB routes users to the nearest data center using DNS-based routing or anycast. This reduces latency for geographically distributed users and provides disaster recovery failover.',
    },
  ],
  'caching strategies': [
    {
      'title': '1. Cache-Aside Pattern',
      'summary':
          'The application checks the cache first. On miss, it reads from the database, stores the result in cache, then returns it. This is the most common strategy, giving full control over what gets cached.',
    },
    {
      'title': '2. Write-Through vs Write-Behind',
      'summary':
          'Write-through updates cache and database synchronously (consistent but slower). Write-behind queues database writes asynchronously (faster but risks data loss on cache failure).',
    },
    {
      'title': '3. Eviction Policies',
      'summary':
          'LRU (Least Recently Used) is the most popular. LFU (Least Frequently Used) favors popular items. TTL (Time To Live) expires entries after a fixed duration. Each suits different access patterns.',
    },
    {
      'title': '4. Cache Invalidation',
      'summary':
          'The hardest problem in caching. Event-driven invalidation uses pub/sub to notify caches of changes. Versioned keys append a version number to avoid stale reads.',
    },
    {
      'title': '5. Multi-Level Caching',
      'summary':
          'Browser cache → CDN → application cache (Redis) → database query cache. Each layer reduces latency. The further from the user, the more expensive the cache miss.',
    },
  ],
  'database sharding': [
    {
      'title': '1. Horizontal Partitioning',
      'summary':
          'Sharding splits a single database table across multiple servers, each holding a subset of rows. This enables horizontal scaling beyond the limits of a single machine.',
    },
    {
      'title': '2. Shard Key Selection',
      'summary':
          'The shard key determines which shard holds each row. A good key distributes data evenly and aligns with query patterns. User ID is common but can cause hotspots for power users.',
    },
    {
      'title': '3. Range vs Hash Sharding',
      'summary':
          'Range sharding groups consecutive keys (good for range queries, prone to hotspots). Hash sharding distributes uniformly (eliminates hotspots, but range queries hit all shards).',
    },
    {
      'title': '4. Cross-Shard Queries',
      'summary':
          'Joins and aggregations across shards are expensive and complex. Denormalization, scatter-gather queries, and materialized views are common workarounds but add complexity.',
    },
    {
      'title': '5. Resharding Challenges',
      'summary':
          'Adding or removing shards requires data migration. Consistent hashing minimizes data movement. Vitess (YouTube) and CockroachDB provide automatic resharding solutions.',
    },
  ],
  'message queues': [
    {
      'title': '1. Asynchronous Decoupling',
      'summary':
          'Message queues decouple producers from consumers. The producer publishes a message and moves on; the consumer processes it later. This enables independent scaling and fault tolerance.',
    },
    {
      'title': '2. At-Least-Once vs Exactly-Once',
      'summary':
          'At-least-once delivery retries on failure (may duplicate). Exactly-once requires idempotent consumers or transactional messaging. Most systems choose at-least-once with idempotent handlers.',
    },
    {
      'title': '3. Popular Implementations',
      'summary':
          'RabbitMQ excels at routing and priority. Kafka handles massive throughput with durable log storage. SQS is a managed AWS solution. Redis Streams adds queue semantics to Redis.',
    },
    {
      'title': '4. Dead Letter Queues',
      'summary':
          'Messages that fail processing repeatedly are moved to a dead letter queue for manual inspection. This prevents poison messages from blocking the main queue and aids debugging.',
    },
    {
      'title': '5. Event Sourcing Integration',
      'summary':
          'Queues pair naturally with event sourcing, where every state change is an immutable event. The queue becomes the system of record, enabling replay, audit trails, and temporal queries.',
    },
  ],
  'microservices': [
    {
      'title': '1. Service Boundaries',
      'summary':
          'Each microservice owns a single business capability and its data. Boundaries should align with domain concepts (orders, inventory, payments), not technical layers.',
    },
    {
      'title': '2. Inter-Service Communication',
      'summary':
          'Synchronous (REST, gRPC) for real-time responses. Asynchronous (message queues, events) for loose coupling. Most systems use a mix, with events for data propagation and REST for queries.',
    },
    {
      'title': '3. Data Ownership',
      'summary':
          'Each service owns its database — no shared databases. This ensures loose coupling but requires eventual consistency patterns and data duplication across service boundaries.',
    },
    {
      'title': '4. Observability',
      'summary':
          'Distributed tracing (Jaeger, Zipkin), centralized logging (ELK stack), and metrics (Prometheus/Grafana) are essential. Without observability, debugging microservices is nearly impossible.',
    },
    {
      'title': '5. When NOT to Use Microservices',
      'summary':
          'Microservices add operational complexity. Start with a modular monolith and extract services when scaling demands it. Premature decomposition is a common and costly mistake.',
    },
  ],
};
