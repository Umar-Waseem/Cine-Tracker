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
      isWatched: false,
    ),
    Movie(
      title: "Uncharted",
      description: "Description",
      genre: "Thriller",
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
      image: "https://m.media-amazon.com/images/I/71TO64qm+bL._AC_SL1099_.jpg",
      isFav: false,
      year: "1994",
      isWatched: false,
    ),
  ];

  // get by genre
  List<Movie> getMoviesByGenre(String genre) {
    return _allMovies.where((movie) => movie.genre == genre).toList();
  }

  List<Movie> get allMovies {
    return _allMovies;
  }

  List<MoviePage> get allMoviePagesList {
    return _allMovies
        .map(
          (movie) => MoviePage(
            movie: movie,
          ),
        )
        .toList();
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
