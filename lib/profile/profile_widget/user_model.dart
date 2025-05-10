import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproj/profile/profile_widget/user.dart';

class UserModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;

  User? _user;

  User? get user => _user;

  Future<void> selectImage(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      if (_user != null) {
        _user?.image = File(image.path);
      } else {
        _user = User(
          name: "Rana",
          bio: "Codingg ALL the time...",
          image: File(image!.path),
        );
      }

      notifyListeners();
    }
  }

  void deleteImage() {
    _user?.image = null;
    notifyListeners();
  }
}
