import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text('Settings', style: GoogleFonts.cinzel(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 24),
          _SectionTitle('Profile'),
          _SettingsRow(label: 'Display Name', value: 'IronLift_Agus'),
          _SettingsRow(label: 'Class', value: 'Berserker'),
          const SizedBox(height: 24),
          _SectionTitle('Health Connect'),
          _SettingsRow(label: 'Status', value: 'Not Connected', valueColor: QuestFitColors.textMuted),
          _SettingsRow(label: 'Last Sync', value: 'Never'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: QuestFitColors.emerald.withValues(alpha: 0.3)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Connect Samsung Watch', style: TextStyle(color: QuestFitColors.emerald, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Preferences'),
          _SettingsRow(label: 'Units', value: 'Metric (kg)'),
          _ToggleRow(label: 'Daily Reminder', initialValue: true),
          _ToggleRow(label: 'Haptic Feedback', initialValue: true),
          _ToggleRow(label: 'Sound Effects', initialValue: false),
          const SizedBox(height: 24),
          _SectionTitle('Data'),
          _SettingsRow(label: 'Export Data', trailing: TextButton(onPressed: () {}, child: const Text('Export JSON', style: TextStyle(color: QuestFitColors.emerald, fontSize: 12)))),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: QuestFitColors.redAccent.withValues(alpha: 0.3)),
                backgroundColor: QuestFitColors.redAccent.withValues(alpha: 0.08),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Reset All Progress', style: TextStyle(color: QuestFitColors.redAccent, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('About'),
          _SettingsRow(label: 'Version', value: '1.0.0'),
          _SettingsRow(label: 'Made with', value: '⚔️ & 💪'),
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
  const _SettingsRow({required this.label, this.value, this.valueColor, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: QuestFitColors.glassBorder))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          trailing ?? Text(value ?? '', style: TextStyle(fontSize: 13, color: valueColor ?? QuestFitColors.textSecondary)),
        ],
      ),
    );
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
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: QuestFitColors.glassBorder))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Switch(
            value: _value,
            onChanged: (v) => setState(() => _value = v),
            activeColor: QuestFitColors.emerald,
          ),
        ],
      ),
    );
  }
}
