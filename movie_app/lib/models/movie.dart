import 'dart:convert';

class Movie {
  final String title;
  final String description;
  final String genre;
  final String image;
  final String year;
  final String released;
  final String runtime;
  final String director;
  final String writer;
  final String actors;
  final String language;
  final String country;
  final String awards;
  final String imdbRating;
  bool isWatched;
  bool isFav;
  bool expand;
  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.image,
    required this.year,
    required this.released,
    required this.runtime,
    required this.director,
    required this.writer,
    required this.actors,
    required this.language,
    required this.country,
    required this.awards,
    required this.imdbRating,
    this.isWatched = false,
    this.isFav = false,
    this.expand = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': title,
      'Plot': description,
      'Genre': genre,
      'Poster': image,
      'Year': year,
      'Released': released,
      'Runtime': runtime,
      'Director': director,
      'Writer': writer,
      'Actors': actors,
      'Language': language,
      'Country': country,
      'Awards': awards,
      'imdbRating': imdbRating,
      'isWatched': isWatched,
      'isFav': isFav,
      'expand': expand,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['Title'] as String,
      description: map['Plot'] as String,
      genre: map['Genre'] as String,
      image: map['Poster'] as String,
      year: map['Year'] as String,
      released: map['Released'] as String,
      runtime: map['Runtime'] as String,
      director: map['Director'] as String,
      writer: map['Writer'] as String,
      actors: map['Actors'] as String,
      language: map['Language'] as String,
      country: map['Country'] as String,
      awards: map['Awards'] as String,
      imdbRating: map['imdbRating'] as String,
      // isWatched: map['isWatched'] as bool,
      // isFav: map['isFav'] as bool,
      // expand: map['expand'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  // toString
  @override
  String toString() {
    return 'Movie(title: $title, description: $description, genre: $genre, image: $image, year: $year, released: $released, runtime: $runtime, director: $director, writer: $writer, actors: $actors, language: $language, country: $country, awards: $awards, imdbRating: $imdbRating, isWatched: $isWatched, isFav: $isFav)';
  }
}
