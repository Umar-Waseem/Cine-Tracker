import 'dart:convert';

class Movie {
  final String title;
  final String description;
  final String genre;
  final String image;
  final String year;
  String? released;
  String? runtime;
  String? director;
  String? writer;
  String? actors;
  String? language;
  String? country;
  String? awards;
  String? imdbRating;
  bool isWatched;
  bool isFav;
  bool expand;
  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.image,
    required this.year,
    this.released,
    this.runtime,
    this.director,
    this.writer,
    this.actors,
    this.language,
    this.country,
    this.awards,
    this.imdbRating,
    required this.isWatched,
    required this.isFav,
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
      released: map['Released'] != null ? map['Released'] as String : null,
      runtime: map['Runtime'] != null ? map['Runtime'] as String : null,
      director: map['director'] != null ? map['director'] as String : null,
      writer: map['Writer'] != null ? map['Writer'] as String : null,
      actors: map['Actors'] != null ? map['Actors'] as String : null,
      language: map['Language'] != null ? map['Language'] as String : null,
      country: map['Country'] != null ? map['Country'] as String : null,
      awards: map['Awards'] != null ? map['Awards'] as String : null,
      imdbRating:
          map['imdbRating'] != null ? map['imdbRating'] as String : null,
      isWatched: map['isWatched'] ?? false,
      isFav: map['isFav'] ?? false,
      expand: map['expand'] ?? false,
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
