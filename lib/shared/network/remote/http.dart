import 'dart:convert' as convert;
import 'package:fluttercinematic/model/search_model.dart';

import '../../../model/cast.dart';
import '../../../model/movie_relative_model.dart';
import '../../../model/movie_specs.dart';

import '../../../model/geners_model.dart';
import '../../../model/popular_movie_model.dart';
import 'api_routs.dart';
import 'package:http/http.dart' as http;

class APICienmatic {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview

  // Await the http get response, then decode the json-formatted response.
  static List<Result>? results = [];
  static List<SearchResult>? searchResult;
  static List<Genre>? geners;
  static List<Cast>? detailOfMovie;
  static int? movieId;
  static int? actorId;
  static MovieSpecs? movieSpecs;
  static MovieRelative? movieRelative;

  static Future<List<Result>?> getResultsData(
      {required String route, Map? query}) async {
    var url =
        Uri.https(ApiRoutes.baseURL, route, {'api_key': ApiRoutes.apiKey});
    var response = await http.get(
      url,
    );

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    results = PopularMovies.fromJson(jsonResponse).results;
    return results;
  }

  static Future<List<Genre>?> getGeners({
    required String route,
    Map? query,
  }) async {
    var url = Uri.https(ApiRoutes.baseURL, route, {
      'api_key': ApiRoutes.apiKey,
    });
    var response = await http.get(
      url,
    );

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    geners = MovieGeners.fromJson(jsonResponse).genres;

    return geners;
  }

  static Future<List<Cast>?> getDetialOfmovie(
      {required String route, Map? query, int? movieId}) async {
    var url = Uri.https(ApiRoutes.baseURL, route, {
      'api_key': ApiRoutes.apiKey,
    });

    var response = await http.get(
      url,
    );

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    detailOfMovie = DetailOfMovie.fromJson(jsonResponse).cast;

    return detailOfMovie;
  }

  static Future<MovieSpecs?> getMovieSpec(
      {required String route, Map? query, int? movieId}) async {
    var url = Uri.https(ApiRoutes.baseURL, route, {
      'api_key': ApiRoutes.apiKey,
    });

    var response = await http.get(
      url,
    );

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    movieSpecs = MovieSpecs.fromJson(jsonResponse);

    return movieSpecs;
  }

  static Future<MovieRelative?> getMovieRelative({
    required String route,
    Map? query,
  }) async {
    var url = Uri.https(ApiRoutes.baseURL, route, {
      'api_key': ApiRoutes.apiKey,
    });

    var response = await http.get(
      url,
    );

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    movieRelative = MovieRelative.fromJson(jsonResponse);

    return movieRelative;
  }

  static Future<List<SearchResult>?> getSearchResult({
    required String route,
    String? query,
  }) async {
    var url = Uri.https(ApiRoutes.baseURL, route,
        {'api_key': ApiRoutes.apiKey, 'query': query});

    var response = await http.get(
      url,
    );
    print(url.toString());
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    searchResult = SearchRelative.fromJson(jsonResponse).results;

    return searchResult;
  }
}
