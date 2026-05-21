import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../providers/health_provider.dart';
import '../providers/step_provider.dart';
import '../providers/user_provider.dart';
import '../providers/database_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(playerStreamProvider);
    final healthAvailable = ref.watch(healthAvailableProvider);
    final healthAuthorized = ref.watch(healthAuthorizedProvider);
    final syncState = ref.watch(healthSyncNotifierProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text('Settings',
              style: GoogleFonts.cinzel(
                  fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 24),

          // ── Profile ──
          _SectionTitle('Profile'),
          playerAsync.when(
            data: (player) => Column(
              children: [
                _SettingsRow(
                  label: 'Display Name', 
                  value: player.name,
                  onTap: () => _showEditNameDialog(context, ref, player.name),
                ),
                _SettingsRow(
                  label: 'Class',
                  value: _capitalize(player.classType),
                  onTap: () => _showEditClassDialog(context, ref, player.classType),
                ),
              ],
            ),
            loading: () =>
                const _SettingsRow(label: 'Loading...', value: ''),
            error: (e, _) =>
                _SettingsRow(label: 'Error', value: '$e'),
          ),
          const SizedBox(height: 24),

          // ── Health Connect ──
          _SectionTitle('Health Connect'),
          _buildHealthStatus(healthAvailable, healthAuthorized),
          _buildLastSync(syncState),
          _buildHealthButton(context, ref, healthAvailable,
              healthAuthorized, syncState),
          const SizedBox(height: 24),

          // ── Preferences ──
          _SectionTitle('Preferences'),
          // v2.2: Daily Step Goal slider
          _buildStepGoalSlider(ref),
          _SettingsRow(label: 'Units', value: 'Metric (kg)'),
          _ToggleRow(label: 'Daily Reminder', initialValue: true),
          _ToggleRow(label: 'Haptic Feedback', initialValue: true),
          _ToggleRow(label: 'Sound Effects', initialValue: false),
          const SizedBox(height: 24),

          // ── Data ──
          _SectionTitle('Data'),
          _SettingsRow(
              label: 'Export Data',
              trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Export JSON',
                      style: TextStyle(
                          color: QuestFitColors.emerald,
                          fontSize: 12)))),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                final db = ref.read(databaseProvider);
                await db.resetAllProgress();
                ref.invalidate(playerStreamProvider);
                ref.invalidate(statsStreamProvider);
                // Also reset health sync state
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('health_connect_last_sync');
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All progress has been reset.')),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color:
                        QuestFitColors.redAccent.withValues(alpha: 0.3)),
                backgroundColor:
                    QuestFitColors.redAccent.withValues(alpha: 0.08),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Reset All Progress',
                  style: TextStyle(
                      color: QuestFitColors.redAccent,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),

          // ── About ──
          _SectionTitle('About'),
          _SettingsRow(label: 'Version', value: '2.2.0'),
          _SettingsRow(label: 'Made with', value: '⚔️ & 💪'),
        ],
      ),
    );
  }

  Widget _buildHealthStatus(
      AsyncValue<bool> available, AsyncValue<bool> authorized) {
    final isAvailable = available.valueOrNull ?? false;
    final isAuthorized = authorized.valueOrNull ?? false;

    String status;
    Color color;
    if (!isAvailable) {
      status = 'Not Available';
      color = QuestFitColors.textMuted;
    } else if (isAuthorized) {
      status = 'Connected ✓';
      color = QuestFitColors.emerald;
    } else {
      status = 'Not Connected';
      color = QuestFitColors.orangeAccent;
    }

    return _SettingsRow(label: 'Status', value: status, valueColor: color);
  }

  Widget _buildLastSync(HealthSyncState syncState) {
    String text;
    if (syncState.isSyncing) {
      text = 'Syncing...';
    } else if (syncState.lastResult != null) {
      final r = syncState.lastResult!;
      text = '${r.importedCount} workouts · +${r.totalXp} XP';
    } else if (syncState.error != null) {
      text = 'Error';
    } else {
      text = 'Never';
    }
    return _SettingsRow(label: 'Last Sync', value: text);
  }

  Widget _buildHealthButton(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<bool> available,
    AsyncValue<bool> authorized,
    HealthSyncState syncState,
  ) {
    final isAvailable = available.valueOrNull ?? false;
    final isAuthorized = authorized.valueOrNull ?? false;

    if (!isAvailable) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
                color: QuestFitColors.textMuted.withValues(alpha: 0.3)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Health Connect Not Available',
              style: TextStyle(
                  color: QuestFitColors.textMuted,
                  fontWeight: FontWeight.w600)),
        ),
      );
    }

    if (!isAuthorized) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: OutlinedButton(
          onPressed: () async {
            final granted = await ref
                .read(healthSyncNotifierProvider.notifier)
                .requestPermissions();
            if (context.mounted && !granted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Health Connect permissions denied')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(
                color: QuestFitColors.emerald.withValues(alpha: 0.3)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Connect Health Connect',
              style: TextStyle(
                  color: QuestFitColors.emerald,
                  fontWeight: FontWeight.w600)),
        ),
      );
    }

    // Authorized — show sync button
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: OutlinedButton(
        onPressed: syncState.isSyncing
            ? null
            : () async {
                final result = await ref
                    .read(healthSyncNotifierProvider.notifier)
                    .sync();
                if (context.mounted && result.importedCount > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Imported ${result.importedCount} workouts · +${result.totalXp} XP')),
                  );
                }
              },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: QuestFitColors.emerald.withValues(alpha: 0.3)),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
        ),
        child: syncState.isSyncing
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: QuestFitColors.emerald),
              )
            : const Text('Sync Now',
                style: TextStyle(
                    color: QuestFitColors.emerald,
                    fontWeight: FontWeight.w600)),
      ),
    );
  }

  Future<void> _showEditNameDialog(BuildContext context, WidgetRef ref, String currentName) async {
    final controller = TextEditingController(text: currentName);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: QuestFitColors.bgCard,
        title: const Text('Edit Display Name', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter new name',
            hintStyle: TextStyle(color: QuestFitColors.textMuted),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: QuestFitColors.textMuted))),
          TextButton(onPressed: () => Navigator.pop(ctx, controller.text), child: const Text('Save', style: TextStyle(color: QuestFitColors.emerald))),
        ],
      ),
    );
    if (newName != null && newName.trim().isNotEmpty && newName != currentName) {
      ref.read(userNotifierProvider.notifier).updateName(newName.trim());
    }
  }

  Future<void> _showEditClassDialog(BuildContext context, WidgetRef ref, String currentClass) async {
    final controller = TextEditingController(text: currentClass);
    final newClass = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: QuestFitColors.bgCard,
        title: const Text('Edit Class', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter new class (e.g. warrior)',
            hintStyle: TextStyle(color: QuestFitColors.textMuted),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: QuestFitColors.textMuted))),
          TextButton(onPressed: () => Navigator.pop(ctx, controller.text.toLowerCase()), child: const Text('Save', style: TextStyle(color: QuestFitColors.emerald))),
        ],
      ),
    );
    if (newClass != null && newClass.trim().isNotEmpty && newClass.toLowerCase() != currentClass.toLowerCase()) {
      ref.read(userNotifierProvider.notifier).updateClassType(newClass.trim().toLowerCase());
    }
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  /// v2.2: Step goal slider.
  Widget _buildStepGoalSlider(WidgetRef ref) {
    final goal = ref.watch(dailyStepGoalProvider).toDouble();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: QuestFitColors.glassBorder))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Daily Step Goal',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              Text('${goal.toInt()} steps',
                  style: const TextStyle(
                      fontSize: 13, color: QuestFitColors.emerald,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: QuestFitColors.emerald,
              inactiveTrackColor: QuestFitColors.glassBorder,
              thumbColor: QuestFitColors.emerald,
              overlayColor: QuestFitColors.emerald.withValues(alpha: 0.1),
              trackHeight: 4,
            ),
            child: Slider(
              value: goal,
              min: 4000,
              max: 15000,
              divisions: 22,
              onChanged: (v) {
                ref.read(userNotifierProvider.notifier)
                    .updateStepGoal(v.toInt());
              },
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('4,000', style: TextStyle(
                  fontSize: 10, color: QuestFitColors.textMuted)),
              Text('15,000', style: TextStyle(
                  fontSize: 10, color: QuestFitColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final String? value;
  final Color? valueColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _SettingsRow(
      {required this.label, this.value, this.valueColor, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: QuestFitColors.glassBorder))),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: trailing ??
                Text(value ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            valueColor ?? QuestFitColors.textSecondary)),
          ),
        ],
      ),
    ));
  }
}

class _ToggleRow extends StatefulWidget {
  final String label;
  final bool initialValue;
  const _ToggleRow({required this.label, required this.initialValue});

  @override
  State<_ToggleRow> createState() => _ToggleRowState();
}

class _ToggleRowState extends State<_ToggleRow> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: QuestFitColors.glassBorder))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(widget.label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Switch(
            value: _value,
            onChanged: (v) => setState(() => _value = v),
            activeTrackColor: QuestFitColors.emerald,
            thumbColor: WidgetStateProperty.all(Colors.white),
          ),
        ],
      ),
    );
  }
}
