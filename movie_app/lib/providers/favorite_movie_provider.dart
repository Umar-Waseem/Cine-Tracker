// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../widgets/movie_page.dart';

class Movie {
  final String title;
  final String description;
  final String genre;
  final String image;
  final String year;
  bool isFav;

  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.image,
    required this.isFav,
    required this.year, 
  });
}

class FavoriteMovieProvider extends ChangeNotifier {
  List<Movie> _favoriteMovies = [];

  List<Movie> get favoriteMovies => _favoriteMovies;

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
