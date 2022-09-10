import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/widgets/movie_page.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/all_movies_provider.dart';
import 'movies_page_view_screen.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  String apiKey = "25cef5e";

  bool loading = false;
  bool loading1 = false;

  Movie? movie;

  void sendApiRequestByTitle(String text) async {
    setState(() {
      loading = true;
    });
    String searchResult = text;
    final response = await http
        .get(
      Uri.parse("https://www.omdbapi.com/?t=$searchResult&apikey=$apiKey"),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      return value;
    });
    print(response.body);

    // make movie model from response
    movie = Movie.fromJson(response.body);
    print("movie ${movie.toString()}");
  }

  // void sendApiRequestById(String text) async {
  //   setState(() {
  //     loading1 = true;
  //   });
  //   String searchResult = text;
  //   final response = await http
  //       .get(
  //     Uri.parse("https://www.omdbapi.com/?i=$searchResult&apikey=$apiKey"),
  //   )
  //       .then((value) {
  //     setState(() {
  //       loading1 = false;
  //     });
  //     return value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "By Movie Title",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  sendApiRequestByTitle(titleController.text);
                },
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Search"),
              ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   height: 40,
              //   child: Text(
              //     "OR",
              //     style: Theme.of(context).textTheme.headline6,
              //   ),
              // ),
              // TextField(
              //   controller: idController,
              //   decoration: const InputDecoration(
              //     hintText: "By IMDB ID",
              //   ),
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     sendApiRequestById(idController.text);
              //   },
              //   child: loading1
              //       ? const CircularProgressIndicator()
              //       : const Text("Search"),
              // ),
              if (movie != null)
                Consumer<AllMoviesProvider>(
                  builder: (context, data, child) => ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MoviePageViewScreen(
                            initalIndex: 0,
                            children: [
                              MoviePage(
                                movie: movie!,
                                showIcon: false,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: Text(movie!.title),
                    subtitle: Text(movie!.year),
                    leading: Image.network(movie!.image),
                    trailing: IconButton(
                      onPressed: () {
                        data.addMovie(movie!);
                        // show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Movie Added",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.add),
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
