import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_page.dart';

class AllMoviesProvider extends ChangeNotifier {
  final List<Movie> _allMovies = [
    Movie(
      title: "Avengers: Endgame",
      description: "Fantasy",
      genre: "Drama",
      image: "assets/images/avengers.jpg",
      isFav: false,
      year: "2019",
    ),
    Movie(
      title: "Uncharted",
      description: "Description",
      genre: "Thriller",
      image: "assets/images/uncharted.jpg",
      isFav: false,
      year: "2021",
    ),
    Movie(
      title: "Shawshank Redemption",
      description: "Description",
      genre: "Drama",
      image: "assets/images/shawshank.jpg",
      isFav: false,
      year: "1994",
    ),
  ];

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
}
