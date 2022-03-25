import 'package:flutter/material.dart';
import '../view_model/movie_relate_view_model.dart';
import 'package:provider/provider.dart';
import '../shared/components/components.dart';

class ActorDetailScreen extends StatefulWidget {
  final String actorName;
  final String actorImage;
  final int? actorId;
  // final List<Result>? resultList;

  //
  const ActorDetailScreen({
    required this.actorImage,
    required this.actorName,
    required this.actorId,
    //  this.resultList
  });

  @override
  _ActorDetailScreenState createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<MovieRelatedViewModel>(context, listen: false)
          .getMovieRelated(actorId: widget.actorId);
    });

    _tabController = TabController(
      initialIndex: 0,
      length: 1,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieRelatedViewModel>(builder: (context, model, _) {
        return model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                // floatHeaderSlivers: true,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 240.0,
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.red.shade400,
                            Colors.blue.shade900,
                            Colors.blue,
                          ],
                        )),
                        child: FlexibleSpaceBar(
                            background: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(
                                  widget.actorImage,
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.actorName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                      ),
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      bottom: TabBar(
                          indicatorColor: Colors.black,
                          labelPadding: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          controller: _tabController,
                          tabs: const [
                            // Icon(Icons.movie_creation_outlined),
                            Icon(Icons.computer_outlined)
                          ]),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    // TabA(),
                    TabB(model, context),
                  ],
                ),
              );
      }),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}

class TabB extends StatelessWidget {
  final MovieRelatedViewModel movieRelative;
  const TabB(this.movieRelative, BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.separated(
      separatorBuilder: (context, child) => const Divider(
        height: 1,
      ),
      padding: const EdgeInsets.all(0.0),
      itemCount: movieRelative.movieRelative!.cast!.length,
      itemBuilder: (context, i) {
        return buildMovieCard(
            model: movieRelative.movieRelative, index: i, context: context);
      },
    ));
  }
}
