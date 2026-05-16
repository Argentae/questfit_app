import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../providers/app_init_provider.dart';

/// First-launch onboarding screen: pick a name and class.
class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _nameController = TextEditingController(text: 'Adventurer');
  String _selectedClass = 'berserker';
  bool _saving = false;

  static const _classes = [
    _ClassOption(
      key: 'berserker',
      name: 'Berserker',
      emoji: '⚔️',
      desc: 'Strength-focused warrior',
      color: QuestFitColors.redAccent,
    ),
    _ClassOption(
      key: 'ranger',
      name: 'Ranger',
      emoji: '🏹',
      desc: 'Cardio & endurance master',
      color: QuestFitColors.blueAccent,
    ),
    _ClassOption(
      key: 'monk',
      name: 'Monk',
      emoji: '🧘',
      desc: 'Flexibility & balance focus',
      color: QuestFitColors.purple,
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);

    await ref
        .read(appInitProvider.notifier)
        .completeSetup(name: name, classType: _selectedClass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Center(
                child: ShaderMask(
                  shaderCallback: goldGradientShader,
                  child: Text(
                    'QUESTFIT',
                    style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Create Your Character',
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: QuestFitColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Name field
              Text('WARRIOR NAME',
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(
                    color: QuestFitColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: QuestFitColors.bgCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: QuestFitColors.glassBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: QuestFitColors.glassBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: QuestFitColors.emerald),
                  ),
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(
                      color: QuestFitColors.textMuted, fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),

              // Class selection
              Text('CHOOSE YOUR CLASS',
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 12),
              ...(_classes.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ClassCard(
                      option: c,
                      selected: _selectedClass == c.key,
                      onTap: () =>
                          setState(() => _selectedClass = c.key),
                    ),
                  ))),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saving ? null : _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: QuestFitColors.emerald,
                    foregroundColor: QuestFitColors.bgDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: QuestFitColors.bgDark),
                        )
                      : Text(
                          'Begin Your Quest',
                          style: GoogleFonts.cinzel(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClassOption {
  final String key;
  final String name;
  final String emoji;
  final String desc;
  final Color color;

  const _ClassOption({
    required this.key,
    required this.name,
    required this.emoji,
    required this.desc,
    required this.color,
  });
}

class _ClassCard extends StatelessWidget {
  final _ClassOption option;
  final bool selected;
  final VoidCallback onTap;

  const _ClassCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? option.color.withValues(alpha: 0.08)
              : QuestFitColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? option.color.withValues(alpha: 0.5)
                : QuestFitColors.glassBorder,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(option.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: selected
                              ? option.color
                              : QuestFitColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(option.desc,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            if (selected)
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: option.color,
                ),
                child: const Icon(Icons.check,
                    size: 14, color: QuestFitColors.bgDark),
              ),
          ],
        ),
      ),
    );
  }
}
