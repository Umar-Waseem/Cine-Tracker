import 'package:flutter/material.dart';

class SinglePage extends StatefulWidget {
  final String title;
  final Color color;
  final String image;
  const SinglePage(
      {super.key,
      required this.title,
      required this.color,
      required this.image});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Colors.black54,
              child: ListTile(
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  "Movies Description",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      favorite = !favorite;
                    });
                  },
                  icon: Icon(
                    favorite ? Icons.favorite_outlined : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
