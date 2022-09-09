import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_page.dart';

class AllMoviesProvider extends ChangeNotifier {
  final List<Movie> _allMovies = [
    Movie(
      title: "Avengers: Endgame",
      description: "Description",
      genre: "Fantasy",
      image:
          "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg?region=0%2C0%2C540%2C810",
      isFav: false,
      year: "2019",
      imdbRating: "8.4",
      isWatched: false,
    ),
    Movie(
      title: "Uncharted",
      description: "Description",
      genre: "Thriller",
      imdbRating: "7.5",
      image:
          "https://m.media-amazon.com/images/M/MV5BMWEwNjhkYzYtNjgzYy00YTY2LThjYWYtYzViMGJkZTI4Y2MyXkEyXkFqcGdeQXVyNTM0OTY1OQ@@._V1_FMjpg_UX1000_.jpg",
      isFav: false,
      year: "2021",
      isWatched: false,
    ),
    Movie(
      title: "Shawshank Redemption",
      description: "Description",
      genre: "Drama",
      imdbRating: "9.3",
      image: "https://m.media-amazon.com/images/I/71TO64qm+bL._AC_SL1099_.jpg",
      isFav: false,
      year: "1994",
      isWatched: false,
    ),
  ];

  // get by genre
  List<Movie> getMoviesByGenre(List<String> genre) {
    return _allMovies.where((movie) => genre.contains(movie.genre)).toList();
  }

  // List<String> allGenres = [];

  // avaialble genres
  List<InkWell> get availableGenres {
    // break genre on commas
    List<String> genres = _allMovies
        .map((movie) => movie.genre.split(",").map((e) => e.trim()).toList())
        .expand((element) => element)
        .toList();
    // genres = allGenres;
    // remove duplicates
    genres = genres.toSet().toList();
    // return list of inkwell widgets
    return genres
        .map(
          (genre) => InkWell(
            onTap: () {
              // log("tapped on $genre");
              // selected = !selected;
              // notifyListeners();
            },
            child: Chip(
              label: Text(genre),
              backgroundColor: Colors.black,
            ),
          ),
        )
        .toList();
  }

  List<Movie> get allMovies {
    return _allMovies;
  }

  List<MoviePage> get allMoviePagesList {
    return _allMovies.map(
      (movie) {
        return MoviePage(
          movie: movie,
        );
      },
    ).toList();
  }

  // toggle expand
  void toggleExpand(Movie movie) {
    movie.expand = !movie.expand;
    notifyListeners();
  }

  void addMovie(Movie movie) {
    _allMovies.add(movie);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _allMovies.remove(movie);
    notifyListeners();
  }
}
