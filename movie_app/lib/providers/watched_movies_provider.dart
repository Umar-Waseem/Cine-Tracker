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

  // by title
  List<Movie> searchMoviesByTitle(String query) {
    return _watchedMovies
        .where(
          (movie) => movie.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // by genre
  List<Movie> searchMoviesByGenre(String query) {
    try {
      return _watchedMovies
          .where(
            (movie) => movie.genre.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  // by year
  List<Movie> searchMoviesByYear(String query) {
    // cast to double
    try {
      double value = double.parse(query);
      return _watchedMovies.where(
        (movie) {
          double year = double.parse(movie.year);

          return value == year;
        },
      ).toList();
    } catch (e) {
      return [];
    }
  }

  // by rating where query >= rating
  List<Movie> searchMoviesByRating(String query) {
    try {
      // cast to double
      double rating = double.parse(query);
      return _watchedMovies
          .where(
            (movie) => double.parse(movie.imdbRating).floorToDouble() <= rating,
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  // by runtime where query <= runtime
  List<Movie> searchMoviesByRuntime(String query) {
    double value = double.parse(query);
    return _watchedMovies.where(
      (movie) {
        double time = double.parse(movie.runtime.split(" ")[0]);
        // if value is within 30 of time, return true
        return value - 30 <= time && value + 30 >= time;
      },
    ).toList();
  }

  // by cast
  List<Movie> searchMoviesByCast(String query) {
    try {
      return _watchedMovies
          .where(
            (movie) => movie.actors.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      // snackbar
      return [];
    }
  }
}