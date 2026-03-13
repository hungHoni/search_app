final Map<String, List<Map<String, String>>> phase2BackendContent = {
  'rust ownership': [
    {
      'title': 'Ownership Rules',
      'summary': 'Rust manages memory without a GC through three rules: Each value has a variable called its owner; there can only be one owner at a time; when the owner goes out of scope, the value is dropped.',
    },
    {
      'title': 'Borrowing and References',
      'summary': 'Variables can borrow values via references (&). You can have either one mutable reference OR any number of immutable references, preventing data races at compile time.',
    },
    {
      'title': 'The Borrow Checker',
      'summary': 'A core part of the Rust compiler that enforces ownership and borrowing rules. It ensures no "use-after-free" or "double-free" errors ever make it to production.',
    },
    {
      'title': 'Lifetimes',
      'summary': 'Lifetimes are a way of telling the compiler how long a reference is valid. Most of the time they are inferred, but complex structures require explicit annotations to ensure safety.',
    },
    {
      'title': 'Move Semantics',
      'summary': 'When a value is assigned to another variable or passed to a function, ownership is "moved" by default for most types, making the original variable invalid.',
    },
  ],
  'go channels': [
    {
      'title': 'CSP Implementation',
      'summary': 'Go channels are a implementation of Communicating Sequential Processes. They allow goroutines to communicate by sending/receiving data rather than sharing memory.',
    },
    {
      'title': 'Buffered Channels',
      'summary': 'Standard channels block on send until a receiver is ready. Buffered channels allow sending a fixed number of values before blocking, enabling asynchronous producer-consumer patterns.',
    },
    {
      'title': 'Directional Channels',
      'summary': 'Function signatures can specify if a channel is send-only (chan<-) or receive-only (<-chan), providing compile-time safety and clearer API design.',
    },
    {
      'title': 'Select Statement',
      'summary': 'The `select` keyword lets a goroutine wait on multiple channel operations. It’s like a switch statement but for communication, picking the first ready operation.',
    },
    {
      'title': 'Closing Channels',
      'summary': 'Only the sender should close a channel to signal no more data. Receivers can check the "ok" boolean to detect when a channel is closed and finished.',
    },
  ],
  'python gil': [
    {
      'title': 'Global Interpreter Lock',
      'summary': 'The GIL is a mutex that protects access to Python objects, preventing multiple native threads from executing Python bytecodes at once.',
    },
    {
      'title': 'CPU vs IO Bound',
      'summary': 'The GIL makes multi-threaded CPU-bound code slower due to lock contention. However, it is released during IO operations, making threading efficient for web requests.',
    },
    {
      'title': 'Multiprocessing Fallback',
      'summary': 'To bypass the GIL for heavy computations, Python developers use the `multiprocessing` module, which creates separate OS processes with their own memory and GIL.',
    },
    {
      'title': 'Memory Mgmt Safety',
      'summary': 'The primary reason for the GIL is to make memory management (reference counting) thread-safe without needing granular locks on every single object.',
    },
    {
      'title': 'The Path to removal',
      'summary': 'PEP 703 proposes making the GIL optional in future versions, allowing "Free Threading" by moving to more complex thread-safe garbage collection strategies.',
    },
  ],
};
