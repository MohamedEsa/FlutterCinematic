import 'package:flutter/material.dart';
import '../model/movie_relative_model.dart';

import '../shared/network/service/api_service.dart';

class MovieRelatedViewModel with ChangeNotifier {
  MovieRelative? movieRelative;

  var isLoading = false;

  void getMovieRelated({int? actorId}) async {
    isLoading = true;
    notifyListeners();

    movieRelative = await APIServices.getMovieRelative(actorId: actorId);
    // print('RelatedMovie are' '${movieRelative?.cast?[0].title}');
    isLoading = false;
    notifyListeners();
  }
}
