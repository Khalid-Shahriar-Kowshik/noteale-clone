import 'package:go_router/go_router.dart';
import 'package:noteale_clone/views/about_view.dart';
import 'package:noteale_clone/views/create_account_view.dart';
import 'package:noteale_clone/views/home_view.dart';
import 'package:noteale_clone/views/login_view.dart';
import 'package:noteale_clone/views/note_view.dart';
import 'package:noteale_clone/views/onboarding_view.dart';
import 'package:noteale_clone/views/settings_view.dart';
import 'package:noteale_clone/views/todo_list_view.dart';

GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      name: "onboarding",
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: '/login',
      name: "login",
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/createAccount',
      name: "createAccount",
      builder: (context, state) => const CreateAccountView(),
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) => const HomeView(title: "NoteAle"),
    ),
    GoRoute(
      path: '/about',
      name: "about",
      builder: (context, state) => const AboutView(),
    ),
    GoRoute(
      path: '/settings',
      name: "settings",
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: '/todo',
      name: "todo",
      builder: (context, state) => const ToDoListView(),
    ),
    GoRoute(
      path: '/notes',
      name: "notes",
      builder: (context, state) => const NoteView(),
    ),
  ],
);
