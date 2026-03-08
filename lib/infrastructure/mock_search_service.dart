import '../domain/models/search_result.dart';
import '../domain/repositories/search_repository.dart';

class MockSearchService implements SearchRepository {
  @override
  Future<List<SearchResult>> fetchResults(String query) async {
    // Simulate network delay to trigger UI loading states naturally
    await Future.delayed(const Duration(milliseconds: 1500));

    // A structured 5-part educational learning breakdown
    return [
      SearchResult(
        title: '1. The Core Concept',
        summary:
            'At its foundation, $query is defined by its ability to resolve structural inefficiencies. It forces a mindset transition from brute-force tactics to optimized, scalable architectural patterns.',
        url: '', // Unused in this minimal UI
      ),
      SearchResult(
        title: '2. Key Components & Implementation',
        summary:
            'Implementing $query requires standardizing the data flow. The primary constraints usually involve managing state synchronization and ensuring decoupling between the abstract interface and the concrete logic.',
        url: '',
      ),
      SearchResult(
        title: '3. Time & Space Complexity',
        summary:
            'If executed correctly, $query introduces logarithmic or strictly linear boundaries to your time complexity. Space complexity trades off against initial memory allocation, preferring eagerly cached states.',
        url: '',
      ),
      SearchResult(
        title: '4. Common Pitfalls',
        summary:
            'Engineers frequently over-engineer $query by failing to identify local minimums. Early optimization here leads to tightly coupled dependencies that are exceedingly difficult to refactor later.',
        url: '',
      ),
      SearchResult(
        title: '5. Real-World Applications',
        summary:
            'Modern distributed systems heavily rely on $query for load balancing and fault tolerance. You will see this pattern natively integrated in systems mapping millions of concurrent socket connections.',
        url: '',
      ),
    ];
  }
}
