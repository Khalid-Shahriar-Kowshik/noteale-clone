import 'package:flutter/material.dart';
import 'package:noteale_clone/views/home_view.dart';
import 'package:noteale_clone/views/login_view.dart';
import 'package:noteale_clone/views/onboarding_view.dart';
import 'package:noteale_clone/views/create_account_view.dart';
import 'package:noteale_clone/views/splash_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        

        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: const LoginView(),
    );
  }
}
