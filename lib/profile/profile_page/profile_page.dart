import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100,
                    child: Icon(Icons.person, size: 200),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 25,
                    child: IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.camera_alt, size: 25),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ProfileOptionButton(
                                      icon: Icons.camera_alt,
                                      label: 'Camera',
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Handle camera
                                      },
                                    ),
                                    ProfileOptionButton(
                                      icon: Icons.photo,
                                      label: 'Gallery',
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Handle gallery
                                      },
                                    ),
                                    ProfileOptionButton(
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      iconColor: Colors.red,
                                      labelColor: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Handle delete
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
            const Text(
              'Rana Fathi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'rana@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
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

class ProfileOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? labelColor;

  const ProfileOptionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor ?? Colors.black),
        ),
        Text(
          label,
          style: TextStyle(color: labelColor ?? Colors.black),
        ),
      ],
    );
  }
}
