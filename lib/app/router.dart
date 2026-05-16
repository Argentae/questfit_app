import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_init_provider.dart';
import '../screens/home_screen.dart';
import '../screens/quests_screen.dart';
import '../screens/avatar_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/setup_screen.dart';
import '../widgets/bottom_nav.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Creates the GoRouter with Riverpod-aware redirect guard.
/// Must be called with a [WidgetRef] to read app init state.
GoRouter createAppRouter(WidgetRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final initState = ref.read(appInitProvider);

      final isSetupRoute = state.uri.toString() == '/setup';

      return initState.when(
        loading: () => null, // Stay on current route while loading
        error: (_, __) => null,
        data: (appState) {
          if (appState == AppInitState.needsSetup && !isSetupRoute) {
            return '/setup';
          }
          if (appState == AppInitState.ready && isSetupRoute) {
            return '/';
          }
          return null;
        },
      );
    },
    routes: [
      // Setup route — outside the shell (no bottom nav)
      GoRoute(
        path: '/setup',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SetupScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      // Main app shell with bottom nav
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const HomeScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/quests',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const QuestsScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/avatar',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const AvatarScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const SettingsScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.03),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
      child: child,
    ),
  );
}

/// App shell with persistent bottom navigation.
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const QuestFitBottomNav(),
    );
  }
}
