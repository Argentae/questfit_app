# QuestFit v2.1.0 — Gold Economy Rebalance & Promotion UX

**Release Date:** May 17, 2026

---

## ⚡ Highlights

### 🪙 Gold Economy Rebalance
The gold economy has been completely rebalanced to make equipment and exercise difficulty meaningful:

- **Base quest gold reduced**: 25 → **5 gold** per quest
- **Difficulty scaling**: Harder exercises now reward significantly more gold
  - Easy exercises (baseXp < 70): **5g**
  - Medium exercises (70–109): **7g**
  - Hard exercises (110–139): **10g**
  - Very hard exercises (140+): **13g**
- **Equipment bonus**: Quests from equipped weapons earn **+3g** base
- **Rarity multiplier**: Higher rarity weapons add even more gold
  - Common: +0g | Rare: +2g | Epic: +5g | Legendary: +10g
- **Boss raid rewards scaled**: 200–500g → **50–150g**

> *Example: Deadlift from a Legendary weapon = 13 + 3 + 10 = **26g** vs. a Cat-Cow Stretch = **5g***

### 🏆 Promotion Banner UX
- The promotion banner on the Home screen is now **interactive** — tapping navigates to the Tier Ladder screen
- Text now clearly communicates: *"You'll advance to [Rank] on next login!"*
- Added haptic feedback on banner tap
- Rank Trial screen also shows a clear **"⚡ ADVANCING ON NEXT LOGIN!"** label
- Promotion still processes automatically on next app launch (anti-addiction by design)

---

## 🔧 LP Tier System (v3.0 → v3.1)

### Architecture
- Full migration from XP/Level to **LP (League Points) / Tier** system
- 10 tiers: Iron → Bronze → Silver → Gold → Platinum → Emerald → Diamond → Master → Grandmaster → Challenger
- Divisions IV → I within each tier (Master+ have 1 division)
- LP range: 0–100 per division

### Mechanics
- **LP Gain**: Base 8 LP per quest, with mastery and streak bonuses
- **Promotion**: Reaching 100 LP sets `pendingPromotion` flag → auto-promotes on next app launch
- **LP Decay**: 48h inactivity triggers LP loss (scales with tier: 5–20 LP)
- **Demotion**: Decaying below 0 LP drops you to the previous division at 75 LP
- **Streak Insurance**: Consumable that prevents streak breaks

### UI Updates
- Character card shows LP bar, tier badge, and current LP
- Tier-colored borders and glowing effects throughout
- LP toast animations on quest completion
- Tier Ladder visualization showing all ranks

---

## 📦 What's Changed

### Engine
- `gold_engine.dart` — Complete rewrite with difficulty-based and equipment-aware gold calculation
- `quest_engine.dart` — Quests now pass exercise `baseXp` and weapon `rarity` to gold engine
- `lp_engine.dart` — New LP system (replaces XP engine for progression)
- `rank_engine.dart` — Tier/division promotion, demotion, and decay logic

### Providers
- `app_init_provider.dart` — Handles auto-promotion and LP decay on launch
- `rank_trial_provider.dart` — Simplified: no more promotion series, auto-promote only
- `user_provider.dart` — LP award, gold management, and tier-derived providers

### Screens
- `home_screen.dart` — Interactive promotion banner, LP-based quest rewards
- `rank_trial_screen.dart` — Tier Ladder display with rank history
- `shop_screen.dart` — Equipment shop with rarity-tiered weapons
- `loadout_screen.dart` — Weapon loadout management

### Widgets
- `character_card.dart` — LP bar, tier badge, stat chips
- `xp_bar.dart` → `LpBar` — Renamed and redesigned for LP system
- `xp_toast.dart` → `LpToast` — LP-aware toast with promotion variant

---

## 🐛 Fixes
- Fixed promotion banner not responding to taps (was purely decorative)
- Fixed Rank Trial screen compilation error with `ref` in `ConsumerWidget`
- Awakening gate properly restored for production

---

**Full Changelog**: v2.0.0...v2.1.0
