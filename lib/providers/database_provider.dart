import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';

/// Single source of truth for the Drift database instance.
/// All other providers that need DB access read from this.
final databaseProvider = Provider<QuestFitDatabase>((ref) {
  return QuestFitDatabase.instance;
});
