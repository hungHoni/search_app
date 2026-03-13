final Map<String, List<Map<String, String>>> phase3CompilerDbContent = {
  'llvbm architecture': [
    {
      'title': 'The Universal Compiler',
      'summary': 'LLVM is a collection of modular and reusable compiler and toolchain technologies. It uses a three-phase design: Front-end (language specific), Optimizer (target-agnostic), and Back-end (machine specify).',
    },
    {
      'title': 'LLVM IR',
      'summary': 'LLVM Intermediate Representation (IR) is a low-level, RISC-like assembly language that is easy for the optimizer to process but powerful enough to represent all source languages.',
    },
    {
      'title': 'Pass-based Optimization',
      'summary': 'Optimizations happen in "passes" over the IR. This allows developers to add new optimizations (like Dead Code Elimination) or new hardware targets without rewriting the whole compiler.',
    },
    {
      'title': 'Just-In-Time (JIT) Support',
      'summary': 'LLVM can generate machine code at runtime (McJIT/ORC), which is essential for projects like Julia, Numba, or modern web browsers to achieve high performance.',
    },
    {
      'title': 'Clang and Tooling',
      'summary': 'Clang is the C/C++ front-end for LLVM. It is designed to be much faster and provide significantly better error messages than traditional compilers like GCC.',
    },
  ],
  'raft consensus': [
    {
      'title': 'The Key to Reliability',
      'summary': 'Raft is a consensus algorithm for managing a replicated log. It is designed to be easier to understand than Paxos while maintaining the same level of safety and fault tolerance.',
    },
    {
      'title': 'Leader Election',
      'summary': 'In Raft, one node acts as a Leader. If it fails, the other nodes (Followers and Candidates) use randomized timeouts to initiate a new election and choose a successor.',
    },
    {
      'title': 'Log Replication',
      'summary': 'Clients send commands to the Leader. The Leader appends them to its log and replicates them to a majority of Followers before "committing" and applying the change.',
    },
    {
      'title': 'Safety and Quorums',
      'summary': 'Raft ensures that a node can only be elected Leader if its log contains all committed entries from previous terms, preventing data loss during network partitions.',
    },
    {
      'title': 'Cluster Membership',
      'summary': 'Advanced Raft implementations support dynamic membership changes, allowing nodes to be added or removed from the cluster without stopping the system.',
    },
  ],
};
