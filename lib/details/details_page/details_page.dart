import 'dart:io';
import 'package:mobileproj/add_item/item_model.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mobileproj/add_item/add_item_screen.dart';
import 'package:mobileproj/profile/profile_page/profile_page.dart';
import "../details_widget/details_widget.dart";

class DetailsPage extends StatelessWidget {
  // final String? title;
  // final String? body;
  // final List<File>? image;
  // const DetailsPage({
  //   this.title, this.body, this.image, super.key
  //   });

  @override
  Widget build(BuildContext context) {
    //34an a3ml access l7aget el usermodel w a2dr a3rf lw fe sora etb3tt f a5odha hna
    final profileImage = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text("The ${title ?? "Tree"}"),
        title:  Text("The ${items.selectedItem!.title}"),
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
            // image == null || image!.isEmpty
            //     ? Image.asset('assets/tree.jpg')
            //     : Image.file(
            //       image![0],
            //       height: 300,
            //       width: double.infinity,
            //       fit: BoxFit.cover,
            //     ),
            Image.file(items.selectedItem!.images.first , height: 300, width: double.infinity, fit: BoxFit.cover),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FavoriteWidget(index: items.items.indexOf(items.selectedItem!),),
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                // body ??
                //     "Beneath the ground, a tree has a root system that acts as an anchor and stores the water and nutrients the plant needs to grow.",
                items.selectedItem!.body,
                textAlign: TextAlign.justify,
              ),
            ),
            // image == null || image!.isEmpty
            //     ? Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         MySeason(url: 'assets/fall-tree.jpg', text: "Fall"),
            //         MySeason(url: 'assets/spring.jpg', text: "Spring"),
            //       ],
            //     )
            //     :
                 SizedBox(
                  height: 500,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    // itemCount: image!.length,
                    itemCount: items.selectedItem!.images.length,
                    itemBuilder:
                        (context, index) => Image.file(
                          // image![index],
                          items.selectedItem!.images[index],
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
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
