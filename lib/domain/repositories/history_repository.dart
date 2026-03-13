import 'package:shared_preferences/shared_preferences.dart';

/// A simple repository that tracks the user's search history locally.
/// It maintains a list of the 20 most recent unique search terms.
class HistoryRepository {
  static const String _historyKey = 'search_history_list';
  static const int _maxHistoryCount = 20;

  /// Private constructor for singleton
  HistoryRepository._internal();
  static final HistoryRepository _instance = HistoryRepository._internal();
  factory HistoryRepository() => _instance;

  /// Adds a new search term to the history. 
  /// Moves it to the top if it already exists.
  Future<void> addSearch(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    
    // Remove if already exists (to move it to top)
    history.removeWhere((item) => item.toLowerCase() == query.trim().toLowerCase());
    
    // Insert at start
    history.insert(0, query.trim());
    
    // Limit size
    if (history.length > _maxHistoryCount) {
      history.removeRange(_maxHistoryCount, history.length);
    }
    
    await prefs.setStringList(_historyKey, history);
  }

  /// Retrieves the list of recent search terms.
  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }

  /// Clears the entire search history.
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
