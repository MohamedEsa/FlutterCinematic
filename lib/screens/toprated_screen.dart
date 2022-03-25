import 'package:flutter/material.dart';
import 'package:fluttercinematic/view_model/toprated_view_model.dart';
import 'movie_details_screen.dart';
import '../model/popular_movie_model.dart';
import '../view_model/geners_view_model.dart';

import 'package:provider/provider.dart';

class TopratedDemo extends StatelessWidget {
  const TopratedDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TopratedMoviesViewModel>(builder: (context, model, _) {
      return model.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (_, index) =>
                  buildMovieCard(model.topRatedList, index, context),
              itemCount: model.topRatedList?.length,
            );
    });
  }
}

Widget buildMovieCard(
  List<Result>? resultList,
  index,
  context,
) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      index: index,
                      resultList: resultList,
                      movieId: resultList?[index].id,
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
              image: NetworkImage(
                'https://www.themoviedb.org/t/p/w600_and_h600_bestv2/'
                '${resultList![index].posterPath!}',
              ),
              fit: BoxFit.fill,
            ),
            Consumer<GenersViewModel>(builder: (context, generModel, _) {
              if (generModel.isLoading) {
                return const CircularProgressIndicator();
              }

              List<String>? movielist = [];
              for (int i = 0; i < resultList[index].genreIds!.length; i++) {
                movielist.add(
                  generModel.geners!
                      .firstWhere((element) =>
                          element.id == resultList[index].genreIds![i])
                      .name,
                );
              }
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // leftColumn

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(resultList[index].title!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(movielist.join(', ').toString())
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
                              Text(resultList[index].voteAverage.toString()),
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
                            resultList[index].releaseDate!.year.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
