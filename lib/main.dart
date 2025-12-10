import 'package:flutter/material.dart';
import 'package:noteale_clone/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: appRouter,

      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        

        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      
    );
  }
}
