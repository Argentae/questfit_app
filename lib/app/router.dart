import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_init_provider.dart';
import '../screens/awakening_screen.dart';
import '../screens/bounty_board_screen.dart';
import '../screens/expedition_screen.dart';
import '../screens/grimoire_screen.dart';
import '../screens/home_screen.dart';
// quests_screen removed in v2.3 — replaced by bounty_board_screen
import '../screens/avatar_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/setup_screen.dart';
import '../screens/loadout_screen.dart';
import '../screens/shop_screen.dart';
import '../screens/rank_trial_screen.dart';
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
      final isAwakeningRoute = state.uri.toString() == '/awakening';

      return initState.when(
        loading: () => null, // Stay on current route while loading
        error: (_, __) => null,
        data: (appState) {
          if (appState == AppInitState.needsSetup && !isSetupRoute) {
            return '/setup';
          }
          // v2.0: Redirect to Awakening if not completed
          if (appState == AppInitState.awakening && !isAwakeningRoute) {
            return '/awakening';
          }
          if (appState == AppInitState.ready && isSetupRoute) {
            return '/';
          }
          if (appState == AppInitState.ready && isAwakeningRoute) {
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
      // v2.0: Awakening route — outside the shell (locked screen)
      GoRoute(
        path: '/awakening',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const AwakeningScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      // v2.0: Rank Trial route — outside the shell (full-screen experience)
      // v3.0: Fixed navigation — now supports back button
      GoRoute(
        path: '/rank-trial',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const RankTrialScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
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
          // v2.3: Bounty Board (replaces Quests)
          GoRoute(
            path: '/bounty',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const BountyBoardScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          // v2.0: Loadout / Equipment screen
          GoRoute(
            path: '/loadout',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const LoadoutScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          // v2.0: Shop screen
          GoRoute(
            path: '/shop',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const ShopScreen(),
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
          // v2.2: Grimoire (exercise library) screen
          GoRoute(
            path: '/grimoire',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const GrimoireScreen(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          // v2.2: Expedition (step counter dashboard) screen
          GoRoute(
            path: '/expedition',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const ExpeditionScreen(),
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
