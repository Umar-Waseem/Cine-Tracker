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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rating: ${currentMovie.imdbRating}"),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: LinearProgressIndicator(
              minHeight: 4,
              value: double.parse(currentMovie.imdbRating ?? "0") / 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                double.parse(currentMovie.imdbRating ?? "0") > 6.0
                    ? Colors.green
                    : Colors.redAccent,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text("Duration: ${currentMovie.runtime} "),
        ],
      ),
    );
  }
}
