import '../remote/api_routs.dart';
import '../remote/http.dart';

class APIServices {
  static getPopularMovies() {
    var response = APICienmatic.getResultsData(route: ApiRoutes.popular);
    return response;
  }

  static getUpcomingMovies() {
    var response = APICienmatic.getResultsData(route: ApiRoutes.upcoming);
    return response;
  }

  static getTopratedMovies() {
    var response = APICienmatic.getResultsData(route: ApiRoutes.topRated);
    return response;
  }

  static getGeners() {
    var response = APICienmatic.getGeners(route: ApiRoutes.geners);
    return response;
  }

  static getDetailOfMovie({int? movieId}) {
    var response = APICienmatic.getDetialOfmovie(
      route: '3/movie/$movieId/credits',
    );
    return response;
  }

  static getMovieSpecs({int? movieId}) {
    var response = APICienmatic.getMovieSpec(
      route: '3/movie/$movieId',
    );
    return response;
  }

  static getMovieRelative({int? actorId}) {
    var response = APICienmatic.getMovieRelative(
      route: '3/person/$actorId/movie_credits',
    );
    return response;
  }

  static getSearchResults({String? searchText}) {
    var response = APICienmatic.getSearchResult(
        route: ApiRoutes.search, query: searchText);
    return response;
  }
}
