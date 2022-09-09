import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_page.dart';

class AllMoviesProvider extends ChangeNotifier {
  final List<Movie> _allMovies = [
    Movie(
      title: "Avengers: Endgame",
      description:
          "After half of all life is snapped away by Thanos, the Avengers are left scattered and divided. Now with a way to reverse the damage, the Avengers and their allies must assemble once more and learn to put differences aside in order to work together and set things right.",
      genre: "Fantasy",
      image:
          "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg?region=0%2C0%2C540%2C810",
      isFav: false,
      year: "2019",
      imdbRating: "8.4",
      isWatched: false,
      runtime: "181 min",
      director: "Anthony Russo, Joe Russo",
      actors: "Robert Downey Jr., Chris Evans, Mark Ruffalo",
      expand: false,
      language: "English",
      country: "USA",
      awards: "Nominated for 1 Oscar. Another 38 wins & 79 nominations.",
      released: "26 Apr 2019",
      writer: "Christopher Markus, Stephen McFeely",
    ),
    // Movie(
    //   title: "Uncharted",
    //   description:
    //       "Street-smart Nathan Drake (Tom Holland) is recruited by seasoned treasure hunter Victor 'Sully' Sullivan (Mark Wahlberg) to recover a fortune amassed by Ferdinand Magellan and lost 500 years ago by the House of Moncada.",
    //   genre: "Thriller",
    //   imdbRating: "7.5",
    //   image:
    //       "https://m.media-amazon.com/images/M/MV5BMWEwNjhkYzYtNjgzYy00YTY2LThjYWYtYzViMGJkZTI4Y2MyXkEyXkFqcGdeQXVyNTM0OTY1OQ@@._V1_FMjpg_UX1000_.jpg",
    //   isFav: false,
    //   year: "2021",
    //   isWatched: false,
    //   runtime: "116 min",
    //   director: "Anthony Russo, Joe Russo",
    //   actors: "Robert Downey Jr., Chris Evans, Mark Ruffalo",
    //   expand: false,
    //   language: "English",
    //   country: "USA",
    //   awards: "Nominated for 1 Oscar. Another 38 wins & 79 nominations.",
    //   released: "26 Apr 2019",
    //   writer: "Christopher Markus, Stephen McFeely",
    // ),
    // Movie(
    //   title: "Shawshank Redemption",
    //   description:
    //       "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency. Chronicles the experiences of a formerly successful banker as a prisoner in the gloomy jailhouse of Shawshank after being found guilty of a crime he did not commit.",
    //   genre: "Drama",
    //   imdbRating: "9.3",
    //   image: "https://m.media-amazon.com/images/I/71TO64qm+bL._AC_SL1099_.jpg",
    //   isFav: false,
    //   year: "1994",
    //   isWatched: false,
    //   runtime: "142 min",
    //   director: "Anthony Russo, Joe Russo",
    //   actors: "Robert Downey Jr., Chris Evans, Mark Ruffalo",
    //   expand: false,
    //   language: "English",
    //   country: "USA",
    //   awards: "Nominated for 1 Oscar. Another 38 wins & 79 nominations.",
    //   released: "26 Apr 2019",
    //   writer: "Christopher Markus, Stephen McFeely",
    // ),
  ];

  // get by genre
  // List<Movie> getMoviesByGenre(List<String> genre) {
  //   return _allMovies.where((movie) => genre.contains(movie.genre)).toList();
  // }

  // avaialble genres
  List<String> get availableGenres {
    // breaks genre on commas
    List<String> genres = _allMovies
        .map((movie) => movie.genre.split(",").map((e) => e.trim()).toList())
        .expand((element) => element)
        .toList();
    // removes duplicates
    genres = genres.toSet().toList();
    // returns list of inkwell widgets
    return genres;
  }

  // get all movies
  List<Movie> get movies => _allMovies;

  List<MoviePage> get allMoviePagesList {
    return _allMovies.map(
      (movie) {
        return MoviePage(
          movie: movie,
        );
      },
    ).toList();
  }

  List<Card> get movieCards {
    return _allMovies
        .map(
          (movie) => Card(
            child: ListTile(
              leading: Image.network(movie.image),
              title: Text(movie.title),
              subtitle: Text(movie.year),
            ),
          ),
        )
        .toList();
  }

  // search movies with different criteria
  // List<Movie> searchMovies(String query) {
  //   return _allMovies
  //       .where(
  //         (movie) => movie.title.toLowerCase().contains(query.toLowerCase()),
  //       )
  //       .toList();

  // }

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

  // by title
  List<Movie> searchMoviesByTitle(String query) {
    return _allMovies
        .where(
          (movie) => movie.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // by genre
  List<Movie> searchMoviesByGenre(String query) {
    try {
      return _allMovies
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
      return _allMovies.where(
        (movie) {
          double year = double.parse(movie.year);

          return value == year;
        },
      ).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // by rating where query >= rating
  List<Movie> searchMoviesByRating(String query) {
    try {
      // cast to double
      double rating = double.parse(query);
      return _allMovies
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
    return _allMovies.where(
      (movie) {
        log(value.toString());
        log(movie.runtime);
        double time = double.parse(movie.runtime.split(" ")[0]);
        // if value is within 30 of time, return true
        return value - 30 <= time && value + 30 >= time;
      },
    ).toList();
  }

  // by cast
  List<Movie> searchMoviesByCast(String query) {
    try {
      return _allMovies
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
