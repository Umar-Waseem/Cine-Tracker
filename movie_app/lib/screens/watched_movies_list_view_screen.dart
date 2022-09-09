import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
import '../widgets/rating_bar.dart';
import 'movies_page_view_screen.dart';

class WatchedMoviesListViewScreen extends StatefulWidget {
  const WatchedMoviesListViewScreen({
    Key? key,
    required this.favMoviesData,
    required this.watchedMoviesData,
  }) : super(key: key);

  final FavoriteMovieProvider favMoviesData;
  final WatchedMoviesProvider watchedMoviesData;

  @override
  State<WatchedMoviesListViewScreen> createState() =>
      _WatchedMoviesListViewScreenState();
}

class _WatchedMoviesListViewScreenState
    extends State<WatchedMoviesListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watched Movies'),
      ),
      body: ListView.builder(
        itemCount: widget.watchedMoviesData.watchedMovies.length,
        itemBuilder: (context, index) {
          Movie currentMovie = widget.watchedMoviesData.watchedMovies[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 20,
            child: Dismissible(
              dismissThresholds: const {
                DismissDirection.endToStart: 0.8,
              },
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.all(10),
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
                  widget.watchedMoviesData.removeMovie(currentMovie);
                }
              },
              key: UniqueKey(),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MoviePageViewScreen(
                            initalIndex: index,
                            children:
                                widget.watchedMoviesData.watchedMoviePages,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Hero(
                        tag: index,
                        child: CachedNetworkImage(
                          imageUrl: currentMovie.image,
                          placeholder: (context, url) => const CircleAvatar(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: Text(
                        "${currentMovie.title} - (${currentMovie.year})",
                      ),
                      subtitle: Text(currentMovie.genre.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.favMoviesData.toggleFavorite(currentMovie);
                              // snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: currentMovie.isFav
                                      ? Colors.green
                                      : Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(10),
                                  content: Text(
                                    currentMovie.isFav
                                        ? 'Added to favorites'
                                        : 'Removed from favorites',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
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
                              widget.watchedMoviesData
                                  .toggleWatched(currentMovie);
                              // snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: currentMovie.isWatched
                                      ? Colors.green
                                      : Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(10),
                                  content: Text(
                                    currentMovie.isWatched
                                        ? 'Added to watched'
                                        : 'Removed from watched',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
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
                    ),
                  ),
                  // RatingBar(currentMovie: currentMovie),
                  if (!currentMovie.expand)
                    InkWell(
                      onTap: () {
                        widget.watchedMoviesData.toggleExpand(currentMovie);
                      },
                      child: const Icon(Icons.arrow_drop_down_rounded),
                    ),
                  if (currentMovie.expand)
                    Column(
                      children: [
                        RatingBar(currentMovie: currentMovie),
                        InkWell(
                          onTap: () {
                            widget.watchedMoviesData.toggleExpand(currentMovie);
                          },
                          child: const Icon(Icons.arrow_drop_up_rounded),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
