import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproj/profile/profile_widget/options.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final ImagePicker imagePicker = ImagePicker();
  // File? selectedImage;

  // Future<void> selectImage(ImageSource source) async {
  //   XFile? image = await imagePicker.pickImage(source: source);
  //   if (image != null && mounted) {
  //     setState(() {
  //       selectedImage = File(image.path);
  //     });
  //   }
  // }

  // void deleteImage() {
  //   setState(() {
  //     selectedImage = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              // consumer y3ml rebuild lma y7sl 3ndi t8yerat
              //l sora h5odha mn el gallery w htt7t f profile el fkra eni h2dr a3rdha f el home bdon est3mal el constructor
              child: Consumer <UserModel>(
                builder: (context, userModel , child) { 
                  return 
                  Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 100,
                      child:
                          userModel.user?.image == null
                              ? const Icon(Icons.person, size: 100)
                              : ClipOval(
                                child: Image.file(
                                  userModel.user!.image!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 25,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.camera_alt, size: 25),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 180,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Choose Profile Photo',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ProfileOptionButton(
                                            icon: Icons.camera_alt,
                                            label: 'Camera',
                                            onPressed: () {
                                              Navigator.pop(context);
                                             userModel.selectImage(ImageSource.camera);
                                            },
                                          ),
                                          ProfileOptionButton(
                                            icon: Icons.photo,
                                            label: 'Gallery',
                                            onPressed: () {
                                              Navigator.pop(context);
                                              userModel.selectImage(ImageSource.gallery);
                                            },
                                          ),
                                          if (userModel.user?.image != null)
                                            ProfileOptionButton(
                                              icon: Icons.delete,
                                              label: 'Delete',
                                              iconColor: Colors.red,
                                              labelColor: Colors.red,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                userModel.deleteImage();
                                              },
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
                  ],
                );
                  } 
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Rana Fathi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text('rana@gmail.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              onTap: () {
                // Handle edit action
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
