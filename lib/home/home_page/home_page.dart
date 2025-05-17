import 'dart:io';
import 'package:mobileproj/add_item/item_model.dart';
import 'package:mobileproj/home/home_widget/home_widget.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mobileproj/add_item/add_item_screen.dart';
import 'package:mobileproj/profile/profile_page/profile_page.dart';
import 'package:mobileproj/dashboard/dashboard_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileImage = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    final selectedItem = items.selectedItem;

    // Sample data for the grid items
    final List<Map<String, String>> gridItems = [
      {'text': 'Rana', 'url': 'assets/profile1.jpg', 'subtitle': 'rana: 4 CEO'},
      {
        'text': 'fall tree',
        'url': 'assets/fall-tree.jpg',
        'subtitle': 'tree tree tree',
      },
      {
        'text': 'spring ',
        'url': 'assets/spring.jpg',
        'subtitle': 'spring spring',
      },
      {
        'text': 'Profile',
        'url': 'assets/profile1.jpg',
        'subtitle': 'Professional',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            selectedItem != null
                ? Text("The ${selectedItem.title}")
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.dashboard),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 8),
                    Text("Rana Fathi"),
                  ],
                ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon:
                profileImage == null
                    ? Icon(Icons.account_box)
                    : CircleAvatar(
                      child: ClipOval(
                        child: Image.file(
                          profileImage,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We're built for software teams",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Our mission is to ensure teams can do their best work, no matter\n\ntheir size or budget. We focus on the details of everything we do",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7, // Adjusted for better proportions
                ),
                itemCount: gridItems.length,
                itemBuilder:
                    (context, index) => MyPhoto(
                      text: gridItems[index]['text']!,
                      url: gridItems[index]['url']!,
                      subtitle: gridItems[index]['subtitle']!,
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: Icon(Icons.next_plan),
      ),
    );
  }
}
