import 'package:flutter/material.dart';
import '../model/popular_movie_model.dart';
import '../view_model/geners_view_model.dart';
import '../view_model/upcoming_movies_view_model%20.dart';
import 'package:provider/provider.dart';

class UpcomingDemo extends StatelessWidget {
  const UpcomingDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UpcomingMoviesViewModel>(builder: (context, model, _) {
      return ListView.builder(
        itemBuilder: (_, index) => buildMovieCard(model.upcomingList, index),
        itemCount: model.upcomingList?.length,
      );
    });
  }
}

Widget buildMovieCard(List<Result>? resultList, index) => InkWell(
      onTap: () {},
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
            Container(
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
                        Consumer<GenersViewModel>(
                            builder: (context, generModel, _) {
                          List<String>? movielist = [];

                          for (int i = 0;
                              i < resultList[index].genreIds!.length;
                              i++) {
                            movielist.add(generModel.geners!
                                .firstWhere((element) =>
                                    element.id ==
                                    resultList[index].genreIds![i])
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
            )
          ],
        ),
      ),
    );
