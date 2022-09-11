import 'package:sqflite/sqflite.dart';

import '../models/movie.dart';

const String tableMovies = "movies";

class MovieDatabase {
  static final MovieDatabase instance = MovieDatabase._init();

  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    

    await db.execute('''CREATE TABLE $tableMovies (
      ${MovieField.id} $idType,
      ${MovieField.title} $textType,
      ${MovieField.description} $textType,
      ${MovieField.genre} $textType,
      ${MovieField.image} $textType,
      ${MovieField.year} $textType,
      ${MovieField.released} $textType,
      ${MovieField.runtime} $textType,
      ${MovieField.director} $textType,
      ${MovieField.writer} $textType,
      ${MovieField.actors} $textType,
      ${MovieField.language} $textType,
      ${MovieField.country} $textType,
      ${MovieField.awards} $textType,
      ${MovieField.imdbRating} $intType,
      ${MovieField.isWatched} $boolType,
      ${MovieField.isFav} $boolType,
      ${MovieField.expand} $boolType
    )''');
  }

  Future<Movie> create(Movie movie) async {
    final db = await instance.database;

    final id = await db.insert(tableMovies, movie.toJson());
    return movie.copyWith(id: id);
  }

  Future<Movie> readMovie(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMovies,
      columns: MovieField.values,
      where: '${MovieField.id} = ?',
      whereArgs: [id],
    ); 

    if (maps.isNotEmpty) {
      return Movie.fromTheJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Movie>> readAllMovies() async {
    final db = await instance.database;

    const orderBy = '${MovieField.title} ASC';

    final result = await db.query(tableMovies, orderBy: orderBy);

    return result.map((json) => Movie.fromTheJson(json)).toList();
  }

  Future<int> update(Movie movie) async {
    final db = await instance.database;

    return db.update(
      tableMovies,
      movie.toJson(),
      where: '${MovieField.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableMovies,
      where: '${MovieField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}
