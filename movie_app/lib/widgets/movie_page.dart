import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/favorite_movie_provider.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  const MoviePage({
    super.key,
    required this.movie,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // go to favorite movies page,
        appBar: AppBar(),
        body: Consumer<FavoriteMovieProvider>(
          builder: (context, data, child) => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.movie.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: expand ? 500 : 100,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        expand = !expand;
                      });
                    },
                    title: Text(
                      "${widget.movie.title} - ${widget.movie.year}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      widget.movie.description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        data.toggleFavorite(widget.movie);
                      },
                      icon: Icon(
                        widget.movie.isFav
                            ? Icons.favorite_outlined
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
