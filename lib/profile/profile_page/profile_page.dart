import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproj/profile/profile_widget/options.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:mobileproj/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _showEditDialog(BuildContext context, UserModel userModel) {
    final nameController = TextEditingController(
      text: userModel.user?.name ?? '',
    );
    final emailController = TextEditingController(
      text: userModel.user?.email ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Profile'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  userModel.updateUserInfo(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        // Removed logout from appBar actions here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserModel>(
          builder: (context, userModel, child) {
            final user = userModel.user;
            return Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 100,
                        child:
                            user?.image == null
                                ? const Icon(Icons.person, size: 100)
                                : ClipOval(
                                  child: Image.file(
                                    user!.image!,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                userModel.selectImage(
                                                  ImageSource.camera,
                                                );
                                              },
                                            ),
                                            ProfileOptionButton(
                                              icon: Icons.photo,
                                              label: 'Gallery',
                                              onPressed: () {
                                                Navigator.pop(context);
                                                userModel.selectImage(
                                                  ImageSource.gallery,
                                                );
                                              },
                                            ),
                                            if (user?.image != null)
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
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.email ?? 'No Email',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Edit Profile'),
                  onTap: () => _showEditDialog(context, userModel),
                ),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(),
                  secondary: Icon(
                    themeProvider.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                ),
                // ListTile(
                //   leading: const Icon(Icons.logout),
                //   title: const Text('Logout'),
                //   onTap: () => logout(context),
                // ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => logout(context),
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(
                      50,
                    ), // full width button height
                    side: const BorderSide(color: Colors.redAccent, width: 2),
                    // You can add shape if you want rounded corners:
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Background color is transparent by default
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
