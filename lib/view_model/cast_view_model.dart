import 'package:flutter/material.dart';
import '../model/cast.dart';

import '../shared/network/service/api_service.dart';

class CastViewModel with ChangeNotifier {
  List<Cast>? detailOfMovie = [];

  var isLoading = false;

  void getDetailOfMovieList({int? movieId}) async {
    isLoading = true;
    notifyListeners();

    detailOfMovie = await APIServices.getDetailOfMovie(movieId: movieId);

    isLoading = false;
    notifyListeners();
  }
}
