import 'package:flutter/material.dart';
import '../model/popular_movie_model.dart';
import '../shared/network/service/api_service.dart';

class PopularMoviesViewModel with ChangeNotifier {
  List<Result>? popularList = [];
  bool isLoading = false;
  void getPopular() async {
    isLoading = true;
    notifyListeners();
    popularList = await APIServices.getPopularMovies();

    isLoading = false;
    notifyListeners();
  }
}
