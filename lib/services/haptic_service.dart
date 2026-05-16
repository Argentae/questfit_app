import 'package:flutter/services.dart';

/// QuestFit native haptic feedback service.
/// Wraps Flutter's built-in HapticFeedback with game-specific event patterns.
class HapticService {
  const HapticService._();

  /// Light tap — quest completed manually.
  static Future<void> onQuestComplete() async {
    await HapticFeedback.lightImpact();
  }

  /// Selection click — quest auto-imported from Health Connect.
  static Future<void> onQuestImported() async {
    await HapticFeedback.selectionClick();
  }

  /// Heavy impact — player leveled up.
  static Future<void> onLevelUp() async {
    await HapticFeedback.heavyImpact();
  }

  /// Double heavy impact — player ranked up.
  static Future<void> onRankUp() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 150));
    await HapticFeedback.heavyImpact();
  }

  /// Medium impact — boss raid completed.
  static Future<void> onBossRaidComplete() async {
    await HapticFeedback.mediumImpact();
  }

  /// Light tap — UI interaction (toggle, filter pill, etc.).
  static Future<void> onUiTap() async {
    await HapticFeedback.selectionClick();
  }
}
