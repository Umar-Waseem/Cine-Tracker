// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MovieField {
  static const List<String> values = [
    /// Add all fields
    id, title, description, genre, image, year, released, runtime, director,
    writer, actors, language, country, awards, imdbRating, isWatched, isFav,
    expand
  ];

  static const String id = '_id';
  static const String title = '_title';
  static const String description = '_description';
  static const String genre = '_genre';
  static const String image = '_image';
  static const String year = '_year';
  static const String released = '_released';
  static const String runtime = '_runtime';
  static const String director = '_director';
  static const String writer = '_writer';
  static const String actors = '_actors';
  static const String language = '_language';
  static const String country = '_country';
  static const String awards = '_awards';
  static const String imdbRating = '_imdbRating';
  static const String isWatched = "_isWatched";
  static const String isFav = "_isFav";
  static const String expand = "_expand";
}

class Movie {
  final int? id;
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
    this.id,
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
      'id': id,
      'title': title,
      'description': description,
      'genre': genre,
      'image': image,
      'year': year,
      'released': released,
      'runtime': runtime,
      'director': director,
      'writer': writer,
      'actors': actors,
      'language': language,
      'country': country,
      'awards': awards,
      'imdbRating': imdbRating,
      'isWatched': isWatched,
      'isFav': isFav,
      'expand': expand,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      genre: map['genre'] as String,
      image: map['image'] as String,
      year: map['year'] as String,
      released: map['released'] as String,
      runtime: map['runtime'] as String,
      director: map['director'] as String,
      writer: map['writer'] as String,
      actors: map['actors'] as String,
      language: map['language'] as String,
      country: map['country'] as String,
      awards: map['awards'] as String,
      imdbRating: map['imdbRating'] as String,
      isWatched: map['isWatched'] as bool,
      isFav: map['isFav'] as bool,
      expand: map['expand'] as bool,
    );
  }

  // from json
  factory Movie.fromTheJson(Map<String, dynamic> json) {
    return Movie(
      id: json[MovieField.id] as int?,
      title: json[MovieField.title] as String,
      description: json[MovieField.description] as String,
      genre: json[MovieField.genre] as String,
      image: json[MovieField.image] as String,
      year: json[MovieField.year] as String,
      released: json[MovieField.released] as String,
      runtime: json[MovieField.runtime] as String,
      director: json[MovieField.director] as String,
      writer: json[MovieField.writer] as String,
      actors: json[MovieField.actors] as String,
      language: json[MovieField.language] as String,
      country: json[MovieField.country] as String,
      awards: json[MovieField.awards] as String,
      imdbRating: json[MovieField.imdbRating] as String,
      isWatched: json[MovieField.isWatched]== 1,
      isFav: json[MovieField.isFav] ==1,
      expand: json[MovieField.expand] == 1 ,
    );
  }

  Map<String, Object?> toJson() {
    {
      return {
        MovieField.id: id,
        MovieField.title: title,
        MovieField.description: description,
        MovieField.genre: genre,
        MovieField.image: image,
        MovieField.year: year,
        MovieField.released: released,
        MovieField.runtime: runtime,
        MovieField.director: director,
        MovieField.writer: writer,
        MovieField.actors: actors,
        MovieField.language: language,
        MovieField.country: country,
        MovieField.awards: awards,
        MovieField.imdbRating: imdbRating,
        MovieField.isWatched: isWatched ? 1 : 0,
        MovieField.isFav: isFav ? 1 : 0,
        MovieField.expand: expand ? 1 : 0,
      };
    }
  }


  // toString
  @override
  String toString() {
    return 'Movie(title: $title, description: $description, genre: $genre, image: $image, year: $year, released: $released, runtime: $runtime, director: $director, writer: $writer, actors: $actors, language: $language, country: $country, awards: $awards, imdbRating: $imdbRating, isWatched: $isWatched, isFav: $isFav)';
  }

  // copyWith
  Movie copyWith({
    int? id,
    String? title,
    String? description,
    String? genre,
    String? image,
    String? year,
    String? released,
    String? runtime,
    String? director,
    String? writer,
    String? actors,
    String? language,
    String? country,
    String? awards,
    String? imdbRating,
    bool? isWatched,
    bool? isFav,
    bool? expand,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      genre: genre ?? this.genre,
      image: image ?? this.image,
      year: year ?? this.year,
      released: released ?? this.released,
      runtime: runtime ?? this.runtime,
      director: director ?? this.director,
      writer: writer ?? this.writer,
      actors: actors ?? this.actors,
      language: language ?? this.language,
      country: country ?? this.country,
      awards: awards ?? this.awards,
      imdbRating: imdbRating ?? this.imdbRating,
      isWatched: isWatched ?? this.isWatched,
      isFav: isFav ?? this.isFav,
      expand: expand ?? this.expand,
    );
  }

// for add screen
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
