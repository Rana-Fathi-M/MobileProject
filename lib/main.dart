import 'package:flutter/material.dart';
import 'package:mobileproj/Home/home_page/home_page.dart';
import 'package:mobileproj/add_item/item_model.dart';
import 'package:mobileproj/dashboard/dashboard_screen.dart';
import 'package:mobileproj/dashboard/nav_bar.dart';
import 'package:mobileproj/favorite/favorite_model.dart';
import 'package:mobileproj/land/home_screen.dart';
import 'package:mobileproj/login/login_screen.dart';
// import 'package:mobileproj/dashboard/dashboard_screen.dart';
import 'package:mobileproj/profile/profile_widget/user_model.dart';
import 'package:mobileproj/signup/signup_screen.dart';
import 'package:mobileproj/splash/splash_screen.dart';
import 'package:mobileproj/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => ItemModel()),
        ChangeNotifierProvider(create: (context) => FavoriteModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
       themeMode: themeProvider.currentTheme,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const NavBar(),
      },
    );
  }
}
