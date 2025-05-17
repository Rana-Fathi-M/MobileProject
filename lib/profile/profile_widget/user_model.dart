import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproj/profile/profile_widget/user.dart';

class User {
  String name;
  String email;
  String? bio;
  File? image;

  User({required this.name, required this.email, this.bio, this.image});
}

class UserModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  User? _user;

  User? get user => _user;

  UserModel() {
    // Initialize with default user if you want
    _user = User(name: "Rana Fathi", email: "rana@gmail.com");
  }

  Future<void> selectImage(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      _user?.image = File(image.path);
      notifyListeners();
    }
  }

  void deleteImage() {
    _user?.image = null;
    notifyListeners();
  }

  void updateUserInfo({String? name, String? email}) {
    if (_user != null) {
      if (name != null) _user!.name = name;
      if (email != null) _user!.email = email;
      notifyListeners();
    }
  }
}
