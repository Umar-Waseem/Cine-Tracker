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
}
