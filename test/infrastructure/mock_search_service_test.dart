import 'package:flutter_test/flutter_test.dart';
import 'package:search_app/infrastructure/mock_search_service.dart';

void main() {
  group('MockSearchService Tests', () {
    late MockSearchService service;

    setUp(() {
      service = MockSearchService();
    });

    test('fetchResults should return exactly 5 SearchResult objects', () async {
      final results = await service.fetchResults('System Design');

      expect(results.length, 5);
    });

    test(
      'fetchResults should contain the query in the educational summary',
      () async {
        const query = 'Data Structures';
        final results = await service.fetchResults(query);

        // We expect the first component (Core Concept) to mention the query in the summary
        expect(results[0].summary.contains(query), isTrue);
      },
    );

    test('fetchResults should have the correct 5-part titles', () async {
      final results = await service.fetchResults('Machine Learning');

      expect(results[0].title, '1. The Core Concept');
      expect(results[1].title, '2. Key Components & Implementation');
      expect(results[2].title, '3. Time & Space Complexity');
      expect(results[3].title, '4. Common Pitfalls');
      expect(results[4].title, '5. Real-World Applications');
    });
  });
}
