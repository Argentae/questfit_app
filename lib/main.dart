import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/theme.dart';
import 'app/router.dart';
import 'providers/app_init_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: QuestFitColors.bgDark,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const ProviderScope(child: QuestFitApp()));
}

class QuestFitApp extends ConsumerStatefulWidget {
  const QuestFitApp({super.key});

  @override
  ConsumerState<QuestFitApp> createState() => _QuestFitAppState();
}

class _QuestFitAppState extends ConsumerState<QuestFitApp> {
  late final _router = createAppRouter(ref);

  @override
  Widget build(BuildContext context) {
    // Watch init state to trigger router redirect on changes
    final initState = ref.watch(appInitProvider);

    // Refresh router when init state changes
    initState.whenData((_) {
      _router.refresh();
    });

    return MaterialApp.router(
      title: 'QuestFit',
      debugShowCheckedModeBanner: false,
      theme: questFitTheme(),
      routerConfig: _router,
    );
  }
}
