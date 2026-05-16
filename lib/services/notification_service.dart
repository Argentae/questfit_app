import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// QuestFit local push notification service.
/// Handles daily reminders, streak warnings, level-up celebrations, and sync alerts.
class NotificationService {
  NotificationService._();

  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  // Channel IDs
  static const _dailyReminder = 'daily_reminder';
  static const _streakWarning = 'streak_warning';
  static const _levelUp = 'level_up';
  static const _syncComplete = 'sync_complete';

  /// Initialize the notification plugin.
  Future<void> init() async {
    if (_initialized) return;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  /// Show a level-up celebration notification.
  Future<void> showLevelUp(int newLevel, String? newRank) async {
    final rankStr = newRank != null ? ' New rank: $newRank' : '';
    await _show(
      id: 100 + newLevel,
      channelId: _levelUp,
      channelName: 'Level Up',
      title: '🎉 Level $newLevel!',
      body: 'You reached Level $newLevel!$rankStr',
      vibration: Int64List.fromList([0, 300, 200, 300]),
    );
  }

  /// Show a sync completion notification.
  Future<void> showSyncComplete(int importedCount, int totalXp) async {
    if (importedCount <= 0) return;
    await _show(
      id: 200,
      channelId: _syncComplete,
      channelName: 'Sync Complete',
      title: '⚔️ Watch data synced!',
      body: '$importedCount workout${importedCount > 1 ? 's' : ''} imported → +$totalXp XP',
    );
  }

  /// Show a streak warning notification.
  Future<void> showStreakWarning(int currentStreak) async {
    await _show(
      id: 300,
      channelId: _streakWarning,
      channelName: 'Streak Alert',
      title: '🔥 Don\'t break your streak!',
      body: 'Your $currentStreak-day streak is at risk. Complete a quest today!',
    );
  }

  /// Show a daily reminder notification.
  Future<void> showDailyReminder() async {
    await _show(
      id: 400,
      channelId: _dailyReminder,
      channelName: 'Daily Quest Reminder',
      title: '🗡️ Your quests await, warrior!',
      body: 'New daily quests are ready. Rise and grind!',
    );
  }

  Future<void> _show({
    required int id,
    required String channelId,
    required String channelName,
    required String title,
    required String body,
    Int64List? vibration,
  }) async {
    if (!_initialized) {
      debugPrint('NotificationService: not initialized');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      vibrationPattern: vibration ?? Int64List.fromList([0, 250]),
    );

    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(android: androidDetails),
    );
  }
}
