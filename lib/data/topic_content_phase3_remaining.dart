final Map<String, List<Map<String, String>>> phase3RemainingContent = {
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
  'ml pipelines': [
    {
      'title': 'The Assembly Line for AI',
      'summary': 'An ML Pipeline automates the workflow required to produce a machine learning model. It typically includes data extraction, validation, preparation, model training, and evaluation.',
    },
    {
      'title': 'Repeatability and Scale',
      'summary': 'By codifying the workflow (using tools like Kubeflow or TFX), teams can ensure that models are trained consistently even as data volumes or team members change.',
    },
    {
      'title': 'Data Validation',
      'summary': 'Pipelines catch "data drift" or schema changes early. If the incoming data format changes unexpectedly, the pipeline halts to prevent training a broken model.',
    },
    {
      'title': 'Versioning Everything',
      'summary': 'A good pipeline versions not just the code, but the data used for training and the resulting model weights, enabling easy rollbacks if a new model performs poorly.',
    },
    {
      'title': 'CI/CD for ML (CD4ML)',
      'summary': 'The ultimate goal is a trigger-based system: when new data arrives or code is updated, the pipeline automatically re-trains, tests, and deploys the new model to production.',
    },
  ],
  'quic protocol': [
    {
      'title': 'The Speed of UDP',
      'summary': 'QUIC is a modern transport layer protocol built on top of UDP. It replaces the classic TCP+TLS stack to provide much lower latency for web and mobile apps.',
    },
    {
      'title': '0-RTT Handshake',
      'summary': 'Unlike TCP which requires multiple round-trips for handshaking and TLS setup, QUIC can often establish a secure connection in zero round-trips (0-RTT) for returning users.',
    },
    {
      'title': 'No Head-of-Line Blocking',
      'summary': 'In HTTP/2 over TCP, a single lost packet stops all streams. In QUIC, other streams continue flowing even if one stream loses a packet, significantly improving performance on unstable networks.',
    },
    {
      'title': 'Connection Migration',
      'summary': 'QUIC uses a "Connection ID" rather than an IP address. This allows your app to stay connected without interruption as your phone switches from Wi-Fi to 4G.',
    },
    {
      'title': 'Built-in Encryption',
      'summary': 'QUIC integrates TLS 1.3 directly into the protocol. Unlike TCP, the packet headers are also encrypted, preventing middle-boxes from tampering with the traffic.',
    },
  ],
};
