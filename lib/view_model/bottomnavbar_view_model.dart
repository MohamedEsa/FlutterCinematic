import 'package:flutter/cupertino.dart';
import 'package:fluttercinematic/screens/toprated_screen.dart';
import 'package:fluttercinematic/screens/upcoming_screen.dart';
import '../screens/popularmovies_screen_.dart';

class BottomNavigatorViewModel with ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const PopularMoviesScreen(),
    const UpcomingDemo(),
    const TopratedDemo()
  ];
}
