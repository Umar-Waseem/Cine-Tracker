import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/all_movies_provider.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
import 'all_movies_list_view_screen.dart';
import 'fav_movies_list_view_screen.dart';
import 'watched_movies_list_view_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final controller = TabController();
  @override
  Widget build(BuildContext context) {
    final allMoviesData = Provider.of<AllMoviesProvider>(context);
    final favMoviesData = Provider.of<FavoriteMovieProvider>(context);
    final watchedMoviesData = Provider.of<WatchedMoviesProvider>(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: TabBarView(
          children: [
            WatchedMoviesListViewScreen(
              watchedMoviesData: watchedMoviesData,
              favMoviesData: favMoviesData,
            ),
            AllMoviesListViewScreen(
              watchedMoviesData: watchedMoviesData,
              allMoviesData: allMoviesData,
              favMoviesData: favMoviesData,
            ),
            FavroiteMoviesListViewScreen(
              favMoviesData: favMoviesData,
              watchedMoviesData: watchedMoviesData,
            ),
          ],
        ),
        bottomNavigationBar: const TabBar(
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.red,
          // padding: EdgeInsets.all(10),
          tabs: [
            Tab(
              icon: Icon(Icons.check),
            ),
            Tab(
              icon: Icon(Icons.movie),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}
