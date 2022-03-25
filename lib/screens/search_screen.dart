import 'package:flutter/material.dart';
import 'package:fluttercinematic/model/popular_movie_model.dart';
import 'package:fluttercinematic/view_model/geners_view_model.dart';
import 'package:fluttercinematic/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

import 'movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  var searchList;
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, model, _) {
      searchList = model.searchList;
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            // The search area here
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onChanged: (String value) {
                    model.getSearchResults(searchText: value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                          setState(() {
                            searchController.clear();
                            model.searchList?.clear();
                          });
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            )),
        body: model.searchList == null || model.searchList!.isEmpty
            ? const Center(child: Text('No Search Result ! '))
            : ListView.separated(
                itemBuilder: (context, index) => SizedBox(
                      height: 10.0,
                    ),
                separatorBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                      index: index,
                                      resultList: model.searchList,
                                      movieId: model.searchList?[index].id,
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
                              image: model.searchList?[index].posterPath == null
                                  ? const NetworkImage(
                                      'https://image.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-5529.jpg')
                                  : NetworkImage(
                                      'https://www.themoviedb.org/t/p/w600_and_h600_bestv2/'
                                      '${model.searchList?[index].posterPath}',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(model.searchList![index].title!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Consumer<GenersViewModel>(
                                            builder: (context, generModel, _) {
                                          List<String>? movielist = [];

                                          for (int i = 0;
                                              i <
                                                  model.searchList![index]
                                                      .genreIds!.length;
                                              i++) {
                                            movielist.add(generModel.geners!
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    model.searchList![index]
                                                        .genreIds?[i])
                                                .name);
                                          }

                                          return Text(
                                              movielist.join(', ').toString());
                                          //color: Colors.green,
                                        })
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                '${model.searchList?[index].voteAverage}'),
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
                                          '${model.searchList?[index].releaseDate!.year}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
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
                    ),
                itemCount: model.searchList?.length ?? 0),
      );
    });
  }
}
