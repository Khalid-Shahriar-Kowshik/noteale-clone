import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noteale_clone/routes/app_router.dart';
import 'package:noteale_clone/viewmodels/theme_viewmodel.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';
import 'package:noteale_clone/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) => ThemeViewModel(initialMode: ThemeMode.system),
        ),
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeVM, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeVM.themeMode,
          );
        },
      ),
    );
  }
}
