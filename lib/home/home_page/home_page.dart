import 'package:flutter/material.dart';
import "../home_widget/home_widget.dart";

class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;
  const MyHomePage({this.title, this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("The ${title ?? "Tree"}")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/tree.jpg'),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FavoriteWidget(),
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                body ??
                    "neath the ground, a tree has a root system that acts as an anchor and stores the water and nutrients the plant needs to grow.",
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MySeason(url: 'assets/fall-tree.jpg', text: "Fall"),
                MySeason(url: 'assets/spring.jpg', text: "Spring"),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.next_plan),
      ),
    );
  }
}
