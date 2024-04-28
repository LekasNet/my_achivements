import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static List<String> searchQueries = [];

  static Future<void> loadSearchQueries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    searchQueries = prefs.getStringList('searchQueries') ?? [];
  }

  static Future<void> addSearchQuery(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (query.isNotEmpty && !searchQueries.contains(query)) {
      if (searchQueries.length >= 10) {
        searchQueries.removeAt(0); // Удаление самого старого запроса, если достигнут лимит
      }
      searchQueries.add(query);
      await prefs.setStringList('searchQueries', searchQueries);
    }
  }
}
