import 'package:go_router/go_router.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';
import 'package:noteale_clone/views/about_view.dart';
import 'package:noteale_clone/views/create_account_view.dart';
import 'package:noteale_clone/views/home_view.dart';
import 'package:noteale_clone/views/login_view.dart';
import 'package:noteale_clone/views/note_view.dart';
import 'package:noteale_clone/views/onboarding_view.dart';
import 'package:noteale_clone/views/settings_view.dart';
import 'package:noteale_clone/views/todo_list_view.dart';

// Cache the router to avoid recreating it on every rebuild,
// which can reset to initialLocation unexpectedly.
GoRouter? _cachedRouter;

GoRouter buildRouter(AuthViewModel auth) {
  if (_cachedRouter != null) return _cachedRouter!;
  _cachedRouter = GoRouter(
    initialLocation: '/onboarding',
    refreshListenable: auth,
    redirect: (context, state) {
      // Wait until session restore finishes
      if (auth.isRestoringSession) return null;

      final loggedIn = auth.isLoggedIn;
      final atAuth =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/createAccount' ||
          state.matchedLocation == '/onboarding';

      if (!loggedIn && state.matchedLocation == '/home') {
        return '/login';
      }

      if (loggedIn && atAuth) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/createAccount',
        name: 'createAccount',
        builder: (context, state) => const CreateAccountView(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeView(title: 'NoteAle'),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutView(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/todo',
        name: 'todo',
        builder: (context, state) => const ToDoListView(),
      ),
      GoRoute(
        path: '/notes/:id',
        name: 'note_view',
        builder: (context, state) =>
            NoteView(noteId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/notes',
        name: 'notes',
        builder: (context, state) => const NoteView(),
      ),
    ],
  );
  return _cachedRouter!;
}
