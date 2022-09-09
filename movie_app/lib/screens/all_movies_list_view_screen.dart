import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/all_movies_provider.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
import '../widgets/rating_bar.dart';
import 'add_movie_screen.dart';
import 'movies_page_view_screen.dart';

class AllMoviesListViewScreen extends StatefulWidget {
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
  State<AllMoviesListViewScreen> createState() =>
      _AllMoviesListViewScreenState();
}

class _AllMoviesListViewScreenState extends State<AllMoviesListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies To Watch'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddMovieScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list_alt),
                ),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.allMoviesData.movies.length,
              itemBuilder: (context, index) {
                Movie currentMovie = widget.allMoviesData.movies[index];

                return Card(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
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
                        widget.allMoviesData.removeMovie(currentMovie);
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
                                      widget.allMoviesData.allMoviePagesList,
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
                                placeholder: (context, url) =>
                                    const CircleAvatar(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Text(
                              "${currentMovie.title} - (${currentMovie.year})",
                            ),
                            subtitle: Text(
                              currentMovie.genre.toString(),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    widget.favMoviesData
                                        .toggleFavorite(currentMovie);
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
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                          style: const TextStyle(
                                              color: Colors.white),
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
                        !currentMovie.expand
                            ? InkWell(
                                onTap: () {
                                  widget.allMoviesData
                                      .toggleExpand(currentMovie);
                                },
                                child:
                                    const Icon(Icons.arrow_drop_down_rounded),
                              )
                            : Column(
                                children: [
                                  RatingBar(currentMovie: currentMovie),
                                  InkWell(
                                    onTap: () {
                                      widget.allMoviesData
                                          .toggleExpand(currentMovie);
                                    },
                                    child:
                                        const Icon(Icons.arrow_drop_up_rounded),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // bottomSheet: Container(
      // height: 70,
      //   width: double.infinity,
      //   color: Colors.grey,
      //   child: Wrap(
      //     alignment: WrapAlignment.center,
      //     spacing: 5,
      //     children: [
      //       ...widget.allMoviesData.availableGenres,
      //     ],
      //   ),
      // ),
    );
  }
}
