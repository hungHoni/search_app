import 'package:flutter/material.dart';

import '../../domain/models/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../../infrastructure/gemini_search_service.dart';
import '../widgets/result_list_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Dependency injection (simplified for this minimal app)
  final SearchRepository _searchService = GeminiSearchService();

  bool _isLoading = false;
  bool _hasSearched = false;
  List<SearchResult> _results = [];
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _errorMessage = null;
    });

    try {
      final results = await _searchService.fetchResults(query);
      if (mounted) {
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Something went wrong fetching the results.";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // We use a responsive layout that changes based on whether a search has occurred.
    // If not searched, the input is vertically centered. If searched, it moves up.
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                // Pushes the search bar down towards the center initially, then collapses to zero.
                height: _hasSearched ? 0 : screenHeight * 0.35,
              ),
              _buildSearchBar(context),
              if (_hasSearched) ...[
                const SizedBox(height: 32),
                Expanded(child: _buildBody()),
              ] else ...[
                const SizedBox(height: 48),
                _buildKeywordChips(),
                // Fills remaining space so the search bar stays positioned nicely
                const Spacer(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeywordChips() {
    final keywords = [
      'System Design',
      'Data Structures',
      'Dynamic Programming',
      'Big O Notation',
      'Machine Learning',
      'Microservices',
    ];

    return Wrap(
      spacing: 12.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      children: keywords.map((keyword) {
        return InkWell(
          onTap: () {
            _searchController.text = keyword;
            _submitSearch(keyword);
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              keyword,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      focusNode: _focusNode,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 28,
      ),
      decoration: InputDecoration(
        hintText: 'Ask anything...',
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 28,
          color: Theme.of(context).hintColor,
        ),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: _submitSearch,
      autofocus: true,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Text(
          'No insights found.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ResultListView(results: _results);
  }
}
