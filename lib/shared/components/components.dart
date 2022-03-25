import 'package:flutter/material.dart';
import 'package:fluttercinematic/screens/movie_details_screen.dart';
import '../../model/movie_relative_model.dart';
import '../../view_model/geners_view_model.dart';
import 'package:provider/provider.dart';

Widget buildMovieCard(
        {MovieRelative? model,
        required int index,
        required BuildContext context}) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      index: index,
                      resultList: model?.cast,
                      movieId: model?.cast![index].id,
                    )));
      },
      child: Card(
        semanticContainer: true,
        elevation: 2.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Image(
              height: 200.0,
              width: double.infinity,
              image: model?.cast?[index].posterPath != null
                  ? NetworkImage(
                      'https://www.themoviedb.org/t/p/w600_and_h600_bestv2/'
                      '${model?.cast?[index].posterPath}',
                    )
                  : const NetworkImage(
                      'https://image.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-5529.jpg'),
              fit: BoxFit.fill,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  // leftColumn

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model!.cast![index].title!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Consumer<GenersViewModel>(
                            builder: (context, generModel, _) {
                          List<String>? movielist = [];

                          for (int i = 0;
                              i < model.cast![index].genreIds!.length;
                              i++) {
                            movielist.add(generModel.geners!
                                .firstWhere((element) =>
                                    element.id ==
                                    model.cast?[index].genreIds?[i])
                                .name);
                          }

                          return Text(movielist.join(', ').toString());
                          //color: Colors.green,
                        })
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(model.cast?[index].voteAverage.toString() ??
                                ''),
                            const Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 17.0,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          model.cast?[index].releaseDate.toString() ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
