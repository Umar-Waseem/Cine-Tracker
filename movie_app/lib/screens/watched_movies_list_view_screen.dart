import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
import 'movies_page_view_screen.dart';

class WatchedMoviesListViewScreen extends StatelessWidget {
  const WatchedMoviesListViewScreen({
    Key? key,
    required this.favMoviesData,
    required this.watchedMoviesData,
  }) : super(key: key);

  final FavoriteMovieProvider favMoviesData;
  final WatchedMoviesProvider watchedMoviesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watched Movies'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        itemCount: watchedMoviesData.watchedMovies.length,
        itemBuilder: (context, index) {
          Movie currentMovie = watchedMoviesData.watchedMovies[index];
          return ListTile(
            leading: Hero(
              tag: index,
              child: Image.asset(
                currentMovie.image,
                height: 100,
                width: 100,
              ),
            ),
            title: Text(currentMovie.title),
            subtitle: Text(currentMovie.description),
            trailing: IconButton(
              onPressed: () {
                favMoviesData.toggleFavorite(currentMovie);
              },
              icon: Icon(
                currentMovie.isFav
                    ? Icons.favorite_outlined
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MoviePageViewScreen(
                    initalIndex: index,
                    children: watchedMoviesData.watchedMoviePages,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
