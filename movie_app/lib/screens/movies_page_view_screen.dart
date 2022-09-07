import 'package:flutter/material.dart';

class MoviePageViewScreen extends StatefulWidget {
  const MoviePageViewScreen(
      {super.key, required this.children, required this.initalIndex});
  final List<Widget> children;
  final int initalIndex;

  @override
  State<MoviePageViewScreen> createState() => _MoviePageViewScreenState();
}

class _MoviePageViewScreenState extends State<MoviePageViewScreen> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: widget.initalIndex);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: controller,
        itemCount: widget.children.length,
        itemBuilder: (context, index) {
          return Hero(
            
            tag: index,
            child: widget.children[index],
          );
        },
      ),
    );
  }
}
