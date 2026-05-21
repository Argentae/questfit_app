import 'package:flutter_test/flutter_test.dart';
import 'package:questfit_app/engine/rhythm_engine.dart';

void main() {
  group('RhythmEngine Tests', () {
    group('Rest Buff Calculation', () {
      test('Sleep under 5 hours yields no buff', () {
        final buff = RhythmEngine.calculateRestBuff(sleepMinutes: 240); // 4 hours
        expect(buff.tier, 'none');
        expect(buff.multiplier, 1.0);
      });

      test('Sleep over 5 hours yields light buff', () {
        final buff = RhythmEngine.calculateRestBuff(sleepMinutes: 360); // 6 hours
        expect(buff.tier, 'light');
        expect(buff.multiplier, greaterThan(1.0));
      });

      test('High quality sleep adds multiplier bonus', () {
        final buff = RhythmEngine.calculateRestBuff(
          sleepMinutes: 420, // 7 hours (optimal base = 1.10)
          deepSleepMinutes: 80,
          remSleepMinutes: 60, // Total quality = 140 mins
        );
        expect(buff.tier, 'well_rested');
        expect(buff.multiplier, closeTo(1.15, 0.001));
      });
    });

    group('Aether Calculation', () {
      test('Under 100 calories yields 0 Aether', () {
        final result = RhythmEngine.calculateAether(activeCalories: 80);
        expect(result.earned, 0);
      });

      test('Exact conversion rates', () {
        final result = RhythmEngine.calculateAether(activeCalories: 160);
        // 160 / 50 = 3 Aether
        expect(result.earned, 3);
      });

      test('Aether is capped at 30 per day', () {
        final result = RhythmEngine.calculateAether(activeCalories: 3000); // would be 60
        expect(result.earned, 30);
      });
    });

    group('Intensity Analysis', () {
      test('Zone 1 (Recovery) correctly calculated', () {
        // max HR for age 30 = 187. 50% = 93.5
        final bonus = RhythmEngine.analyzeIntensity(avgHeartRate: 90, age: 30);
        expect(bonus.zone, 1);
        expect(bonus.multiplier, 1.0);
      });

      test('Zone 3 (Aerobic) correctly calculated', () {
        // max HR = 187. 75% = 140.25
        final bonus = RhythmEngine.analyzeIntensity(avgHeartRate: 140, age: 30);
        expect(bonus.zone, 3);
        expect(bonus.multiplier, 1.15);
      });

      test('Zone 5 (Max effort) correctly calculated', () {
        // max HR = 187. 95% = 177.65
        final bonus = RhythmEngine.analyzeIntensity(avgHeartRate: 180, age: 30);
        expect(bonus.zone, 5);
        expect(bonus.multiplier, 1.50);
      });
    });
  });
}
