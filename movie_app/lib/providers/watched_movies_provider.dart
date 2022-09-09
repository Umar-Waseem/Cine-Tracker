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

  // toggle expand
  void toggleExpand(Movie movie) {
    movie.expand = !movie.expand;
    notifyListeners();
  }

  // get by genre
  List<Movie> getMoviesByGenre(String genre) {
    return _watchedMovies.where((movie) => movie.genre == genre).toList();
  }

  void addMovie(Movie movie) {
    _watchedMovies.add(movie);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _watchedMovies.remove(movie);
    notifyListeners();
  }

  void toggleWatched(Movie movie) {
    if (_watchedMovies.contains(movie)) {
      movie.isWatched = false;
      removeMovie(movie);
    } else {
      movie.isWatched = true;
      addMovie(movie);
    }
    notifyListeners();
  }
}