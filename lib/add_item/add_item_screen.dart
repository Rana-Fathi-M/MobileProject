import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproj/add_item/item.dart';
import 'package:mobileproj/add_item/item_model.dart';
import 'package:mobileproj/dashboard/dashboard_screen.dart';
import 'package:mobileproj/details/details_page/details_page.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double boxSize = 100;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.jpg"),
          ),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(10),
        child: Consumer<ItemModel>(
          builder:
              (context, itemModel, child) => ListView(
                children: [
                  const SizedBox(height: 150),
                  SizedBox(
                    height: boxSize,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Image picker box
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              itemModel.selectImage();
                            },
                            child: Container(
                              width: boxSize,
                              height: boxSize,
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: const Icon(Icons.camera_alt, size: 30),
                            ),
                          ),
                        ),
                        // Selected images
                        ...itemModel.selectedImages.map(
                          (image) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    image,
                                    width: boxSize,
                                    height: boxSize,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      itemModel.removeImage(
                                        itemModel.selectedImages.indexOf(image),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: title,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Title",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: body,
                      minLines: 3,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Body",
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          // final itemModel = Provider.of<ItemModel>(context, listen: false);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder:
          //         (context) => DetailsPage(
          //           title: title.text,
          //           body: body.text,
          //           image: itemModel.selectedImages,
          //         ),
          //   ),
          // );

          //lma bl4 dos 3la zr l save bdna ndef el images el e5trnaha gowa el list el 3rfnaha f el item.dart

          //hl2 had bara el consumer f m r7 ysm3 f bnswy >
          final item = Provider.of<ItemModel>(context, listen: false);
          item.addItem(
            Item(
              images: List.from(item.selectedImages),
              title: title.text,
              body: body.text,
              favorite: false,
            ),
          );

          item.selectedImages.clear();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        },
      ),
    );
  }
}
