// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../model/popular_movie_model.dart';
import '../shared/network/service/api_service.dart';

class UpcomingMoviesViewModel with ChangeNotifier {
  List<Result>? upcomingList = [];
  bool isLoading = false;

  void getUpcoming() async {
    isLoading = true;
    upcomingList = await APIServices.getUpcomingMovies();
    isLoading = false;
    notifyListeners();
  }
}
