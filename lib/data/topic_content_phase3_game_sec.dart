final Map<String, List<Map<String, String>>> phase3GameSecContent = {
  'entity component system': [
    {
      'title': 'The ECS Paradigm',
      'summary': 'ECS is a pattern that favors composition over inheritance. Entities are unique IDs, Components are raw data, and Systems are the logic that iterates over entities with specific components.',
    },
    {
      'title': 'Data-Oriented Design',
      'summary': 'By grouping component data in contiguous memory (Arrays/SoA), ECS maximizes CPU cache hits, allowing games to process thousands of entities (like bullets or units) far faster than OOP.',
    },
    {
      'title': 'Decoupling Logic',
      'summary': 'Systems only care about data. For example, a "MotionSystem" only needs "Position" and "Velocity" components, regardless of whether the entity is a player, an enemy, or a flying rock.',
    },
    {
      'title': 'Better Scalability',
      'summary': 'ECS makes it easier to multithread game logic because systems often have clear read/write dependencies on specific component types, reducing state synchronization overhead.',
    },
    {
      'title': 'Dynamic Entity Evolution',
      'summary': 'Since entities are just collections of components, you can add or remove behavior at runtime (e.g., adding a "Poisoned" component) without restructuring class hierarchies.',
    },
  ],
  'penetration testing': [
    {
      'title': 'The Ethical Hacker Toolkit',
      'summary': 'Penetration testing involves simulated attacks on a computer system to find vulnerabilities. It follows five phases: Reconnaissance, Scanning, Gaining Access, Maintaining Access, and Analysis.',
    },
    {
      'title': 'White vs Black Box',
      'summary': 'White-box testing provide the attacker with full system knowledge (source code/IPs). Black-box testing simulates a real-world external attack where the hacker knows nothing about the internal structure.',
    },
    {
      'title': 'Vulnerability Scanning',
      'summary': 'Tools like Nessus or OpenVAS are used to automatically detect known flaws, while manual testing (Red Teaming) is used to find complex logic errors that automated tools miss.',
    },
    {
      'title': 'Exploitation Frameworks',
      'summary': 'Metasploit is the industry standard for delivering payloads and testing if a discovered vulnerability can actually be leveraged to compromise a system.',
    },
    {
      'title': 'Reporting and Remediation',
      'summary': 'The most critical step is the final report, which ranks vulnerabilities by severity (using CVSS scores) and provides clear technical steps for developers to patch them.',
    },
  ],
  'pathfinding (a*)': [
    {
      'title': 'The Best-First Search',
      'summary': 'A* is an algorithm used in games and maps to find the shortest path between nodes. It combines the cost from the start (G) and the estimated cost to the end (H).',
    },
    {
      'title': 'The Heuristic Function',
      'summary': 'The H-cost is an "educated guess"—typically calculated using Manhattan distance for grids or Euclidean distance for free movement. A good heuristic ensures the search stays focused on the target.',
    },
    {
      'title': 'Priority Queues',
      'summary': 'A* uses a "Min-Priority Queue" (Open List) to always expand the node with the lowest Total Cost (F = G + H) first, ensuring optimal efficiency.',
    },
    {
      'title': 'NavMesh vs Grids',
      'summary': 'In modern 3D games, A* is often run on Navigation Meshes (NavMeshes)—polygons representing walkable areas—rather than simple square grids, allowing for more realistic AI movement.',
    },
    {
      'title': 'Performance Trade-offs',
      'summary': 'For large maps with many units, developers use optimizations like HPA* (Hierarchical Pathfinding) or JPS (Jump Point Search) to reduce the number of nodes the CPU needs to evaluate.',
    },
  ],
};
