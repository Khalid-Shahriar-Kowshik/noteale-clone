import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noteale_clone/routes/app_router.dart';
import 'package:noteale_clone/viewmodels/theme_viewmodel.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';
import 'package:noteale_clone/viewmodels/notes_viewmodel.dart';
import 'package:noteale_clone/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel()..restoreSession(),
        ),
        ChangeNotifierProvider<NotesViewmodel>(create: (_) => NotesViewmodel()),
      ],
      child: Consumer2<ThemeViewModel, AuthViewModel>(
        builder: (context, themeVM, authVM, _) {
          final router = buildRouter(authVM);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: 'Noteale',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeVM.themeMode,
          );
        },
      ),
    );
  }
}
