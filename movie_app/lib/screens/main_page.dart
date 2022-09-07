import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/all_movies_provider.dart';
import '../providers/favorite_movie_provider.dart';
import 'page_view_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final allMoviesData = Provider.of<AllMoviesProvider>(context);
    final favMoviesData = Provider.of<FavoriteMovieProvider>(context);
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        itemCount: allMoviesData.allMoviePagesList.length,
        itemBuilder: (context, index) {
          Movie currentMovie = allMoviesData.allMovies[index];
          return ListTile(
            leading: Hero(
              tag: index,
              child: Image.asset(
                currentMovie.image,
                height: 100,
                width: 100,
              ),
            ),
            title: Text(currentMovie.title),
            subtitle: Text(currentMovie.description),
            trailing: IconButton(
              onPressed: () {
                favMoviesData.toggleFavorite(currentMovie);
              },
              icon: Icon(
                currentMovie.isFav
                    ? Icons.favorite_outlined
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PageViewScreen(
                    initalIndex: index,
                    children: allMoviesData.allMoviePagesList,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
