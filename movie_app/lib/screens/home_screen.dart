import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[100],
        appBar: AppBar(),
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
                    const Icon(Icons.arrow_left),
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
                    const Icon(Icons.arrow_right),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Swipe down to see more movies",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Icon(Icons.arrow_drop_down),
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
