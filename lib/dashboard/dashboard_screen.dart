import 'package:flutter/material.dart';
import 'package:mobileproj/add_item/item.dart';
import 'package:mobileproj/add_item/item_model.dart';
import 'package:mobileproj/details/details_page/details_page.dart';
import 'package:mobileproj/add_item/add_item_screen.dart';
import 'package:mobileproj/profile/profile_page/profile_page.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImage = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          //bdl m a3rd rakm constant ra7 a5od el list el hygeli lma a3ml pick images w a3rdo b3dd el images el e5trthom w kolo bytn2l bl providers bdon constructors
          // itemCount: 6,
          itemCount: items.items.length,
          itemBuilder: (context, index) {
            return Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  items.selectItem(
                    Item(
                      images:  items.items[index].images,
                      title:  items.items[index].title,
                      body:  items.items[index].body,
                      favorite: items.items[index].favorite,
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()),
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child:
                          //  Image.asset(
                          //   "assets/tree.jpg",
                          //   fit: BoxFit.cover,
                          // ),
                          Image.file(items.items[index].images.first),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const Text("Tree"),
                            Text(items.items[index].title),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
