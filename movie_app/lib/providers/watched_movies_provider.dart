import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_page.dart';

class WatchedMoviesProvider with ChangeNotifier {
  final List<Movie> _watchedMovies = [];

  List<Movie> get watchedMovies => _watchedMovies;

  List<MoviePage> get watchedMoviePages {
    return _watchedMovies
        .map(
          (movie) => MoviePage(
            movie: movie,
          ),
        )
        .toList();
  }

  void addMovie(Movie movie) {
    _watchedMovies.add(movie);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _watchedMovies.remove(movie);
    notifyListeners();
  }
}