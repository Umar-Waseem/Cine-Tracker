import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  String apiKey = "25cef5e";

  void sendApiRequest() async {
    String searchResult = searchController.text;

    final response = await http.get(
        Uri.parse("https://www.omdbapi.com/?t=$searchResult&apikey=$apiKey"));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Search Movie",
              hintStyle: TextStyle(color: Colors.white),
            ),
            controller: searchController,
          ),
          actions: [
            IconButton(
              onPressed: () {
                sendApiRequest();
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "What movie are you going to chose?",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_left, color: Colors.white),
                    Text(
                      "Swipe left to list already watched movies",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Swipe right to list favorite movies",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Icon(Icons.arrow_right, color: Colors.white),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Swipe down to see movies you added",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
