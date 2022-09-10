import 'package:flutter/material.dart';

import '../models/movie.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.currentMovie,
  }) : super(key: key);

  final Movie currentMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Wrap(
        spacing: 10,
        children: [
          Chip(
            avatar: const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            label: Text("Rating: ${currentMovie.imdbRating}"),
            backgroundColor: Colors.black,
          ),
          Chip(
            avatar: const Icon(
              Icons.timelapse_sharp,
              color: Colors.white,
            ),
            label: Text("Duration: ${currentMovie.runtime} "),
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
