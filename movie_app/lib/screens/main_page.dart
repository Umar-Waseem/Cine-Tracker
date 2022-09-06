import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/widgets/single_page.dart';

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
      children: const [
        HomeScreen(),
        SinglePage(
          title: "Movie 1",
          color: Colors.red,
          image: "assets/images/avengers.jpg",
        ),
        SinglePage(
          title: "Movie 2",
          color: Colors.red,
          image: "assets/images/uncharted.jpg",
        ),
        SinglePage(
          title: "Movie 3",
          color: Colors.red,
          image: "assets/images/avengers.jpg",
        ),
      ],
    );
  }
}
