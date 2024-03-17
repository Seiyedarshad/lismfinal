import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String watchedKey = 'watched';
  static const String toWatchKey = 'to_watch';
  static const String watchedType = "Wtype";
  static const String toWatchType = "TWtype";

  // Add movie ID to the "to watch" list in shared preferences
  static Future<void> addToWatchList(int movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> toWatchList = prefs.getStringList(toWatchKey) ?? [];
    if (!toWatchList.contains(movieId.toString())) {
      toWatchList.add(movieId.toString());
      await prefs.setStringList(toWatchKey, toWatchList);
    }
  }

  // Add movie ID to the "watched" list in shared preferences
  static Future<void> addToWatchedList(int movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchedList = prefs.getStringList(watchedKey) ?? [];
    if (!watchedList.contains(movieId.toString())) {
      watchedList.add(movieId.toString());
      await prefs.setStringList(watchedKey, watchedList);
    }
  }

  // Add type of media (movie or TV show) to the "to watch" list in shared preferences
  static Future<void> addToWatchListType(bool isMovie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> toWatchListType = prefs.getStringList(toWatchType) ?? [];
    if (isMovie) {
      toWatchListType.add("movie");
      await prefs.setStringList(toWatchType, toWatchListType);
    } else {
      toWatchListType.add("tv");
      await prefs.setStringList(toWatchType, toWatchListType);
    }
  }

  // Add type of media (movie or TV show) to the "watched" list in shared preferences
  static Future<void> addWatchedListType(bool isMovie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchedListType = prefs.getStringList(watchedType) ?? [];
    if (isMovie) {
      watchedListType.add("movie");
      await prefs.setStringList(watchedType, watchedListType);
    } else {
      watchedListType.add("tv");
      await prefs.setStringList(watchedType, watchedListType);
    }
  }

  // Retrieve the list of movie IDs from the "watched" list in shared preferences
  static Future<List<String>> getWatchedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchedList = prefs.getStringList(watchedKey);
    return watchedList?.map((id) => (id)).toList() ?? [];
  }

  // Retrieve the list of movie IDs from the "to watch" list in shared preferences
  static Future<List<String>> getToWatchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? toWatchList = prefs.getStringList(toWatchKey);
    return toWatchList?.map((id) => (id)).toList() ?? [];
  }

  // Retrieve the list of media types (movie or TV show) from the "to watch" list in shared preferences
  static Future<List<String>> getToWatchListType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? toWatchListType = prefs.getStringList(toWatchType);
    return toWatchListType?.map((id) => (id)).toList() ?? [];
  }

  // Retrieve the list of media types (movie or TV show) from the "watched" list in shared preferences
  static Future<List<String>> getWatchedListType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchedListType = prefs.getStringList(watchedType);
    return watchedListType?.map((id) => (id)).toList() ?? [];
  }
}
