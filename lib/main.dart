import 'package:flutter/material.dart';
import 'package:fluttercinematic/view_model/search_view_model.dart';
import 'view_model/cast_view_model.dart';
import 'view_model/movie_relate_view_model.dart';
import 'view_model/moviespecs_view_model.dart';

import 'layout/cinema_layout.dart';
import 'view_model/bottomnavbar_view_model.dart';
import 'view_model/geners_view_model.dart';
import 'view_model/popular_movies_view_model.dart';
import 'view_model/toprated_view_model.dart';
import 'view_model/upcoming_movies_view_model%20.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavigatorViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PopularMoviesViewModel()..getPopular(),
        ),
        ChangeNotifierProvider(
          create: (_) => GenersViewModel()..getGeners(),
        ),
        ChangeNotifierProvider(
            create: (_) => UpcomingMoviesViewModel()..getUpcoming()),
        ChangeNotifierProvider(
            create: (_) => TopratedMoviesViewModel()..getToprated()),
        ChangeNotifierProvider(
          create: (_) => CastViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieSpecsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieRelatedViewModel(),
        ),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
      ],
      child: const MaterialApp(
        home: CinemaLayout(),
      ),
    );
  }
}
