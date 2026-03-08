import 'package:flutter/material.dart';

import '../../domain/models/search_result.dart';
import 'animated_fade_item.dart';

class ResultListView extends StatelessWidget {
  final List<SearchResult> results;

  const ResultListView({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
      itemBuilder: (context, index) {
        final result = results[index];
        return AnimatedFadeItem(
          // Stagger the animation delay so they appear sequentially
          delay: Duration(milliseconds: 100 + (index * 150)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SEARCH RESULT',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  result.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  result.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
