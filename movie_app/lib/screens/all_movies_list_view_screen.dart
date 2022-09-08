import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/all_movies_provider.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
import 'movies_page_view_screen.dart';

class AllMoviesListViewScreen extends StatelessWidget {
  const AllMoviesListViewScreen({
    Key? key,
    required this.allMoviesData,
    required this.favMoviesData,
    required this.watchedMoviesData,
  }) : super(key: key);

  final AllMoviesProvider allMoviesData;
  final FavoriteMovieProvider favMoviesData;
  final WatchedMoviesProvider watchedMoviesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies To Watch'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        itemCount: allMoviesData.allMoviePagesList.length,
        itemBuilder: (context, index) {
          Movie currentMovie = allMoviesData.allMovies[index];
          return Dismissible(
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
            onDismissed: (direction) {
              // on left direction
              if (direction == DismissDirection.endToStart) {
                allMoviesData.removeMovie(currentMovie);
              }
            },
            key: UniqueKey(),
            child: ListTile(
              leading: Hero(
                tag: index,
                child: Image.network(
                  currentMovie.image,
                  height: 100,
                  width: 100,
                ),
              ),
              title: Text(
                currentMovie.title,
              ),
              subtitle: Text(
                currentMovie.genre,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
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
                  IconButton(
                    onPressed: () {
                      watchedMoviesData.toggleWatched(currentMovie);
                    },
                    icon: Icon(
                      currentMovie.isWatched
                          ? Icons.check_circle_rounded
                          : Icons.check_circle_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MoviePageViewScreen(
                      initalIndex: index,
                      children: allMoviesData.allMoviePagesList,
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
