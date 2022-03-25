import 'package:flutter/material.dart';
import '../model/movie_specs.dart';

import '../shared/network/service/api_service.dart';

class MovieSpecsViewModel with ChangeNotifier {
  MovieSpecs? movieSpecs;

  var isLoading = false;

  void getMovieSpecs({int? movieId}) async {
    isLoading = true;
    notifyListeners();

    movieSpecs = await APIServices.getMovieSpecs(movieId: movieId);

    isLoading = false;
    notifyListeners();
  }
}
