import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproj/add_item/item.dart';

class ItemModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  final ImagePicker imagePicker = ImagePicker();
  List<File> selectedImages = [];

  Future<void> selectImage() async {
    final List<XFile> images = await imagePicker.pickMultiImage();

    if (images.isNotEmpty) {
      selectedImages.addAll(images.map((xfile) => File(xfile.path)).toList());
      notifyListeners();
    }
  }

  void removeImage(index) {
    selectedImages.removeAt(index);
    notifyListeners(); // update UI
  }

  Item? _selectedItem;
  Item ? get selectedItem => _selectedItem;

 void selectItem(Item item) {
    _selectedItem = item;
    notifyListeners();
  }
}
