import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_page.dart';

class AllMoviesProvider extends ChangeNotifier {
  final List<Movie> _allMovies = [
    Movie(
      title: "Avengers: Endgame",
      description: "Description",
      genre: "Fantasy",
      image: "assets/images/avengers.jpg",
      isFav: false,
      year: "2019",
      isWatched: false,
    ),
    Movie(
      title: "Uncharted",
      description: "Description",
      genre: "Thriller",
      image: "assets/images/uncharted.jpg",
      isFav: false,
      year: "2021",
      isWatched: false,
    ),
    Movie(
      title: "Shawshank Redemption",
      description: "Description",
      genre: "Drama",
      image: "assets/images/shawshank.jpg",
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
