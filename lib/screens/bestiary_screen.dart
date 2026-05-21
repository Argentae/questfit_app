import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../providers/bestiary_provider.dart';

class BestiaryScreen extends ConsumerWidget {
  const BestiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bestiaryAsync = ref.watch(bestiaryProvider);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: QuestFitColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'BESTIARY',
          style: GoogleFonts.cinzel(
            fontSize: 22, fontWeight: FontWeight.w900,
            foreground: Paint()..shader = goldGradientShader(
              const Rect.fromLTWH(0, 0, 200, 30)),
          ),
        ),
      ),
      body: bestiaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: QuestFitColors.emerald)),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: QuestFitColors.redAccent))),
        data: (entries) {
          final discovered = entries.where((e) => (e.stats?.timesDefeated ?? 0) > 0).length;
          final total = entries.length;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DISCOVERED', style: GoogleFonts.cinzel(color: QuestFitColors.textMuted, fontWeight: FontWeight.bold)),
                    Text('$discovered / $total', style: const TextStyle(color: QuestFitColors.gold, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    return _BestiaryCard(entry: entries[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BestiaryCard extends StatelessWidget {
  final BestiaryEntry entry;
  const _BestiaryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isDiscovered = (entry.stats?.timesDefeated ?? 0) > 0;

    return Container(
      decoration: glassCard(borderRadius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Area
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: isDiscovered ? QuestFitColors.bgCard : QuestFitColors.bgDark,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isDiscovered
                      ? Image.asset(entry.enemy.imagePath)
                      : ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.black54, // Silhouette
                            BlendMode.srcATop,
                          ),
                          child: Image.asset(entry.enemy.imagePath),
                        ),
                ),
              ),
            ),
          ),
          // Info Area
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: isDiscovered
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entry.enemy.name,
                          style: GoogleFonts.cinzel(
                            color: QuestFitColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Defeated: ${entry.stats!.timesDefeated}',
                          style: const TextStyle(color: QuestFitColors.emerald, fontSize: 11),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tier: ${entry.enemy.tier.toUpperCase()}',
                          style: const TextStyle(color: QuestFitColors.textMuted, fontSize: 10),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '???',
                          style: GoogleFonts.cinzel(
                            color: QuestFitColors.textMuted,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Undiscovered', style: TextStyle(color: QuestFitColors.textMuted, fontSize: 10)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
