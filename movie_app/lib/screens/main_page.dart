import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/widgets/movie_page.dart';

import '../providers/favorite_movie_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 0);
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: controller,
      children: [
        const HomeScreen(),
        MoviePage(
          movie: Movie(
            title: "Avengers: Endgame",
            description: "Fantasy",
            genre: "Drama",
            image: "assets/images/avengers.jpg",
            isFav: false,
            year: "2019",
          ),
        ),
        MoviePage(
          movie: Movie(
            title: "Uncharted",
            description: "Description",
            genre: "Thriller",
            image: "assets/images/uncharted.jpg",
            isFav: false,
            year: "2021",
          ),
        ),
        MoviePage(
          movie: Movie(
            title: "Shawshank Redemption",
            description: "Description",
            genre: "Drama",
            image: "assets/images/shawshank.jpg",
            isFav: false,
            year: "1994",
          ),
        )
      ],
    );
  }
}
