import 'package:flutter/material.dart';
import '../model/popular_movie_model.dart';
import '../shared/network/service/api_service.dart';

class TopratedMoviesViewModel with ChangeNotifier {
  List<Result>? topRatedList = [];
  bool isLoading = false;
  void getToprated() async {
    isLoading = true;
    notifyListeners();
    topRatedList = await APIServices.getTopratedMovies();
    isLoading = false;
    notifyListeners();
  }
}
