import 'package:flutter/material.dart';

import 'actor_details_screen.dart';
import '../view_model/cast_view_model.dart';
import '../view_model/geners_view_model.dart';
import '../view_model/moviespecs_view_model.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final int index;
  final List? resultList;

  final int? movieId;

  const MovieDetailScreen({
    Key? key,
    required this.index,
    this.resultList,
    this.movieId,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<CastViewModel>(context, listen: false)
          .getDetailOfMovieList(movieId: widget.movieId);
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<MovieSpecsViewModel>(context, listen: false)
          .getMovieSpecs(movieId: widget.movieId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.resultList?[widget.index].releaseDate!);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            // pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                          child: SizedBox(
                            child: Text(
                              widget.resultList?[widget.index].releaseDate!
                                      .toString() ??
                                  '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 20.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                          child: Text(
                            widget.resultList![widget.index].voteAverage
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text('${widget.resultList?[widget.index].title}'),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Consumer<GenersViewModel>(builder: (context, model, _) {
                    List<String>? movielist = [];
                    for (int i = 0;
                        i < widget.resultList![widget.index].genreIds!.length;
                        i++) {
                      movielist.add(model.geners!
                          .firstWhere((element) =>
                              element.id ==
                              widget.resultList![widget.index].genreIds![i])
                          .name);
                    }
                    return SizedBox(
                      // width: 200.0,
                      height: 20,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: Text(movielist.join(', ').toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold)),
                          )),
                    );
                  }),
                ],
              ),
              background: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w600_and_h600_bestv2/'
                      '${widget.resultList![widget.index].posterPath!}')),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Text(
                    'Symposis',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(widget.resultList![widget.index].overview.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cast',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Consumer<CastViewModel>(builder: (context, model, _) {
                    return model.isLoading
                        ? const LinearProgressIndicator()
                        : SizedBox(
                            height: 290.0,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.detailOfMovie!.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 10.0,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActorDetailScreen(
                                                  actorId: model
                                                      .detailOfMovie![index]
                                                      .id!,
                                                  actorName: model
                                                      .detailOfMovie![index]
                                                      .name!,
                                                  actorImage:
                                                      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/'
                                                      '${model.detailOfMovie![index].profilePath}',
                                                )));
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                              'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/'
                                              '${model.detailOfMovie![index].profilePath}'),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 100.0,
                                                child: Text(
                                                    '${model.detailOfMovie![index].name}',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  SizedBox(
                                                    width: 100.0,
                                                    child: Text(
                                                        '${model.detailOfMovie![index].character}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text('About',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Consumer<MovieSpecsViewModel>(builder: (context, model, _) {
                    return model.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Original Title:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${widget.resultList![widget.index].title}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Status:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text('${model.movieSpecs?.status}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Run Time:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${model.movieSpecs?.runtime} min',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Type:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Consumer<GenersViewModel>(
                                        builder: (context, generModel, _) {
                                      List<String>? movielist = [];

                                      for (int i = 0;
                                          i <
                                              widget.resultList![widget.index]
                                                  .genreIds!.length;
                                          i++) {
                                        movielist.add(generModel.geners!
                                            .firstWhere((element) =>
                                                element.id ==
                                                widget.resultList![widget.index]
                                                    .genreIds![i])
                                            .name);
                                      }

                                      return Text(
                                          movielist.join(', ').toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold));
                                      //color: Colors.green,
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Premiere:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                        //'${model.movieSpecs?.releaseDate!.DateFormat.yMMMEd()}',
                                        model.movieSpecs?.releaseDate == null
                                            ? ''
                                            : DateFormat.yMMMEd().format(
                                                model.movieSpecs!.releaseDate),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Budget:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                        model.movieSpecs?.budget == null
                                            ? ''
                                            : '${model.movieSpecs!.budget! ~/ 1000000} Milion dollar',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Revenue:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                        model.movieSpecs?.revenue == null
                                            ? ''
                                            : '${model.movieSpecs!.revenue! ~/ 1000000} Milion dollar',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100.0,
                                    child: Text('Homepage:',
                                        style: TextStyle(
                                          color: Colors.white30,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text('${model.movieSpecs?.homepage}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
