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
  final controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    final allMoviesData = Provider.of<AllMoviesProvider>(context);
    final favMoviesData = Provider.of<FavoriteMovieProvider>(context);
    final watchedMoviesData = Provider.of<WatchedMoviesProvider>(context);
    return Scaffold(
      
      backgroundColor: Colors.black,
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: [
          WatchedMoviesListViewScreen(
            watchedMoviesData: watchedMoviesData,
            favMoviesData: favMoviesData,
          ),
          AllMoviesListViewScreen(
            allMoviesData: allMoviesData,
            favMoviesData: favMoviesData,
          ),
          FavroiteMoviesListViewScreen(
            favMoviesData: favMoviesData,
          ),
        ],
      ),
    );
  }
}
