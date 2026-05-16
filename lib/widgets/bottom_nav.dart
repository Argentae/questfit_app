import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme.dart';

class QuestFitBottomNav extends StatelessWidget {
  const QuestFitBottomNav({super.key});

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Quests'),
    BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Avatar'),
    BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];

  static const _routes = ['/', '/quests', '/avatar', '/settings'];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final idx = _routes.indexOf(location);
    return idx >= 0 ? idx : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xEB0A0E1A),
        border: Border(top: BorderSide(color: QuestFitColors.glassBorder)),
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: _currentIndex(context),
          onTap: (i) => context.go(_routes[i]),
          items: _items,
        ),
      ),
    );
  }
}
