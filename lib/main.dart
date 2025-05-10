import 'package:flutter/material.dart';
import 'package:mobileproj/home/home_page/home_page.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
//34an lw 7asl ay update n3rfo
    ChangeNotifierProvider(create: (context)=> UserModel(),
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}





