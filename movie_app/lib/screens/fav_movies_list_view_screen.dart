import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/favorite_movie_provider.dart';
import '../providers/watched_movies_provider.dart';
import '../widgets/rating_bar.dart';
import 'movies_page_view_screen.dart';

class FavroiteMoviesListViewScreen extends StatefulWidget {
  const FavroiteMoviesListViewScreen({
    Key? key,
    // required this.allMoviesData,
    required this.favMoviesData,
    required this.watchedMoviesData,
  }) : super(key: key);

  // final AllMoviesProvider allMoviesData;
  final FavoriteMovieProvider favMoviesData;
  final WatchedMoviesProvider watchedMoviesData;

  @override
  State<FavroiteMoviesListViewScreen> createState() =>
      _FavroiteMoviesListViewScreenState();
}

class _FavroiteMoviesListViewScreenState
    extends State<FavroiteMoviesListViewScreen> {
  late List<Movie> filteredMovies;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    filteredMovies = widget.favMoviesData.favoriteMovies;
    super.initState();
  }

  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // clear filters and text fields
                          setState(() {
                            filteredMovies =
                                widget.favMoviesData.favoriteMovies;
                            value = null;
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(Icons.close, size: 18),
                      ),
                      DropdownButton(
                        iconEnabledColor: Colors.white,
                        elevation: 20,
                        value: value,
                        hint: const Text(
                          'Filter By',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        underline: Container(),
                        icon: const Icon(
                          Icons.filter_list,
                          size: 18,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        items: const [
                          DropdownMenuItem(
                            value: 'title',
                            child: Text('Title'),
                          ),
                          DropdownMenuItem(
                            value: 'By Year',
                            child: Text('Year'),
                          ),
                          DropdownMenuItem(
                            value: 'By Genre',
                            child: Text('Genre'),
                          ),
                          DropdownMenuItem(
                            value: 'By Duration',
                            child: Text('Duration'),
                          ),
                          DropdownMenuItem(
                            value: 'By Rating',
                            child: Text('Rating'),
                          ),
                          DropdownMenuItem(
                            value: 'By Cast',
                            child: Text('Cast'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onChanged: (value) {
                setState(
                  () {
                    switch (this.value) {
                      case "By Title":
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByTitle(value);
                        break;
                      case 'By Year':
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByYear(value);
                        break;
                      case 'By Genre':
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByGenre(value);
                        break;
                      case 'By Duration':
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByRuntime(value);
                        break;
                      case 'By Rating':
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByRating(value);
                        break;
                      case 'By Cast':
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByCast(value);
                        break;
                      default:
                        filteredMovies =
                            widget.favMoviesData.searchMoviesByTitle(value);
                    }
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
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
                        widget.favMoviesData.removeMovie(filteredMovies[index]);
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
                                      widget.favMoviesData.favoriteMoviePages,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: Hero(
                              tag: index,
                              child: CachedNetworkImage(
                                imageUrl: filteredMovies[index].image,
                                placeholder: (context, url) =>
                                    const CircleAvatar(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Text(
                              "${filteredMovies[index].title} - (${filteredMovies[index].year})",
                            ),
                            subtitle: Text(
                              filteredMovies[index].genre.toString(),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    widget.favMoviesData
                                        .toggleFavorite(filteredMovies[index]);
                                    // snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            filteredMovies[index].isFav
                                                ? Colors.green
                                                : Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(10),
                                        content: Text(
                                          filteredMovies[index].isFav
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
                                    filteredMovies[index].isFav
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    widget.watchedMoviesData
                                        .toggleWatched(filteredMovies[index]);
                                    // snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            filteredMovies[index].isWatched
                                                ? Colors.green
                                                : Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(10),
                                        content: Text(
                                          filteredMovies[index].isWatched
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
                                    filteredMovies[index].isWatched
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
                        if (!filteredMovies[index].expand)
                          InkWell(
                            onTap: () {
                              widget.favMoviesData
                                  .toggleExpand(filteredMovies[index]);
                            },
                            child: const Icon(Icons.arrow_drop_down_rounded),
                          ),
                        if (filteredMovies[index].expand)
                          Column(
                            children: [
                              RatingBar(currentMovie: filteredMovies[index]),
                              InkWell(
                                onTap: () {
                                  widget.favMoviesData
                                      .toggleExpand(filteredMovies[index]);
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
          ),
        ],
      ),
    );
  }
}
