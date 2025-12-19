import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noteale_clone/routes/app_router.dart';
import 'package:noteale_clone/viewmodels/theme_viewmodel.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';
import 'package:noteale_clone/viewmodels/notes_viewmodel.dart';
import 'package:noteale_clone/utils/themes.dart';
import 'package:noteale_clone/views/splash_screen_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showingInitialSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _showingInitialSplash = false);
      }
    });
  }

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
          final showSplash = authVM.isRestoringSession || _showingInitialSplash;

          // Show custom splash screen during initial load or while restoring session
          if (showSplash) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const SplashScreenView(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeVM.themeMode,
            );
          }

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
