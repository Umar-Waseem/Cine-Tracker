import 'package:flutter/material.dart';
import 'package:movie_app/providers/all_movies_provider.dart';
import 'package:movie_app/providers/favorite_movie_provider.dart';
import 'package:movie_app/screens/main_page.dart';
import 'package:provider/provider.dart';

import 'providers/watched_movies_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllMoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WatchedMoviesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        darkTheme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: Colors.white,
            ),
          ),
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Colors.black, brightness: Brightness.dark),
        ),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.yellow),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: Colors.white,
            ),
          ),
        ),
        home: const MainPage(),
      ),
    );
  }
}



