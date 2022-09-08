import 'package:cached_network_image/cached_network_image.dart';
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
          return Dismissible(
            key: UniqueKey(),
            dismissThresholds: const {
              DismissDirection.endToStart: 0.8,
            },
            direction: DismissDirection.endToStart,
            background: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              leading: Hero(
                tag: index,
                child: CachedNetworkImage(
                  imageUrl: currentMovie.image,
                  placeholder: (context, url) => const CircleAvatar(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text(currentMovie.title),
              subtitle: Text(currentMovie.genre),
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
            ),
          );
        },
      ),
    );
  }
}
