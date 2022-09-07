import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen(
      {super.key, required this.children, required this.initalIndex});
  final List<Widget> children;
  final int initalIndex;

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
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
