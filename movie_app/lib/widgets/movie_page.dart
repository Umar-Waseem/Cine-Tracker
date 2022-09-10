import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/favorite_movie_provider.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  final bool? showIcon;
  const MoviePage({super.key, required this.movie, this.showIcon});

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
                    image: NetworkImage(widget.movie.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: expand ? 900 : 200,
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
                    subtitle: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.movie.description,
                          style: const TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.movie.imdbRating,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.movie.runtime,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.movie.released,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.movie.language,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.movie.genre,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.recent_actors,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                widget.movie.actors,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.movie_filter,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Director: ${widget.movie.director}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.movie_creation,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                "Writers: ${widget.movie.writer}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.money,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                "Awards: ${widget.movie.awards}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: widget.showIcon ?? true
                        ? IconButton(
                            onPressed: () {
                              data.toggleFavorite(widget.movie);
                            },
                            icon: Icon(
                              widget.movie.isFav
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          )
                        : null,
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
