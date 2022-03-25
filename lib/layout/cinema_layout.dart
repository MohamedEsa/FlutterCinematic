import 'package:flutter/material.dart';
import 'package:fluttercinematic/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../model/popular_movie_model.dart';
import '../view_model/bottomnavbar_view_model.dart';
import '../view_model/geners_view_model.dart';

class CinemaLayout extends StatelessWidget {
  const CinemaLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Cinematic'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
      bottomNavigationBar:
          Consumer<BottomNavigatorViewModel>(builder: (context, model, _) {
        return BottomNavigationBar(
          onTap: (index) {
            model.changeIndex(index);
          },
          currentIndex: model.currentIndex,
          items: const [
            BottomNavigationBarItem(
                label: 'Popular', icon: Icon(Icons.thumb_up)),
            BottomNavigationBarItem(
                label: 'Upcoming', icon: Icon(Icons.timelapse_outlined)),
            BottomNavigationBarItem(label: 'Top Rated', icon: Icon(Icons.star)),
          ],
        );
      }),
      body: Consumer<BottomNavigatorViewModel>(builder: (context, model, _) {
        return model.screens[model.currentIndex];
      }),
    );
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
                          // generModel.getGeners();
                          return Container(
                            color: Colors.green,
                            height: 25.0,
                            width: double.infinity,
                            child: ListView.separated(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => const Text(''),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                itemCount: resultList[index].genreIds!.length),
                          );
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
