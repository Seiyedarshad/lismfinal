import 'dart:convert';
import 'package:http/http.dart' as http;

import 'localStorage.dart';

class api {
  static List<dynamic> popularM = [];
  static List<dynamic> populartv = [];
  static List<dynamic> topRatedTVList = [];
  static List<dynamic> upcomingTVList = [];
  static List<dynamic> highestGrossM = [];
  static List<dynamic> mostGrossingTVList = [];
  static List<dynamic> trendingMoviesListDay = [];
  static List<dynamic> trendingMoviesListWeek = [];
  static List<dynamic> upcomingMoviesList = [];
  static List<dynamic> topRatedMList = [];
  static List<dynamic> nowShowingList = [];
  static List<dynamic> searchList = [];
  static late Map<dynamic, dynamic> viewMovieTVMap;
  static List<dynamic> watchedList = [];
  static List<dynamic> towatchedList = [];

  static var headers = {
    "accept": "application/json",
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZmIyMDE4MWI0N2MzNmQ5ODk1ZTM1NGQ5NmViNTA5OSIsInN1YiI6IjY1Nzg5Yzg3MzVhNjFlMDBhZDg3OTllOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fGLUrPkb1-d9_25Bb7AspWxeUTQXXZyYQWJdgrWwNJY",
  };

  static Future<void> trendingMoviesDay() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/day?language=en-US');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        trendingMoviesListDay = decodedResponse['results'];
      }
    }
  }

  static Future<void> trendingMoviesWeek() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?language=en-US');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        trendingMoviesListWeek = decodedResponse['results'];
      }
    }
  }

  static Future<void> upcomingMovies() async {
    var url =
        Uri.parse('https://api.themoviedb.org/3/movie/upcoming?language=en-US');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        upcomingMoviesList = decodedResponse['results'];
      }
    }
  }

  static Future<void> topRatedM() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        topRatedMList = decodedResponse['results'];
      }
    }
  }

  static Future<void> topRatedTV() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?language=en-US&page=1');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        topRatedTVList = decodedResponse['results'];
      }
    }
  }

  static Future<void> viewMovie(int ID) async {
    var url =
        Uri.parse('https://api.themoviedb.org/3/movie/${ID}?language=en-US');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        viewMovieTVMap = decodedResponse;
      }
    }
  }

  static Future<void> viewShow(int ID) async {
    var url = Uri.parse('https://api.themoviedb.org/3/tv/${ID}?language=en-US');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        viewMovieTVMap = decodedResponse;
      }
    }
  }

  static Future<void> popularMovies() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?language=en-us&page=1');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        popularM = decodedResponse['results'];
      }
    }
  }

  static Future<void> popularTV() async {
    var url =
        Uri.parse('https://api.themoviedb.org/3/tv/popular?language=en-us');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        populartv = decodedResponse['results'];
      }
    }
  }

  static Future<void> mostGrossingM() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?include_video=false&language=en-US&page=1&sort_by=revenue.desc');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        highestGrossM = decodedResponse['results'];
      }
    }
  }

  static Future<void> nowplaying() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        nowShowingList = decodedResponse['results'];
      }
    }
  }

  static Future<void> searchmoviesTV(String type, String query) async {
    searchList.clear();
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/${type}?query=${query}&language=en-US&page=1');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map) {
        searchList = decodedResponse['results'];
      }
    }
  }

  static Future<void> searchtoWatchList() async {
    towatchedList.clear();
    List<String> listID = await LocalStorage.getToWatchList();
    List<String> typeID = await LocalStorage.getToWatchListType();
    int index = 0;
    while (index < listID.length) {
      var url = Uri.parse(
          'https://api.themoviedb.org/3/${typeID[index]}/${listID[index]}?language=en-US');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map) {
          towatchedList.add(decodedResponse);
        }
      }
      index = index + 1;
    }
  }

  static Future<void> searchWatchedList() async {
    watchedList.clear();
    List<String> listTypeID = await LocalStorage.getWatchedList();
    List<String> typeTypeID = await LocalStorage.getWatchedListType();
    int index = 0;
    while (index < typeTypeID.length) {
      var url = Uri.parse(
          'https://api.themoviedb.org/3/${typeTypeID[index]}/${listTypeID[index]}?language=en-US');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map) {
          watchedList.add(decodedResponse);
        }
      }
      index = index + 1;
    }
  }
}
