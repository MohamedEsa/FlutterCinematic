import 'package:flutter/material.dart';
import 'package:fluttercinematic/model/search_model.dart';
import '../model/popular_movie_model.dart';
import '../shared/network/service/api_service.dart';

class SearchViewModel with ChangeNotifier {
  // SearchRelative? searchRelative;
  List<SearchResult>? searchList = [];

  var isLoading = false;

  void getSearchResults({String? searchText}) async {
    if (searchText == null) {
      return null;
    } else {
      isLoading = true;
      notifyListeners();

      searchList = await APIServices.getSearchResults(searchText: searchText);

      isLoading = false;
      notifyListeners();
    }
  }
}
