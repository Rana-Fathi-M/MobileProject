import 'dart:io';

class User {
  User({
    required this.name,
    required this.bio,
    this.image, // <-- now nullable
  });

  String name;
  String bio;
  File? image; // <-- make it nullable
}
