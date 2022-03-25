import 'package:flutter/material.dart';
import '../model/geners_model.dart';

import '../shared/network/service/api_service.dart';

class GenersViewModel with ChangeNotifier {
  List<Genre>? geners = [];
  bool isLoading = false;
  void getGeners() async {
    isLoading = true;
    notifyListeners();
    geners = await APIServices.getGeners();

    isLoading = false;
    notifyListeners();
  }
}
