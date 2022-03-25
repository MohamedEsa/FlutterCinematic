class ApiRoutes {
  static const String baseURL = 'api.themoviedb.org';
  static const String pathURL = '3/movie';
  static int? movieId;
  static const String apiKey = '962fbd5f59680b7d07a45663221c16bf';
  static const String popular = '$pathURL/popular/';
  static const String topRated = '$pathURL/top_rated';
  static const String upcoming = '$pathURL/upcoming';
  static const String geners = '3/genre/movie/list';
  static const String search = '3/search/movie';
}
