import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileproj/firstScreen.dart';
import 'package:mobileproj/profile/profile_page/profile_page.dart';
import "../home_widget/home_widget.dart";

class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;
  final List <File> ? image;
  const MyHomePage({this.title, this.body, this.image , super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("The ${title ?? "Tree"}"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.account_box),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            image == null || image!.isEmpty ?
            Image.asset('assets/tree.jpg') : Image.file(image![0] , height: 300 , width: double.infinity, fit: BoxFit.cover , ),

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
                    "Beneath the ground, a tree has a root system that acts as an anchor and stores the water and nutrients the plant needs to grow.",
                textAlign: TextAlign.justify,
              ),
            ),
            image == null || image!.isEmpty ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MySeason(url: 'assets/fall-tree.jpg', text: "Fall"),
                MySeason(url: 'assets/spring.jpg', text: "Spring"),
              ],
            ):
            SizedBox(
              height: 500,
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , mainAxisSpacing: 10 , crossAxisSpacing: 10 , ),
               itemCount: image!.length , 
              itemBuilder: (context , index) => Image.file(image![index], height: 150 , width: 150 , fit: BoxFit.cover,),),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstScreen()),
          );
        },
        child: Icon(Icons.next_plan),
      ),
    );
  }
}
