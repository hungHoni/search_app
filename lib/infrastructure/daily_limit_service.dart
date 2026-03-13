import 'package:shared_preferences/shared_preferences.dart';

class DailyLimitService {
  static final DailyLimitService _instance = DailyLimitService._internal();
  factory DailyLimitService() => _instance;
  DailyLimitService._internal();

  static const int _dailyLimit = 5;
  static const String _dateKey = 'last_generation_date';
  static const String _countKey = 'generation_count';

  Future<bool> canGenerate() async {
    final prefs = await SharedPreferences.getInstance();
    final String todayString = _getTodayString();
    
    final String? lastDate = prefs.getString(_dateKey);
    final int count = prefs.getInt(_countKey) ?? 0;

    // If it's a new day, reset the count 
    if (lastDate != todayString) {
      await prefs.setString(_dateKey, todayString);
      await prefs.setInt(_countKey, 0);
      return true; // 0 < 5
    }

    // Same day, check limit
    return count < _dailyLimit;
  }

  Future<void> incrementGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    final String todayString = _getTodayString();
    
    final String? lastDate = prefs.getString(_dateKey);
    int count = prefs.getInt(_countKey) ?? 0;

    if (lastDate != todayString) {
      // Should rarely happen if we call canGenerate right before,
      // but just to be safe.
      count = 0;
      await prefs.setString(_dateKey, todayString);
    }

    await prefs.setInt(_countKey, count + 1);
  }

  Future<int> getGenerationsLeft() async {
    final prefs = await SharedPreferences.getInstance();
    final String todayString = _getTodayString();
    
    final String? lastDate = prefs.getString(_dateKey);
    final int count = prefs.getInt(_countKey) ?? 0;

    if (lastDate != todayString) {
      return _dailyLimit;
    }

    final int left = _dailyLimit - count;
    return left < 0 ? 0 : left;
  }

  String _getTodayString() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }
}
