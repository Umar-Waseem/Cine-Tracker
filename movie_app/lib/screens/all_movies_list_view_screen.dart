import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/all_movies_provider.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
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
  bool selected = false;
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
          )
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          indent: 15,
          endIndent: 15,
          color: Colors.grey,
          thickness: 1,
        ),
        itemCount: widget.allMoviesData.allMoviePagesList.length,
        itemBuilder: (context, index) {
          Movie currentMovie = widget.allMoviesData.allMovies[index];
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
                widget.allMoviesData.removeMovie(currentMovie);
              }
            },
            key: UniqueKey(),
            child: ListTile(
              leading: Hero(
                tag: index,
                child: CachedNetworkImage(
                  imageUrl: currentMovie.image,
                  placeholder: (context, url) => const CircleAvatar(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      widget.favMoviesData.toggleFavorite(currentMovie);
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
                      widget.watchedMoviesData.toggleWatched(currentMovie);
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
                      children: widget.allMoviesData.allMoviePagesList,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: 70,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: Chip(
                elevation: selected ? 0 : 10,
                label: const Text(
                  "Drama",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: selected ? Colors.red : Colors.black,
              ),
            ),
            const Chip(
              elevation: 10,
              label: Text(
                "Thriller",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            const Chip(
              elevation: 0,
              label: Text(
                "Action",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            const Chip(
              elevation: 10,
              label: Text(
                "Comedy",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            const Chip(
              elevation: 10,
              label: Text(
                "Horror",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
