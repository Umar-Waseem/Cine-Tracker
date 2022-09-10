// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_page.dart';

// import '../widgets/movie_page.dart';

class FavoriteMovieProvider extends ChangeNotifier {
  final List<Movie> _favoriteMovies = [];

  List<MoviePage> get favoriteMoviePages {
    return _favoriteMovies
        .map(
          (movie) => MoviePage(
            movie: movie,
          ),
        )
        .toList();
  }

  List<Movie> get favoriteMovies {
    return _favoriteMovies;
  }

  // toggle expand
  void toggleExpand(Movie movie) {
    movie.expand = !movie.expand;
    notifyListeners();
  }



  // get by genre
  List<Movie> getMoviesByGenre(String genre) {
    return _favoriteMovies.where((movie) => movie.genre == genre).toList();
  }

  void addMovie(Movie movie) {
    _favoriteMovies.add(movie);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _favoriteMovies.remove(movie);
    notifyListeners();
  }

  void toggleFavorite(Movie movie) {
    if (_favoriteMovies.contains(movie)) {
      movie.isFav = false;
      removeMovie(movie);
    } else {
      movie.isFav = true;
      addMovie(movie);
    }
    notifyListeners();
  }

    // by title
  List<Movie> searchMoviesByTitle(String query) {
    return _favoriteMovies
        .where(
          (movie) => movie.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // by genre
  List<Movie> searchMoviesByGenre(String query) {
    try {
      return _favoriteMovies
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
      return _favoriteMovies.where(
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
      return _favoriteMovies
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
    return _favoriteMovies.where(
      (movie) {
        // log(value.toString());
        // log(movie.runtime);
        double time = double.parse(movie.runtime.split(" ")[0]);
        // if value is within 30 of time, return true
        return value - 30 <= time && value + 30 >= time;
      },
    ).toList();
  }

  // by cast
  List<Movie> searchMoviesByCast(String query) {
    try {
      return _favoriteMovies
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
