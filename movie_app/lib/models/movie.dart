class Movie {
  final String title;
  final String description;
  final String genre;
  final String image;
  final String year;
  bool isWatched;
  bool isFav;

  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.image,
    required this.isFav,
    required this.year,
    required this.isWatched,
  });
}
