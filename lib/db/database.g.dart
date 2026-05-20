// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Adventurer'),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('iron'),
  );
  static const VerificationMeta _divisionMeta = const VerificationMeta(
    'division',
  );
  @override
  late final GeneratedColumn<int> division = GeneratedColumn<int>(
    'division',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _lpMeta = const VerificationMeta('lp');
  @override
  late final GeneratedColumn<int> lp = GeneratedColumn<int>(
    'lp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalQuestsCompletedMeta =
      const VerificationMeta('totalQuestsCompleted');
  @override
  late final GeneratedColumn<int> totalQuestsCompleted = GeneratedColumn<int>(
    'total_quests_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActivityAtMeta = const VerificationMeta(
    'lastActivityAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastActivityAt =
      GeneratedColumn<DateTime>(
        'last_activity_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pendingPromotionMeta = const VerificationMeta(
    'pendingPromotion',
  );
  @override
  late final GeneratedColumn<bool> pendingPromotion = GeneratedColumn<bool>(
    'pending_promotion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_promotion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('iron_1'),
  );
  static const VerificationMeta _classTypeMeta = const VerificationMeta(
    'classType',
  );
  @override
  late final GeneratedColumn<String> classType = GeneratedColumn<String>(
    'class_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('berserker'),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _awakeningCompleteMeta = const VerificationMeta(
    'awakeningComplete',
  );
  @override
  late final GeneratedColumn<bool> awakeningComplete = GeneratedColumn<bool>(
    'awakening_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("awakening_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dailyStepGoalMeta = const VerificationMeta(
    'dailyStepGoal',
  );
  @override
  late final GeneratedColumn<int> dailyStepGoal = GeneratedColumn<int>(
    'daily_step_goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8000),
  );
  static const VerificationMeta _momentumBuffActiveMeta =
      const VerificationMeta('momentumBuffActive');
  @override
  late final GeneratedColumn<bool> momentumBuffActive = GeneratedColumn<bool>(
    'momentum_buff_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("momentum_buff_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    level,
    xp,
    totalXp,
    tier,
    division,
    lp,
    totalQuestsCompleted,
    lastActivityAt,
    pendingPromotion,
    rank,
    classType,
    gold,
    awakeningComplete,
    createdAt,
    dailyStepGoal,
    momentumBuffActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('division')) {
      context.handle(
        _divisionMeta,
        division.isAcceptableOrUnknown(data['division']!, _divisionMeta),
      );
    }
    if (data.containsKey('lp')) {
      context.handle(_lpMeta, lp.isAcceptableOrUnknown(data['lp']!, _lpMeta));
    }
    if (data.containsKey('total_quests_completed')) {
      context.handle(
        _totalQuestsCompletedMeta,
        totalQuestsCompleted.isAcceptableOrUnknown(
          data['total_quests_completed']!,
          _totalQuestsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('last_activity_at')) {
      context.handle(
        _lastActivityAtMeta,
        lastActivityAt.isAcceptableOrUnknown(
          data['last_activity_at']!,
          _lastActivityAtMeta,
        ),
      );
    }
    if (data.containsKey('pending_promotion')) {
      context.handle(
        _pendingPromotionMeta,
        pendingPromotion.isAcceptableOrUnknown(
          data['pending_promotion']!,
          _pendingPromotionMeta,
        ),
      );
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    }
    if (data.containsKey('class_type')) {
      context.handle(
        _classTypeMeta,
        classType.isAcceptableOrUnknown(data['class_type']!, _classTypeMeta),
      );
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    if (data.containsKey('awakening_complete')) {
      context.handle(
        _awakeningCompleteMeta,
        awakeningComplete.isAcceptableOrUnknown(
          data['awakening_complete']!,
          _awakeningCompleteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('daily_step_goal')) {
      context.handle(
        _dailyStepGoalMeta,
        dailyStepGoal.isAcceptableOrUnknown(
          data['daily_step_goal']!,
          _dailyStepGoalMeta,
        ),
      );
    }
    if (data.containsKey('momentum_buff_active')) {
      context.handle(
        _momentumBuffActiveMeta,
        momentumBuffActive.isAcceptableOrUnknown(
          data['momentum_buff_active']!,
          _momentumBuffActiveMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      level:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}level'],
          )!,
      xp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp'],
          )!,
      totalXp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_xp'],
          )!,
      tier:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}tier'],
          )!,
      division:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}division'],
          )!,
      lp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}lp'],
          )!,
      totalQuestsCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_quests_completed'],
          )!,
      lastActivityAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_activity_at'],
      ),
      pendingPromotion:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}pending_promotion'],
          )!,
      rank:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rank'],
          )!,
      classType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}class_type'],
          )!,
      gold:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}gold'],
          )!,
      awakeningComplete:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}awakening_complete'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      dailyStepGoal:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}daily_step_goal'],
          )!,
      momentumBuffActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}momentum_buff_active'],
          )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final int level;
  final int xp;
  final int totalXp;

  /// Current tier name (lowercase): 'iron', 'bronze', 'silver', etc.
  final String tier;

  /// Current division within tier: 4 (lowest) to 1 (highest).
  final int division;

  /// Current LP: 0–100.
  final int lp;

  /// Total quests completed (lifetime vanity stat).
  final int totalQuestsCompleted;

  /// Last time the player completed a quest (for 48h decay).
  final DateTime? lastActivityAt;

  /// Whether a promotion is pending (LP hit 100, will promote on next launch).
  final bool pendingPromotion;
  final String rank;
  final String classType;

  /// v2.0: Gold economy
  final int gold;

  /// v2.0: Awakening flag — true once the player clears the Proving Grounds
  final bool awakeningComplete;
  final DateTime createdAt;

  /// v2.2: Daily step goal for Momentum Buff (default 8000)
  final int dailyStepGoal;

  /// v2.2: Whether the Momentum Buff is active today
  final bool momentumBuffActive;
  const Player({
    required this.id,
    required this.name,
    required this.level,
    required this.xp,
    required this.totalXp,
    required this.tier,
    required this.division,
    required this.lp,
    required this.totalQuestsCompleted,
    this.lastActivityAt,
    required this.pendingPromotion,
    required this.rank,
    required this.classType,
    required this.gold,
    required this.awakeningComplete,
    required this.createdAt,
    required this.dailyStepGoal,
    required this.momentumBuffActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['level'] = Variable<int>(level);
    map['xp'] = Variable<int>(xp);
    map['total_xp'] = Variable<int>(totalXp);
    map['tier'] = Variable<String>(tier);
    map['division'] = Variable<int>(division);
    map['lp'] = Variable<int>(lp);
    map['total_quests_completed'] = Variable<int>(totalQuestsCompleted);
    if (!nullToAbsent || lastActivityAt != null) {
      map['last_activity_at'] = Variable<DateTime>(lastActivityAt);
    }
    map['pending_promotion'] = Variable<bool>(pendingPromotion);
    map['rank'] = Variable<String>(rank);
    map['class_type'] = Variable<String>(classType);
    map['gold'] = Variable<int>(gold);
    map['awakening_complete'] = Variable<bool>(awakeningComplete);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['daily_step_goal'] = Variable<int>(dailyStepGoal);
    map['momentum_buff_active'] = Variable<bool>(momentumBuffActive);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      level: Value(level),
      xp: Value(xp),
      totalXp: Value(totalXp),
      tier: Value(tier),
      division: Value(division),
      lp: Value(lp),
      totalQuestsCompleted: Value(totalQuestsCompleted),
      lastActivityAt:
          lastActivityAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastActivityAt),
      pendingPromotion: Value(pendingPromotion),
      rank: Value(rank),
      classType: Value(classType),
      gold: Value(gold),
      awakeningComplete: Value(awakeningComplete),
      createdAt: Value(createdAt),
      dailyStepGoal: Value(dailyStepGoal),
      momentumBuffActive: Value(momentumBuffActive),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      level: serializer.fromJson<int>(json['level']),
      xp: serializer.fromJson<int>(json['xp']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      tier: serializer.fromJson<String>(json['tier']),
      division: serializer.fromJson<int>(json['division']),
      lp: serializer.fromJson<int>(json['lp']),
      totalQuestsCompleted: serializer.fromJson<int>(
        json['totalQuestsCompleted'],
      ),
      lastActivityAt: serializer.fromJson<DateTime?>(json['lastActivityAt']),
      pendingPromotion: serializer.fromJson<bool>(json['pendingPromotion']),
      rank: serializer.fromJson<String>(json['rank']),
      classType: serializer.fromJson<String>(json['classType']),
      gold: serializer.fromJson<int>(json['gold']),
      awakeningComplete: serializer.fromJson<bool>(json['awakeningComplete']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      dailyStepGoal: serializer.fromJson<int>(json['dailyStepGoal']),
      momentumBuffActive: serializer.fromJson<bool>(json['momentumBuffActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'level': serializer.toJson<int>(level),
      'xp': serializer.toJson<int>(xp),
      'totalXp': serializer.toJson<int>(totalXp),
      'tier': serializer.toJson<String>(tier),
      'division': serializer.toJson<int>(division),
      'lp': serializer.toJson<int>(lp),
      'totalQuestsCompleted': serializer.toJson<int>(totalQuestsCompleted),
      'lastActivityAt': serializer.toJson<DateTime?>(lastActivityAt),
      'pendingPromotion': serializer.toJson<bool>(pendingPromotion),
      'rank': serializer.toJson<String>(rank),
      'classType': serializer.toJson<String>(classType),
      'gold': serializer.toJson<int>(gold),
      'awakeningComplete': serializer.toJson<bool>(awakeningComplete),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'dailyStepGoal': serializer.toJson<int>(dailyStepGoal),
      'momentumBuffActive': serializer.toJson<bool>(momentumBuffActive),
    };
  }

  Player copyWith({
    int? id,
    String? name,
    int? level,
    int? xp,
    int? totalXp,
    String? tier,
    int? division,
    int? lp,
    int? totalQuestsCompleted,
    Value<DateTime?> lastActivityAt = const Value.absent(),
    bool? pendingPromotion,
    String? rank,
    String? classType,
    int? gold,
    bool? awakeningComplete,
    DateTime? createdAt,
    int? dailyStepGoal,
    bool? momentumBuffActive,
  }) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    level: level ?? this.level,
    xp: xp ?? this.xp,
    totalXp: totalXp ?? this.totalXp,
    tier: tier ?? this.tier,
    division: division ?? this.division,
    lp: lp ?? this.lp,
    totalQuestsCompleted: totalQuestsCompleted ?? this.totalQuestsCompleted,
    lastActivityAt:
        lastActivityAt.present ? lastActivityAt.value : this.lastActivityAt,
    pendingPromotion: pendingPromotion ?? this.pendingPromotion,
    rank: rank ?? this.rank,
    classType: classType ?? this.classType,
    gold: gold ?? this.gold,
    awakeningComplete: awakeningComplete ?? this.awakeningComplete,
    createdAt: createdAt ?? this.createdAt,
    dailyStepGoal: dailyStepGoal ?? this.dailyStepGoal,
    momentumBuffActive: momentumBuffActive ?? this.momentumBuffActive,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      level: data.level.present ? data.level.value : this.level,
      xp: data.xp.present ? data.xp.value : this.xp,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      tier: data.tier.present ? data.tier.value : this.tier,
      division: data.division.present ? data.division.value : this.division,
      lp: data.lp.present ? data.lp.value : this.lp,
      totalQuestsCompleted:
          data.totalQuestsCompleted.present
              ? data.totalQuestsCompleted.value
              : this.totalQuestsCompleted,
      lastActivityAt:
          data.lastActivityAt.present
              ? data.lastActivityAt.value
              : this.lastActivityAt,
      pendingPromotion:
          data.pendingPromotion.present
              ? data.pendingPromotion.value
              : this.pendingPromotion,
      rank: data.rank.present ? data.rank.value : this.rank,
      classType: data.classType.present ? data.classType.value : this.classType,
      gold: data.gold.present ? data.gold.value : this.gold,
      awakeningComplete:
          data.awakeningComplete.present
              ? data.awakeningComplete.value
              : this.awakeningComplete,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      dailyStepGoal:
          data.dailyStepGoal.present
              ? data.dailyStepGoal.value
              : this.dailyStepGoal,
      momentumBuffActive:
          data.momentumBuffActive.present
              ? data.momentumBuffActive.value
              : this.momentumBuffActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('totalXp: $totalXp, ')
          ..write('tier: $tier, ')
          ..write('division: $division, ')
          ..write('lp: $lp, ')
          ..write('totalQuestsCompleted: $totalQuestsCompleted, ')
          ..write('lastActivityAt: $lastActivityAt, ')
          ..write('pendingPromotion: $pendingPromotion, ')
          ..write('rank: $rank, ')
          ..write('classType: $classType, ')
          ..write('gold: $gold, ')
          ..write('awakeningComplete: $awakeningComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('dailyStepGoal: $dailyStepGoal, ')
          ..write('momentumBuffActive: $momentumBuffActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    level,
    xp,
    totalXp,
    tier,
    division,
    lp,
    totalQuestsCompleted,
    lastActivityAt,
    pendingPromotion,
    rank,
    classType,
    gold,
    awakeningComplete,
    createdAt,
    dailyStepGoal,
    momentumBuffActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.level == this.level &&
          other.xp == this.xp &&
          other.totalXp == this.totalXp &&
          other.tier == this.tier &&
          other.division == this.division &&
          other.lp == this.lp &&
          other.totalQuestsCompleted == this.totalQuestsCompleted &&
          other.lastActivityAt == this.lastActivityAt &&
          other.pendingPromotion == this.pendingPromotion &&
          other.rank == this.rank &&
          other.classType == this.classType &&
          other.gold == this.gold &&
          other.awakeningComplete == this.awakeningComplete &&
          other.createdAt == this.createdAt &&
          other.dailyStepGoal == this.dailyStepGoal &&
          other.momentumBuffActive == this.momentumBuffActive);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> level;
  final Value<int> xp;
  final Value<int> totalXp;
  final Value<String> tier;
  final Value<int> division;
  final Value<int> lp;
  final Value<int> totalQuestsCompleted;
  final Value<DateTime?> lastActivityAt;
  final Value<bool> pendingPromotion;
  final Value<String> rank;
  final Value<String> classType;
  final Value<int> gold;
  final Value<bool> awakeningComplete;
  final Value<DateTime> createdAt;
  final Value<int> dailyStepGoal;
  final Value<bool> momentumBuffActive;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.tier = const Value.absent(),
    this.division = const Value.absent(),
    this.lp = const Value.absent(),
    this.totalQuestsCompleted = const Value.absent(),
    this.lastActivityAt = const Value.absent(),
    this.pendingPromotion = const Value.absent(),
    this.rank = const Value.absent(),
    this.classType = const Value.absent(),
    this.gold = const Value.absent(),
    this.awakeningComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dailyStepGoal = const Value.absent(),
    this.momentumBuffActive = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.tier = const Value.absent(),
    this.division = const Value.absent(),
    this.lp = const Value.absent(),
    this.totalQuestsCompleted = const Value.absent(),
    this.lastActivityAt = const Value.absent(),
    this.pendingPromotion = const Value.absent(),
    this.rank = const Value.absent(),
    this.classType = const Value.absent(),
    this.gold = const Value.absent(),
    this.awakeningComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dailyStepGoal = const Value.absent(),
    this.momentumBuffActive = const Value.absent(),
  });
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? level,
    Expression<int>? xp,
    Expression<int>? totalXp,
    Expression<String>? tier,
    Expression<int>? division,
    Expression<int>? lp,
    Expression<int>? totalQuestsCompleted,
    Expression<DateTime>? lastActivityAt,
    Expression<bool>? pendingPromotion,
    Expression<String>? rank,
    Expression<String>? classType,
    Expression<int>? gold,
    Expression<bool>? awakeningComplete,
    Expression<DateTime>? createdAt,
    Expression<int>? dailyStepGoal,
    Expression<bool>? momentumBuffActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (level != null) 'level': level,
      if (xp != null) 'xp': xp,
      if (totalXp != null) 'total_xp': totalXp,
      if (tier != null) 'tier': tier,
      if (division != null) 'division': division,
      if (lp != null) 'lp': lp,
      if (totalQuestsCompleted != null)
        'total_quests_completed': totalQuestsCompleted,
      if (lastActivityAt != null) 'last_activity_at': lastActivityAt,
      if (pendingPromotion != null) 'pending_promotion': pendingPromotion,
      if (rank != null) 'rank': rank,
      if (classType != null) 'class_type': classType,
      if (gold != null) 'gold': gold,
      if (awakeningComplete != null) 'awakening_complete': awakeningComplete,
      if (createdAt != null) 'created_at': createdAt,
      if (dailyStepGoal != null) 'daily_step_goal': dailyStepGoal,
      if (momentumBuffActive != null)
        'momentum_buff_active': momentumBuffActive,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? level,
    Value<int>? xp,
    Value<int>? totalXp,
    Value<String>? tier,
    Value<int>? division,
    Value<int>? lp,
    Value<int>? totalQuestsCompleted,
    Value<DateTime?>? lastActivityAt,
    Value<bool>? pendingPromotion,
    Value<String>? rank,
    Value<String>? classType,
    Value<int>? gold,
    Value<bool>? awakeningComplete,
    Value<DateTime>? createdAt,
    Value<int>? dailyStepGoal,
    Value<bool>? momentumBuffActive,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      totalXp: totalXp ?? this.totalXp,
      tier: tier ?? this.tier,
      division: division ?? this.division,
      lp: lp ?? this.lp,
      totalQuestsCompleted: totalQuestsCompleted ?? this.totalQuestsCompleted,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      pendingPromotion: pendingPromotion ?? this.pendingPromotion,
      rank: rank ?? this.rank,
      classType: classType ?? this.classType,
      gold: gold ?? this.gold,
      awakeningComplete: awakeningComplete ?? this.awakeningComplete,
      createdAt: createdAt ?? this.createdAt,
      dailyStepGoal: dailyStepGoal ?? this.dailyStepGoal,
      momentumBuffActive: momentumBuffActive ?? this.momentumBuffActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (division.present) {
      map['division'] = Variable<int>(division.value);
    }
    if (lp.present) {
      map['lp'] = Variable<int>(lp.value);
    }
    if (totalQuestsCompleted.present) {
      map['total_quests_completed'] = Variable<int>(totalQuestsCompleted.value);
    }
    if (lastActivityAt.present) {
      map['last_activity_at'] = Variable<DateTime>(lastActivityAt.value);
    }
    if (pendingPromotion.present) {
      map['pending_promotion'] = Variable<bool>(pendingPromotion.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (classType.present) {
      map['class_type'] = Variable<String>(classType.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (awakeningComplete.present) {
      map['awakening_complete'] = Variable<bool>(awakeningComplete.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (dailyStepGoal.present) {
      map['daily_step_goal'] = Variable<int>(dailyStepGoal.value);
    }
    if (momentumBuffActive.present) {
      map['momentum_buff_active'] = Variable<bool>(momentumBuffActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('totalXp: $totalXp, ')
          ..write('tier: $tier, ')
          ..write('division: $division, ')
          ..write('lp: $lp, ')
          ..write('totalQuestsCompleted: $totalQuestsCompleted, ')
          ..write('lastActivityAt: $lastActivityAt, ')
          ..write('pendingPromotion: $pendingPromotion, ')
          ..write('rank: $rank, ')
          ..write('classType: $classType, ')
          ..write('gold: $gold, ')
          ..write('awakeningComplete: $awakeningComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('dailyStepGoal: $dailyStepGoal, ')
          ..write('momentumBuffActive: $momentumBuffActive')
          ..write(')'))
        .toString();
  }
}

class $StatsTable extends Stats with TableInfo<$StatsTable, Stat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _strMeta = const VerificationMeta('str');
  @override
  late final GeneratedColumn<int> str = GeneratedColumn<int>(
    'str',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<int> end = GeneratedColumn<int>(
    'end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _agiMeta = const VerificationMeta('agi');
  @override
  late final GeneratedColumn<int> agi = GeneratedColumn<int>(
    'agi',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    str,
    end,
    agi,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<Stat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('str')) {
      context.handle(
        _strMeta,
        str.isAcceptableOrUnknown(data['str']!, _strMeta),
      );
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    }
    if (data.containsKey('agi')) {
      context.handle(
        _agiMeta,
        agi.isAcceptableOrUnknown(data['agi']!, _agiMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stat(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      str:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}str'],
          )!,
      end:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}end'],
          )!,
      agi:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}agi'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $StatsTable createAlias(String alias) {
    return $StatsTable(attachedDatabase, alias);
  }
}

class Stat extends DataClass implements Insertable<Stat> {
  final int id;
  final int playerId;

  /// Strength (STR) — earned from strength quests.
  final int str;

  /// Cardio (CDO) — earned from cardio quests (was "endurance").
  final int end;

  /// Flexibility (FLX) — earned from flexibility quests (was "agility").
  final int agi;
  final DateTime updatedAt;
  const Stat({
    required this.id,
    required this.playerId,
    required this.str,
    required this.end,
    required this.agi,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['str'] = Variable<int>(str);
    map['end'] = Variable<int>(end);
    map['agi'] = Variable<int>(agi);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StatsCompanion toCompanion(bool nullToAbsent) {
    return StatsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      str: Value(str),
      end: Value(end),
      agi: Value(agi),
      updatedAt: Value(updatedAt),
    );
  }

  factory Stat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stat(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      str: serializer.fromJson<int>(json['str']),
      end: serializer.fromJson<int>(json['end']),
      agi: serializer.fromJson<int>(json['agi']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'str': serializer.toJson<int>(str),
      'end': serializer.toJson<int>(end),
      'agi': serializer.toJson<int>(agi),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Stat copyWith({
    int? id,
    int? playerId,
    int? str,
    int? end,
    int? agi,
    DateTime? updatedAt,
  }) => Stat(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    str: str ?? this.str,
    end: end ?? this.end,
    agi: agi ?? this.agi,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Stat copyWithCompanion(StatsCompanion data) {
    return Stat(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      str: data.str.present ? data.str.value : this.str,
      end: data.end.present ? data.end.value : this.end,
      agi: data.agi.present ? data.agi.value : this.agi,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Stat(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('str: $str, ')
          ..write('end: $end, ')
          ..write('agi: $agi, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, str, end, agi, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stat &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.str == this.str &&
          other.end == this.end &&
          other.agi == this.agi &&
          other.updatedAt == this.updatedAt);
}

class StatsCompanion extends UpdateCompanion<Stat> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> str;
  final Value<int> end;
  final Value<int> agi;
  final Value<DateTime> updatedAt;
  const StatsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.str = const Value.absent(),
    this.end = const Value.absent(),
    this.agi = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StatsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    this.str = const Value.absent(),
    this.end = const Value.absent(),
    this.agi = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : playerId = Value(playerId);
  static Insertable<Stat> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? str,
    Expression<int>? end,
    Expression<int>? agi,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (str != null) 'str': str,
      if (end != null) 'end': end,
      if (agi != null) 'agi': agi,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StatsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<int>? str,
    Value<int>? end,
    Value<int>? agi,
    Value<DateTime>? updatedAt,
  }) {
    return StatsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      str: str ?? this.str,
      end: end ?? this.end,
      agi: agi ?? this.agi,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (str.present) {
      map['str'] = Variable<int>(str.value);
    }
    if (end.present) {
      map['end'] = Variable<int>(end.value);
    }
    if (agi.present) {
      map['agi'] = Variable<int>(agi.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('str: $str, ')
          ..write('end: $end, ')
          ..write('agi: $agi, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $QuestsTable extends Quests with TableInfo<$QuestsTable, Quest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lpRewardMeta = const VerificationMeta(
    'lpReward',
  );
  @override
  late final GeneratedColumn<int> lpReward = GeneratedColumn<int>(
    'lp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _goldRewardMeta = const VerificationMeta(
    'goldReward',
  );
  @override
  late final GeneratedColumn<int> goldReward = GeneratedColumn<int>(
    'gold_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDailyMeta = const VerificationMeta(
    'isDaily',
  );
  @override
  late final GeneratedColumn<bool> isDaily = GeneratedColumn<bool>(
    'is_daily',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_daily" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    description,
    sets,
    reps,
    duration,
    xpReward,
    lpReward,
    goldReward,
    isDaily,
    isCompleted,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quests';
  @override
  VerificationContext validateIntegrity(
    Insertable<Quest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('lp_reward')) {
      context.handle(
        _lpRewardMeta,
        lpReward.isAcceptableOrUnknown(data['lp_reward']!, _lpRewardMeta),
      );
    }
    if (data.containsKey('gold_reward')) {
      context.handle(
        _goldRewardMeta,
        goldReward.isAcceptableOrUnknown(data['gold_reward']!, _goldRewardMeta),
      );
    }
    if (data.containsKey('is_daily')) {
      context.handle(
        _isDailyMeta,
        isDaily.isAcceptableOrUnknown(data['is_daily']!, _isDailyMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quest(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      xpReward:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp_reward'],
          )!,
      lpReward:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}lp_reward'],
          )!,
      goldReward:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}gold_reward'],
          )!,
      isDaily:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_daily'],
          )!,
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $QuestsTable createAlias(String alias) {
    return $QuestsTable(attachedDatabase, alias);
  }
}

class Quest extends DataClass implements Insertable<Quest> {
  final int id;
  final String title;
  final String category;
  final String description;
  final int? sets;
  final int? reps;
  final int? duration;

  /// Legacy XP reward (kept for migration safety).
  final int xpReward;

  /// v3.0: LP reward for this quest (base, before bonuses).
  final int lpReward;

  /// v2.0: Gold reward for quest completion.
  final int goldReward;
  final bool isDaily;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  const Quest({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    this.sets,
    this.reps,
    this.duration,
    required this.xpReward,
    required this.lpReward,
    required this.goldReward,
    required this.isDaily,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || sets != null) {
      map['sets'] = Variable<int>(sets);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    map['xp_reward'] = Variable<int>(xpReward);
    map['lp_reward'] = Variable<int>(lpReward);
    map['gold_reward'] = Variable<int>(goldReward);
    map['is_daily'] = Variable<bool>(isDaily);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuestsCompanion toCompanion(bool nullToAbsent) {
    return QuestsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      description: Value(description),
      sets: sets == null && nullToAbsent ? const Value.absent() : Value(sets),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      duration:
          duration == null && nullToAbsent
              ? const Value.absent()
              : Value(duration),
      xpReward: Value(xpReward),
      lpReward: Value(lpReward),
      goldReward: Value(goldReward),
      isDaily: Value(isDaily),
      isCompleted: Value(isCompleted),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Quest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quest(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      sets: serializer.fromJson<int?>(json['sets']),
      reps: serializer.fromJson<int?>(json['reps']),
      duration: serializer.fromJson<int?>(json['duration']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      lpReward: serializer.fromJson<int>(json['lpReward']),
      goldReward: serializer.fromJson<int>(json['goldReward']),
      isDaily: serializer.fromJson<bool>(json['isDaily']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'sets': serializer.toJson<int?>(sets),
      'reps': serializer.toJson<int?>(reps),
      'duration': serializer.toJson<int?>(duration),
      'xpReward': serializer.toJson<int>(xpReward),
      'lpReward': serializer.toJson<int>(lpReward),
      'goldReward': serializer.toJson<int>(goldReward),
      'isDaily': serializer.toJson<bool>(isDaily),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Quest copyWith({
    int? id,
    String? title,
    String? category,
    String? description,
    Value<int?> sets = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    int? xpReward,
    int? lpReward,
    int? goldReward,
    bool? isDaily,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Quest(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    description: description ?? this.description,
    sets: sets.present ? sets.value : this.sets,
    reps: reps.present ? reps.value : this.reps,
    duration: duration.present ? duration.value : this.duration,
    xpReward: xpReward ?? this.xpReward,
    lpReward: lpReward ?? this.lpReward,
    goldReward: goldReward ?? this.goldReward,
    isDaily: isDaily ?? this.isDaily,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Quest copyWithCompanion(QuestsCompanion data) {
    return Quest(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      duration: data.duration.present ? data.duration.value : this.duration,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      lpReward: data.lpReward.present ? data.lpReward.value : this.lpReward,
      goldReward:
          data.goldReward.present ? data.goldReward.value : this.goldReward,
      isDaily: data.isDaily.present ? data.isDaily.value : this.isDaily,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quest(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('xpReward: $xpReward, ')
          ..write('lpReward: $lpReward, ')
          ..write('goldReward: $goldReward, ')
          ..write('isDaily: $isDaily, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    category,
    description,
    sets,
    reps,
    duration,
    xpReward,
    lpReward,
    goldReward,
    isDaily,
    isCompleted,
    completedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quest &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.description == this.description &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.duration == this.duration &&
          other.xpReward == this.xpReward &&
          other.lpReward == this.lpReward &&
          other.goldReward == this.goldReward &&
          other.isDaily == this.isDaily &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class QuestsCompanion extends UpdateCompanion<Quest> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<String> description;
  final Value<int?> sets;
  final Value<int?> reps;
  final Value<int?> duration;
  final Value<int> xpReward;
  final Value<int> lpReward;
  final Value<int> goldReward;
  final Value<bool> isDaily;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  const QuestsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.lpReward = const Value.absent(),
    this.goldReward = const Value.absent(),
    this.isDaily = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuestsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    required String description,
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    required int xpReward,
    this.lpReward = const Value.absent(),
    this.goldReward = const Value.absent(),
    this.isDaily = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       category = Value(category),
       description = Value(description),
       xpReward = Value(xpReward);
  static Insertable<Quest> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<int>? duration,
    Expression<int>? xpReward,
    Expression<int>? lpReward,
    Expression<int>? goldReward,
    Expression<bool>? isDaily,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (duration != null) 'duration': duration,
      if (xpReward != null) 'xp_reward': xpReward,
      if (lpReward != null) 'lp_reward': lpReward,
      if (goldReward != null) 'gold_reward': goldReward,
      if (isDaily != null) 'is_daily': isDaily,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuestsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? category,
    Value<String>? description,
    Value<int?>? sets,
    Value<int?>? reps,
    Value<int?>? duration,
    Value<int>? xpReward,
    Value<int>? lpReward,
    Value<int>? goldReward,
    Value<bool>? isDaily,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
  }) {
    return QuestsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      duration: duration ?? this.duration,
      xpReward: xpReward ?? this.xpReward,
      lpReward: lpReward ?? this.lpReward,
      goldReward: goldReward ?? this.goldReward,
      isDaily: isDaily ?? this.isDaily,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (lpReward.present) {
      map['lp_reward'] = Variable<int>(lpReward.value);
    }
    if (goldReward.present) {
      map['gold_reward'] = Variable<int>(goldReward.value);
    }
    if (isDaily.present) {
      map['is_daily'] = Variable<bool>(isDaily.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('xpReward: $xpReward, ')
          ..write('lpReward: $lpReward, ')
          ..write('goldReward: $goldReward, ')
          ..write('isDaily: $isDaily, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WorkoutLogsTable extends WorkoutLogs
    with TableInfo<$WorkoutLogsTable, WorkoutLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questIdMeta = const VerificationMeta(
    'questId',
  );
  @override
  late final GeneratedColumn<int> questId = GeneratedColumn<int>(
    'quest_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quests (id)',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _healthConnectIdMeta = const VerificationMeta(
    'healthConnectId',
  );
  @override
  late final GeneratedColumn<String> healthConnectId = GeneratedColumn<String>(
    'health_connect_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questId,
    playerId,
    completedAt,
    xpEarned,
    source,
    healthConnectId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quest_id')) {
      context.handle(
        _questIdMeta,
        questId.isAcceptableOrUnknown(data['quest_id']!, _questIdMeta),
      );
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    } else if (isInserting) {
      context.missing(_xpEarnedMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('health_connect_id')) {
      context.handle(
        _healthConnectIdMeta,
        healthConnectId.isAcceptableOrUnknown(
          data['health_connect_id']!,
          _healthConnectIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutLog(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      questId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quest_id'],
      ),
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      completedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}completed_at'],
          )!,
      xpEarned:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp_earned'],
          )!,
      source:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source'],
          )!,
      healthConnectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}health_connect_id'],
      ),
    );
  }

  @override
  $WorkoutLogsTable createAlias(String alias) {
    return $WorkoutLogsTable(attachedDatabase, alias);
  }
}

class WorkoutLog extends DataClass implements Insertable<WorkoutLog> {
  final int id;
  final int? questId;
  final int playerId;
  final DateTime completedAt;
  final int xpEarned;
  final String source;
  final String? healthConnectId;
  const WorkoutLog({
    required this.id,
    this.questId,
    required this.playerId,
    required this.completedAt,
    required this.xpEarned,
    required this.source,
    this.healthConnectId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || questId != null) {
      map['quest_id'] = Variable<int>(questId);
    }
    map['player_id'] = Variable<int>(playerId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['xp_earned'] = Variable<int>(xpEarned);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || healthConnectId != null) {
      map['health_connect_id'] = Variable<String>(healthConnectId);
    }
    return map;
  }

  WorkoutLogsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutLogsCompanion(
      id: Value(id),
      questId:
          questId == null && nullToAbsent
              ? const Value.absent()
              : Value(questId),
      playerId: Value(playerId),
      completedAt: Value(completedAt),
      xpEarned: Value(xpEarned),
      source: Value(source),
      healthConnectId:
          healthConnectId == null && nullToAbsent
              ? const Value.absent()
              : Value(healthConnectId),
    );
  }

  factory WorkoutLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutLog(
      id: serializer.fromJson<int>(json['id']),
      questId: serializer.fromJson<int?>(json['questId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
      source: serializer.fromJson<String>(json['source']),
      healthConnectId: serializer.fromJson<String?>(json['healthConnectId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questId': serializer.toJson<int?>(questId),
      'playerId': serializer.toJson<int>(playerId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'xpEarned': serializer.toJson<int>(xpEarned),
      'source': serializer.toJson<String>(source),
      'healthConnectId': serializer.toJson<String?>(healthConnectId),
    };
  }

  WorkoutLog copyWith({
    int? id,
    Value<int?> questId = const Value.absent(),
    int? playerId,
    DateTime? completedAt,
    int? xpEarned,
    String? source,
    Value<String?> healthConnectId = const Value.absent(),
  }) => WorkoutLog(
    id: id ?? this.id,
    questId: questId.present ? questId.value : this.questId,
    playerId: playerId ?? this.playerId,
    completedAt: completedAt ?? this.completedAt,
    xpEarned: xpEarned ?? this.xpEarned,
    source: source ?? this.source,
    healthConnectId:
        healthConnectId.present ? healthConnectId.value : this.healthConnectId,
  );
  WorkoutLog copyWithCompanion(WorkoutLogsCompanion data) {
    return WorkoutLog(
      id: data.id.present ? data.id.value : this.id,
      questId: data.questId.present ? data.questId.value : this.questId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      source: data.source.present ? data.source.value : this.source,
      healthConnectId:
          data.healthConnectId.present
              ? data.healthConnectId.value
              : this.healthConnectId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLog(')
          ..write('id: $id, ')
          ..write('questId: $questId, ')
          ..write('playerId: $playerId, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('source: $source, ')
          ..write('healthConnectId: $healthConnectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    questId,
    playerId,
    completedAt,
    xpEarned,
    source,
    healthConnectId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutLog &&
          other.id == this.id &&
          other.questId == this.questId &&
          other.playerId == this.playerId &&
          other.completedAt == this.completedAt &&
          other.xpEarned == this.xpEarned &&
          other.source == this.source &&
          other.healthConnectId == this.healthConnectId);
}

class WorkoutLogsCompanion extends UpdateCompanion<WorkoutLog> {
  final Value<int> id;
  final Value<int?> questId;
  final Value<int> playerId;
  final Value<DateTime> completedAt;
  final Value<int> xpEarned;
  final Value<String> source;
  final Value<String?> healthConnectId;
  const WorkoutLogsCompanion({
    this.id = const Value.absent(),
    this.questId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.source = const Value.absent(),
    this.healthConnectId = const Value.absent(),
  });
  WorkoutLogsCompanion.insert({
    this.id = const Value.absent(),
    this.questId = const Value.absent(),
    required int playerId,
    required DateTime completedAt,
    required int xpEarned,
    this.source = const Value.absent(),
    this.healthConnectId = const Value.absent(),
  }) : playerId = Value(playerId),
       completedAt = Value(completedAt),
       xpEarned = Value(xpEarned);
  static Insertable<WorkoutLog> custom({
    Expression<int>? id,
    Expression<int>? questId,
    Expression<int>? playerId,
    Expression<DateTime>? completedAt,
    Expression<int>? xpEarned,
    Expression<String>? source,
    Expression<String>? healthConnectId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questId != null) 'quest_id': questId,
      if (playerId != null) 'player_id': playerId,
      if (completedAt != null) 'completed_at': completedAt,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (source != null) 'source': source,
      if (healthConnectId != null) 'health_connect_id': healthConnectId,
    });
  }

  WorkoutLogsCompanion copyWith({
    Value<int>? id,
    Value<int?>? questId,
    Value<int>? playerId,
    Value<DateTime>? completedAt,
    Value<int>? xpEarned,
    Value<String>? source,
    Value<String?>? healthConnectId,
  }) {
    return WorkoutLogsCompanion(
      id: id ?? this.id,
      questId: questId ?? this.questId,
      playerId: playerId ?? this.playerId,
      completedAt: completedAt ?? this.completedAt,
      xpEarned: xpEarned ?? this.xpEarned,
      source: source ?? this.source,
      healthConnectId: healthConnectId ?? this.healthConnectId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questId.present) {
      map['quest_id'] = Variable<int>(questId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (healthConnectId.present) {
      map['health_connect_id'] = Variable<String>(healthConnectId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLogsCompanion(')
          ..write('id: $id, ')
          ..write('questId: $questId, ')
          ..write('playerId: $playerId, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('source: $source, ')
          ..write('healthConnectId: $healthConnectId')
          ..write(')'))
        .toString();
  }
}

class $StreaksTable extends Streaks with TableInfo<$StreaksTable, Streak> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreaksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta(
    'lastActiveDate',
  );
  @override
  late final GeneratedColumn<String> lastActiveDate = GeneratedColumn<String>(
    'last_active_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    currentStreak,
    longestStreak,
    lastActiveDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streaks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Streak> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('last_active_date')) {
      context.handle(
        _lastActiveDateMeta,
        lastActiveDate.isAcceptableOrUnknown(
          data['last_active_date']!,
          _lastActiveDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Streak map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Streak(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      currentStreak:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}current_streak'],
          )!,
      longestStreak:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}longest_streak'],
          )!,
      lastActiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_active_date'],
      ),
    );
  }

  @override
  $StreaksTable createAlias(String alias) {
    return $StreaksTable(attachedDatabase, alias);
  }
}

class Streak extends DataClass implements Insertable<Streak> {
  final int id;
  final int playerId;
  final int currentStreak;
  final int longestStreak;
  final String? lastActiveDate;
  const Streak({
    required this.id,
    required this.playerId,
    required this.currentStreak,
    required this.longestStreak,
    this.lastActiveDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastActiveDate != null) {
      map['last_active_date'] = Variable<String>(lastActiveDate);
    }
    return map;
  }

  StreaksCompanion toCompanion(bool nullToAbsent) {
    return StreaksCompanion(
      id: Value(id),
      playerId: Value(playerId),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastActiveDate:
          lastActiveDate == null && nullToAbsent
              ? const Value.absent()
              : Value(lastActiveDate),
    );
  }

  factory Streak.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Streak(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastActiveDate: serializer.fromJson<String?>(json['lastActiveDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastActiveDate': serializer.toJson<String?>(lastActiveDate),
    };
  }

  Streak copyWith({
    int? id,
    int? playerId,
    int? currentStreak,
    int? longestStreak,
    Value<String?> lastActiveDate = const Value.absent(),
  }) => Streak(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    lastActiveDate:
        lastActiveDate.present ? lastActiveDate.value : this.lastActiveDate,
  );
  Streak copyWithCompanion(StreaksCompanion data) {
    return Streak(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      currentStreak:
          data.currentStreak.present
              ? data.currentStreak.value
              : this.currentStreak,
      longestStreak:
          data.longestStreak.present
              ? data.longestStreak.value
              : this.longestStreak,
      lastActiveDate:
          data.lastActiveDate.present
              ? data.lastActiveDate.value
              : this.lastActiveDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Streak(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playerId, currentStreak, longestStreak, lastActiveDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Streak &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastActiveDate == this.lastActiveDate);
}

class StreaksCompanion extends UpdateCompanion<Streak> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<String?> lastActiveDate;
  const StreaksCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
  });
  StreaksCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
  }) : playerId = Value(playerId);
  static Insertable<Streak> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<String>? lastActiveDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
    });
  }

  StreaksCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<String?>? lastActiveDate,
  }) {
    return StreaksCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<String>(lastActiveDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreaksCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate')
          ..write(')'))
        .toString();
  }
}

class $RankHistoryTable extends RankHistory
    with TableInfo<$RankHistoryTable, RankHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RankHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, playerId, rank, achievedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rank_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<RankHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RankHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RankHistoryData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      rank:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rank'],
          )!,
      achievedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}achieved_at'],
          )!,
    );
  }

  @override
  $RankHistoryTable createAlias(String alias) {
    return $RankHistoryTable(attachedDatabase, alias);
  }
}

class RankHistoryData extends DataClass implements Insertable<RankHistoryData> {
  final int id;
  final int playerId;
  final String rank;
  final DateTime achievedAt;
  const RankHistoryData({
    required this.id,
    required this.playerId,
    required this.rank,
    required this.achievedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['rank'] = Variable<String>(rank);
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    return map;
  }

  RankHistoryCompanion toCompanion(bool nullToAbsent) {
    return RankHistoryCompanion(
      id: Value(id),
      playerId: Value(playerId),
      rank: Value(rank),
      achievedAt: Value(achievedAt),
    );
  }

  factory RankHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RankHistoryData(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      rank: serializer.fromJson<String>(json['rank']),
      achievedAt: serializer.fromJson<DateTime>(json['achievedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'rank': serializer.toJson<String>(rank),
      'achievedAt': serializer.toJson<DateTime>(achievedAt),
    };
  }

  RankHistoryData copyWith({
    int? id,
    int? playerId,
    String? rank,
    DateTime? achievedAt,
  }) => RankHistoryData(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    rank: rank ?? this.rank,
    achievedAt: achievedAt ?? this.achievedAt,
  );
  RankHistoryData copyWithCompanion(RankHistoryCompanion data) {
    return RankHistoryData(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      rank: data.rank.present ? data.rank.value : this.rank,
      achievedAt:
          data.achievedAt.present ? data.achievedAt.value : this.achievedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RankHistoryData(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('rank: $rank, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, rank, achievedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RankHistoryData &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.rank == this.rank &&
          other.achievedAt == this.achievedAt);
}

class RankHistoryCompanion extends UpdateCompanion<RankHistoryData> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> rank;
  final Value<DateTime> achievedAt;
  const RankHistoryCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.rank = const Value.absent(),
    this.achievedAt = const Value.absent(),
  });
  RankHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String rank,
    this.achievedAt = const Value.absent(),
  }) : playerId = Value(playerId),
       rank = Value(rank);
  static Insertable<RankHistoryData> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? rank,
    Expression<DateTime>? achievedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (rank != null) 'rank': rank,
      if (achievedAt != null) 'achieved_at': achievedAt,
    });
  }

  RankHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? rank,
    Value<DateTime>? achievedAt,
  }) {
    return RankHistoryCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      rank: rank ?? this.rank,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RankHistoryCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('rank: $rank, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }
}

class $EquipmentTable extends Equipment
    with TableInfo<$EquipmentTable, EquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('common'),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOwnedMeta = const VerificationMeta(
    'isOwned',
  );
  @override
  late final GeneratedColumn<bool> isOwned = GeneratedColumn<bool>(
    'is_owned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_owned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    description,
    rarity,
    imagePath,
    category,
    isOwned,
    price,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_owned')) {
      context.handle(
        _isOwnedMeta,
        isOwned.isAcceptableOrUnknown(data['is_owned']!, _isOwnedMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      rarity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rarity'],
          )!,
      imagePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_path'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      isOwned:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_owned'],
          )!,
      price:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}price'],
          )!,
    );
  }

  @override
  $EquipmentTable createAlias(String alias) {
    return $EquipmentTable(attachedDatabase, alias);
  }
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final int id;

  /// Unique slug key (e.g. 'dusted_longsword')
  final String key;
  final String name;
  final String description;

  /// Rarity: common, rare, epic, legendary
  final String rarity;

  /// Path to asset image (e.g. 'assets/images/dusted_longsword.webp')
  final String imagePath;

  /// Primary exercise category this weapon maps to
  final String category;

  /// Whether the player owns this weapon
  final bool isOwned;

  /// Price in gold (0 = starter/free)
  final int price;
  const EquipmentData({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    required this.rarity,
    required this.imagePath,
    required this.category,
    required this.isOwned,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['rarity'] = Variable<String>(rarity);
    map['image_path'] = Variable<String>(imagePath);
    map['category'] = Variable<String>(category);
    map['is_owned'] = Variable<bool>(isOwned);
    map['price'] = Variable<int>(price);
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      description: Value(description),
      rarity: Value(rarity),
      imagePath: Value(imagePath),
      category: Value(category),
      isOwned: Value(isOwned),
      price: Value(price),
    );
  }

  factory EquipmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      rarity: serializer.fromJson<String>(json['rarity']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      category: serializer.fromJson<String>(json['category']),
      isOwned: serializer.fromJson<bool>(json['isOwned']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'rarity': serializer.toJson<String>(rarity),
      'imagePath': serializer.toJson<String>(imagePath),
      'category': serializer.toJson<String>(category),
      'isOwned': serializer.toJson<bool>(isOwned),
      'price': serializer.toJson<int>(price),
    };
  }

  EquipmentData copyWith({
    int? id,
    String? key,
    String? name,
    String? description,
    String? rarity,
    String? imagePath,
    String? category,
    bool? isOwned,
    int? price,
  }) => EquipmentData(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    description: description ?? this.description,
    rarity: rarity ?? this.rarity,
    imagePath: imagePath ?? this.imagePath,
    category: category ?? this.category,
    isOwned: isOwned ?? this.isOwned,
    price: price ?? this.price,
  );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      category: data.category.present ? data.category.value : this.category,
      isOwned: data.isOwned.present ? data.isOwned.value : this.isOwned,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rarity: $rarity, ')
          ..write('imagePath: $imagePath, ')
          ..write('category: $category, ')
          ..write('isOwned: $isOwned, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    name,
    description,
    rarity,
    imagePath,
    category,
    isOwned,
    price,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.description == this.description &&
          other.rarity == this.rarity &&
          other.imagePath == this.imagePath &&
          other.category == this.category &&
          other.isOwned == this.isOwned &&
          other.price == this.price);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> name;
  final Value<String> description;
  final Value<String> rarity;
  final Value<String> imagePath;
  final Value<String> category;
  final Value<bool> isOwned;
  final Value<int> price;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rarity = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.category = const Value.absent(),
    this.isOwned = const Value.absent(),
    this.price = const Value.absent(),
  });
  EquipmentCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String name,
    required String description,
    this.rarity = const Value.absent(),
    required String imagePath,
    required String category,
    this.isOwned = const Value.absent(),
    this.price = const Value.absent(),
  }) : key = Value(key),
       name = Value(name),
       description = Value(description),
       imagePath = Value(imagePath),
       category = Value(category);
  static Insertable<EquipmentData> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? rarity,
    Expression<String>? imagePath,
    Expression<String>? category,
    Expression<bool>? isOwned,
    Expression<int>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rarity != null) 'rarity': rarity,
      if (imagePath != null) 'image_path': imagePath,
      if (category != null) 'category': category,
      if (isOwned != null) 'is_owned': isOwned,
      if (price != null) 'price': price,
    });
  }

  EquipmentCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? name,
    Value<String>? description,
    Value<String>? rarity,
    Value<String>? imagePath,
    Value<String>? category,
    Value<bool>? isOwned,
    Value<int>? price,
  }) {
    return EquipmentCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      rarity: rarity ?? this.rarity,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      isOwned: isOwned ?? this.isOwned,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isOwned.present) {
      map['is_owned'] = Variable<bool>(isOwned.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rarity: $rarity, ')
          ..write('imagePath: $imagePath, ')
          ..write('category: $category, ')
          ..write('isOwned: $isOwned, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $EquipmentExercisesTable extends EquipmentExercises
    with TableInfo<$EquipmentExercisesTable, EquipmentExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _equipmentIdMeta = const VerificationMeta(
    'equipmentId',
  );
  @override
  late final GeneratedColumn<int> equipmentId = GeneratedColumn<int>(
    'equipment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES equipment (id)',
    ),
  );
  static const VerificationMeta _exerciseTitleMeta = const VerificationMeta(
    'exerciseTitle',
  );
  @override
  late final GeneratedColumn<String> exerciseTitle = GeneratedColumn<String>(
    'exercise_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseCategoryMeta = const VerificationMeta(
    'exerciseCategory',
  );
  @override
  late final GeneratedColumn<String> exerciseCategory = GeneratedColumn<String>(
    'exercise_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baseXpMeta = const VerificationMeta('baseXp');
  @override
  late final GeneratedColumn<int> baseXp = GeneratedColumn<int>(
    'base_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('⚔️'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    equipmentId,
    exerciseTitle,
    exerciseCategory,
    sets,
    reps,
    duration,
    baseXp,
    emoji,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
        _equipmentIdMeta,
        equipmentId.isAcceptableOrUnknown(
          data['equipment_id']!,
          _equipmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentIdMeta);
    }
    if (data.containsKey('exercise_title')) {
      context.handle(
        _exerciseTitleMeta,
        exerciseTitle.isAcceptableOrUnknown(
          data['exercise_title']!,
          _exerciseTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseTitleMeta);
    }
    if (data.containsKey('exercise_category')) {
      context.handle(
        _exerciseCategoryMeta,
        exerciseCategory.isAcceptableOrUnknown(
          data['exercise_category']!,
          _exerciseCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseCategoryMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('base_xp')) {
      context.handle(
        _baseXpMeta,
        baseXp.isAcceptableOrUnknown(data['base_xp']!, _baseXpMeta),
      );
    } else if (isInserting) {
      context.missing(_baseXpMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentExercise(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      equipmentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}equipment_id'],
          )!,
      exerciseTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}exercise_title'],
          )!,
      exerciseCategory:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}exercise_category'],
          )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      baseXp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}base_xp'],
          )!,
      emoji:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}emoji'],
          )!,
    );
  }

  @override
  $EquipmentExercisesTable createAlias(String alias) {
    return $EquipmentExercisesTable(attachedDatabase, alias);
  }
}

class EquipmentExercise extends DataClass
    implements Insertable<EquipmentExercise> {
  final int id;
  final int equipmentId;
  final String exerciseTitle;
  final String exerciseCategory;
  final int? sets;
  final int? reps;
  final int? duration;
  final int baseXp;
  final String emoji;
  const EquipmentExercise({
    required this.id,
    required this.equipmentId,
    required this.exerciseTitle,
    required this.exerciseCategory,
    this.sets,
    this.reps,
    this.duration,
    required this.baseXp,
    required this.emoji,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipment_id'] = Variable<int>(equipmentId);
    map['exercise_title'] = Variable<String>(exerciseTitle);
    map['exercise_category'] = Variable<String>(exerciseCategory);
    if (!nullToAbsent || sets != null) {
      map['sets'] = Variable<int>(sets);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    map['base_xp'] = Variable<int>(baseXp);
    map['emoji'] = Variable<String>(emoji);
    return map;
  }

  EquipmentExercisesCompanion toCompanion(bool nullToAbsent) {
    return EquipmentExercisesCompanion(
      id: Value(id),
      equipmentId: Value(equipmentId),
      exerciseTitle: Value(exerciseTitle),
      exerciseCategory: Value(exerciseCategory),
      sets: sets == null && nullToAbsent ? const Value.absent() : Value(sets),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      duration:
          duration == null && nullToAbsent
              ? const Value.absent()
              : Value(duration),
      baseXp: Value(baseXp),
      emoji: Value(emoji),
    );
  }

  factory EquipmentExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentExercise(
      id: serializer.fromJson<int>(json['id']),
      equipmentId: serializer.fromJson<int>(json['equipmentId']),
      exerciseTitle: serializer.fromJson<String>(json['exerciseTitle']),
      exerciseCategory: serializer.fromJson<String>(json['exerciseCategory']),
      sets: serializer.fromJson<int?>(json['sets']),
      reps: serializer.fromJson<int?>(json['reps']),
      duration: serializer.fromJson<int?>(json['duration']),
      baseXp: serializer.fromJson<int>(json['baseXp']),
      emoji: serializer.fromJson<String>(json['emoji']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipmentId': serializer.toJson<int>(equipmentId),
      'exerciseTitle': serializer.toJson<String>(exerciseTitle),
      'exerciseCategory': serializer.toJson<String>(exerciseCategory),
      'sets': serializer.toJson<int?>(sets),
      'reps': serializer.toJson<int?>(reps),
      'duration': serializer.toJson<int?>(duration),
      'baseXp': serializer.toJson<int>(baseXp),
      'emoji': serializer.toJson<String>(emoji),
    };
  }

  EquipmentExercise copyWith({
    int? id,
    int? equipmentId,
    String? exerciseTitle,
    String? exerciseCategory,
    Value<int?> sets = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    int? baseXp,
    String? emoji,
  }) => EquipmentExercise(
    id: id ?? this.id,
    equipmentId: equipmentId ?? this.equipmentId,
    exerciseTitle: exerciseTitle ?? this.exerciseTitle,
    exerciseCategory: exerciseCategory ?? this.exerciseCategory,
    sets: sets.present ? sets.value : this.sets,
    reps: reps.present ? reps.value : this.reps,
    duration: duration.present ? duration.value : this.duration,
    baseXp: baseXp ?? this.baseXp,
    emoji: emoji ?? this.emoji,
  );
  EquipmentExercise copyWithCompanion(EquipmentExercisesCompanion data) {
    return EquipmentExercise(
      id: data.id.present ? data.id.value : this.id,
      equipmentId:
          data.equipmentId.present ? data.equipmentId.value : this.equipmentId,
      exerciseTitle:
          data.exerciseTitle.present
              ? data.exerciseTitle.value
              : this.exerciseTitle,
      exerciseCategory:
          data.exerciseCategory.present
              ? data.exerciseCategory.value
              : this.exerciseCategory,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      duration: data.duration.present ? data.duration.value : this.duration,
      baseXp: data.baseXp.present ? data.baseXp.value : this.baseXp,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentExercise(')
          ..write('id: $id, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('exerciseTitle: $exerciseTitle, ')
          ..write('exerciseCategory: $exerciseCategory, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('baseXp: $baseXp, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    equipmentId,
    exerciseTitle,
    exerciseCategory,
    sets,
    reps,
    duration,
    baseXp,
    emoji,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentExercise &&
          other.id == this.id &&
          other.equipmentId == this.equipmentId &&
          other.exerciseTitle == this.exerciseTitle &&
          other.exerciseCategory == this.exerciseCategory &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.duration == this.duration &&
          other.baseXp == this.baseXp &&
          other.emoji == this.emoji);
}

class EquipmentExercisesCompanion extends UpdateCompanion<EquipmentExercise> {
  final Value<int> id;
  final Value<int> equipmentId;
  final Value<String> exerciseTitle;
  final Value<String> exerciseCategory;
  final Value<int?> sets;
  final Value<int?> reps;
  final Value<int?> duration;
  final Value<int> baseXp;
  final Value<String> emoji;
  const EquipmentExercisesCompanion({
    this.id = const Value.absent(),
    this.equipmentId = const Value.absent(),
    this.exerciseTitle = const Value.absent(),
    this.exerciseCategory = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    this.baseXp = const Value.absent(),
    this.emoji = const Value.absent(),
  });
  EquipmentExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int equipmentId,
    required String exerciseTitle,
    required String exerciseCategory,
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    required int baseXp,
    this.emoji = const Value.absent(),
  }) : equipmentId = Value(equipmentId),
       exerciseTitle = Value(exerciseTitle),
       exerciseCategory = Value(exerciseCategory),
       baseXp = Value(baseXp);
  static Insertable<EquipmentExercise> custom({
    Expression<int>? id,
    Expression<int>? equipmentId,
    Expression<String>? exerciseTitle,
    Expression<String>? exerciseCategory,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<int>? duration,
    Expression<int>? baseXp,
    Expression<String>? emoji,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipmentId != null) 'equipment_id': equipmentId,
      if (exerciseTitle != null) 'exercise_title': exerciseTitle,
      if (exerciseCategory != null) 'exercise_category': exerciseCategory,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (duration != null) 'duration': duration,
      if (baseXp != null) 'base_xp': baseXp,
      if (emoji != null) 'emoji': emoji,
    });
  }

  EquipmentExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? equipmentId,
    Value<String>? exerciseTitle,
    Value<String>? exerciseCategory,
    Value<int?>? sets,
    Value<int?>? reps,
    Value<int?>? duration,
    Value<int>? baseXp,
    Value<String>? emoji,
  }) {
    return EquipmentExercisesCompanion(
      id: id ?? this.id,
      equipmentId: equipmentId ?? this.equipmentId,
      exerciseTitle: exerciseTitle ?? this.exerciseTitle,
      exerciseCategory: exerciseCategory ?? this.exerciseCategory,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      duration: duration ?? this.duration,
      baseXp: baseXp ?? this.baseXp,
      emoji: emoji ?? this.emoji,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<int>(equipmentId.value);
    }
    if (exerciseTitle.present) {
      map['exercise_title'] = Variable<String>(exerciseTitle.value);
    }
    if (exerciseCategory.present) {
      map['exercise_category'] = Variable<String>(exerciseCategory.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (baseXp.present) {
      map['base_xp'] = Variable<int>(baseXp.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentExercisesCompanion(')
          ..write('id: $id, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('exerciseTitle: $exerciseTitle, ')
          ..write('exerciseCategory: $exerciseCategory, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('baseXp: $baseXp, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }
}

class $EquippedSlotsTable extends EquippedSlots
    with TableInfo<$EquippedSlotsTable, EquippedSlot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquippedSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _slotIndexMeta = const VerificationMeta(
    'slotIndex',
  );
  @override
  late final GeneratedColumn<int> slotIndex = GeneratedColumn<int>(
    'slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentIdMeta = const VerificationMeta(
    'equipmentId',
  );
  @override
  late final GeneratedColumn<int> equipmentId = GeneratedColumn<int>(
    'equipment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES equipment (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, playerId, slotIndex, equipmentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipped_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquippedSlot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('slot_index')) {
      context.handle(
        _slotIndexMeta,
        slotIndex.isAcceptableOrUnknown(data['slot_index']!, _slotIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIndexMeta);
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
        _equipmentIdMeta,
        equipmentId.isAcceptableOrUnknown(
          data['equipment_id']!,
          _equipmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquippedSlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquippedSlot(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      slotIndex:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}slot_index'],
          )!,
      equipmentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}equipment_id'],
          )!,
    );
  }

  @override
  $EquippedSlotsTable createAlias(String alias) {
    return $EquippedSlotsTable(attachedDatabase, alias);
  }
}

class EquippedSlot extends DataClass implements Insertable<EquippedSlot> {
  final int id;
  final int playerId;

  /// Slot index: 1, 2, or 3
  final int slotIndex;
  final int equipmentId;
  const EquippedSlot({
    required this.id,
    required this.playerId,
    required this.slotIndex,
    required this.equipmentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['slot_index'] = Variable<int>(slotIndex);
    map['equipment_id'] = Variable<int>(equipmentId);
    return map;
  }

  EquippedSlotsCompanion toCompanion(bool nullToAbsent) {
    return EquippedSlotsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      slotIndex: Value(slotIndex),
      equipmentId: Value(equipmentId),
    );
  }

  factory EquippedSlot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquippedSlot(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      slotIndex: serializer.fromJson<int>(json['slotIndex']),
      equipmentId: serializer.fromJson<int>(json['equipmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'slotIndex': serializer.toJson<int>(slotIndex),
      'equipmentId': serializer.toJson<int>(equipmentId),
    };
  }

  EquippedSlot copyWith({
    int? id,
    int? playerId,
    int? slotIndex,
    int? equipmentId,
  }) => EquippedSlot(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    slotIndex: slotIndex ?? this.slotIndex,
    equipmentId: equipmentId ?? this.equipmentId,
  );
  EquippedSlot copyWithCompanion(EquippedSlotsCompanion data) {
    return EquippedSlot(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      slotIndex: data.slotIndex.present ? data.slotIndex.value : this.slotIndex,
      equipmentId:
          data.equipmentId.present ? data.equipmentId.value : this.equipmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquippedSlot(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('equipmentId: $equipmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, slotIndex, equipmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquippedSlot &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.slotIndex == this.slotIndex &&
          other.equipmentId == this.equipmentId);
}

class EquippedSlotsCompanion extends UpdateCompanion<EquippedSlot> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> slotIndex;
  final Value<int> equipmentId;
  const EquippedSlotsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.slotIndex = const Value.absent(),
    this.equipmentId = const Value.absent(),
  });
  EquippedSlotsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required int slotIndex,
    required int equipmentId,
  }) : playerId = Value(playerId),
       slotIndex = Value(slotIndex),
       equipmentId = Value(equipmentId);
  static Insertable<EquippedSlot> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? slotIndex,
    Expression<int>? equipmentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (slotIndex != null) 'slot_index': slotIndex,
      if (equipmentId != null) 'equipment_id': equipmentId,
    });
  }

  EquippedSlotsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<int>? slotIndex,
    Value<int>? equipmentId,
  }) {
    return EquippedSlotsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      slotIndex: slotIndex ?? this.slotIndex,
      equipmentId: equipmentId ?? this.equipmentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (slotIndex.present) {
      map['slot_index'] = Variable<int>(slotIndex.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<int>(equipmentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquippedSlotsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('equipmentId: $equipmentId')
          ..write(')'))
        .toString();
  }
}

class $InventoryTable extends Inventory
    with TableInfo<$InventoryTable, InventoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _itemKeyMeta = const VerificationMeta(
    'itemKey',
  );
  @override
  late final GeneratedColumn<String> itemKey = GeneratedColumn<String>(
    'item_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, playerId, itemKey, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('item_key')) {
      context.handle(
        _itemKeyMeta,
        itemKey.isAcceptableOrUnknown(data['item_key']!, _itemKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_itemKeyMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      itemKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}item_key'],
          )!,
      quantity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}quantity'],
          )!,
    );
  }

  @override
  $InventoryTable createAlias(String alias) {
    return $InventoryTable(attachedDatabase, alias);
  }
}

class InventoryData extends DataClass implements Insertable<InventoryData> {
  final int id;
  final int playerId;

  /// Item key: 'streak_insurance', 'quest_reroll'
  final String itemKey;
  final int quantity;
  const InventoryData({
    required this.id,
    required this.playerId,
    required this.itemKey,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['item_key'] = Variable<String>(itemKey);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  InventoryCompanion toCompanion(bool nullToAbsent) {
    return InventoryCompanion(
      id: Value(id),
      playerId: Value(playerId),
      itemKey: Value(itemKey),
      quantity: Value(quantity),
    );
  }

  factory InventoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryData(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      itemKey: serializer.fromJson<String>(json['itemKey']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'itemKey': serializer.toJson<String>(itemKey),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  InventoryData copyWith({
    int? id,
    int? playerId,
    String? itemKey,
    int? quantity,
  }) => InventoryData(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    itemKey: itemKey ?? this.itemKey,
    quantity: quantity ?? this.quantity,
  );
  InventoryData copyWithCompanion(InventoryCompanion data) {
    return InventoryData(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      itemKey: data.itemKey.present ? data.itemKey.value : this.itemKey,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryData(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('itemKey: $itemKey, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, itemKey, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryData &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.itemKey == this.itemKey &&
          other.quantity == this.quantity);
}

class InventoryCompanion extends UpdateCompanion<InventoryData> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> itemKey;
  final Value<int> quantity;
  const InventoryCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.itemKey = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  InventoryCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String itemKey,
    this.quantity = const Value.absent(),
  }) : playerId = Value(playerId),
       itemKey = Value(itemKey);
  static Insertable<InventoryData> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? itemKey,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (itemKey != null) 'item_key': itemKey,
      if (quantity != null) 'quantity': quantity,
    });
  }

  InventoryCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? itemKey,
    Value<int>? quantity,
  }) {
    return InventoryCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      itemKey: itemKey ?? this.itemKey,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (itemKey.present) {
      map['item_key'] = Variable<String>(itemKey.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('itemKey: $itemKey, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $RankTrialsTable extends RankTrials
    with TableInfo<$RankTrialsTable, RankTrial> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RankTrialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _targetRankMeta = const VerificationMeta(
    'targetRank',
  );
  @override
  late final GeneratedColumn<String> targetRank = GeneratedColumn<String>(
    'target_rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trialTypeMeta = const VerificationMeta(
    'trialType',
  );
  @override
  late final GeneratedColumn<String> trialType = GeneratedColumn<String>(
    'trial_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _streakDaysCompletedMeta =
      const VerificationMeta('streakDaysCompleted');
  @override
  late final GeneratedColumn<int> streakDaysCompleted = GeneratedColumn<int>(
    'streak_days_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _requiredStreakDaysMeta =
      const VerificationMeta('requiredStreakDays');
  @override
  late final GeneratedColumn<int> requiredStreakDays = GeneratedColumn<int>(
    'required_streak_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _calorieGoalMeta = const VerificationMeta(
    'calorieGoal',
  );
  @override
  late final GeneratedColumn<int> calorieGoal = GeneratedColumn<int>(
    'calorie_goal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepGoalMeta = const VerificationMeta(
    'stepGoal',
  );
  @override
  late final GeneratedColumn<int> stepGoal = GeneratedColumn<int>(
    'step_goal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesAchievedMeta = const VerificationMeta(
    'caloriesAchieved',
  );
  @override
  late final GeneratedColumn<int> caloriesAchieved = GeneratedColumn<int>(
    'calories_achieved',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stepsAchievedMeta = const VerificationMeta(
    'stepsAchieved',
  );
  @override
  late final GeneratedColumn<int> stepsAchieved = GeneratedColumn<int>(
    'steps_achieved',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    targetRank,
    trialType,
    startedAt,
    completedAt,
    status,
    streakDaysCompleted,
    requiredStreakDays,
    calorieGoal,
    stepGoal,
    caloriesAchieved,
    stepsAchieved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rank_trials';
  @override
  VerificationContext validateIntegrity(
    Insertable<RankTrial> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('target_rank')) {
      context.handle(
        _targetRankMeta,
        targetRank.isAcceptableOrUnknown(data['target_rank']!, _targetRankMeta),
      );
    } else if (isInserting) {
      context.missing(_targetRankMeta);
    }
    if (data.containsKey('trial_type')) {
      context.handle(
        _trialTypeMeta,
        trialType.isAcceptableOrUnknown(data['trial_type']!, _trialTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_trialTypeMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('streak_days_completed')) {
      context.handle(
        _streakDaysCompletedMeta,
        streakDaysCompleted.isAcceptableOrUnknown(
          data['streak_days_completed']!,
          _streakDaysCompletedMeta,
        ),
      );
    }
    if (data.containsKey('required_streak_days')) {
      context.handle(
        _requiredStreakDaysMeta,
        requiredStreakDays.isAcceptableOrUnknown(
          data['required_streak_days']!,
          _requiredStreakDaysMeta,
        ),
      );
    }
    if (data.containsKey('calorie_goal')) {
      context.handle(
        _calorieGoalMeta,
        calorieGoal.isAcceptableOrUnknown(
          data['calorie_goal']!,
          _calorieGoalMeta,
        ),
      );
    }
    if (data.containsKey('step_goal')) {
      context.handle(
        _stepGoalMeta,
        stepGoal.isAcceptableOrUnknown(data['step_goal']!, _stepGoalMeta),
      );
    }
    if (data.containsKey('calories_achieved')) {
      context.handle(
        _caloriesAchievedMeta,
        caloriesAchieved.isAcceptableOrUnknown(
          data['calories_achieved']!,
          _caloriesAchievedMeta,
        ),
      );
    }
    if (data.containsKey('steps_achieved')) {
      context.handle(
        _stepsAchievedMeta,
        stepsAchieved.isAcceptableOrUnknown(
          data['steps_achieved']!,
          _stepsAchievedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RankTrial map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RankTrial(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      targetRank:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}target_rank'],
          )!,
      trialType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trial_type'],
          )!,
      startedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}started_at'],
          )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      streakDaysCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}streak_days_completed'],
          )!,
      requiredStreakDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}required_streak_days'],
          )!,
      calorieGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calorie_goal'],
      ),
      stepGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_goal'],
      ),
      caloriesAchieved:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}calories_achieved'],
          )!,
      stepsAchieved:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}steps_achieved'],
          )!,
    );
  }

  @override
  $RankTrialsTable createAlias(String alias) {
    return $RankTrialsTable(attachedDatabase, alias);
  }
}

class RankTrial extends DataClass implements Insertable<RankTrial> {
  final int id;
  final int playerId;

  /// The rank the player is trying to promote into (e.g. 'bronze_1')
  final String targetRank;

  /// Trial type: 'consistency' or 'gatekeeper'
  final String trialType;
  final DateTime startedAt;
  final DateTime? completedAt;

  /// Status: 'active', 'passed', 'failed'
  final String status;
  final int streakDaysCompleted;
  final int requiredStreakDays;
  final int? calorieGoal;
  final int? stepGoal;
  final int caloriesAchieved;
  final int stepsAchieved;
  const RankTrial({
    required this.id,
    required this.playerId,
    required this.targetRank,
    required this.trialType,
    required this.startedAt,
    this.completedAt,
    required this.status,
    required this.streakDaysCompleted,
    required this.requiredStreakDays,
    this.calorieGoal,
    this.stepGoal,
    required this.caloriesAchieved,
    required this.stepsAchieved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['target_rank'] = Variable<String>(targetRank);
    map['trial_type'] = Variable<String>(trialType);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    map['streak_days_completed'] = Variable<int>(streakDaysCompleted);
    map['required_streak_days'] = Variable<int>(requiredStreakDays);
    if (!nullToAbsent || calorieGoal != null) {
      map['calorie_goal'] = Variable<int>(calorieGoal);
    }
    if (!nullToAbsent || stepGoal != null) {
      map['step_goal'] = Variable<int>(stepGoal);
    }
    map['calories_achieved'] = Variable<int>(caloriesAchieved);
    map['steps_achieved'] = Variable<int>(stepsAchieved);
    return map;
  }

  RankTrialsCompanion toCompanion(bool nullToAbsent) {
    return RankTrialsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      targetRank: Value(targetRank),
      trialType: Value(trialType),
      startedAt: Value(startedAt),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
      status: Value(status),
      streakDaysCompleted: Value(streakDaysCompleted),
      requiredStreakDays: Value(requiredStreakDays),
      calorieGoal:
          calorieGoal == null && nullToAbsent
              ? const Value.absent()
              : Value(calorieGoal),
      stepGoal:
          stepGoal == null && nullToAbsent
              ? const Value.absent()
              : Value(stepGoal),
      caloriesAchieved: Value(caloriesAchieved),
      stepsAchieved: Value(stepsAchieved),
    );
  }

  factory RankTrial.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RankTrial(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      targetRank: serializer.fromJson<String>(json['targetRank']),
      trialType: serializer.fromJson<String>(json['trialType']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
      streakDaysCompleted: serializer.fromJson<int>(
        json['streakDaysCompleted'],
      ),
      requiredStreakDays: serializer.fromJson<int>(json['requiredStreakDays']),
      calorieGoal: serializer.fromJson<int?>(json['calorieGoal']),
      stepGoal: serializer.fromJson<int?>(json['stepGoal']),
      caloriesAchieved: serializer.fromJson<int>(json['caloriesAchieved']),
      stepsAchieved: serializer.fromJson<int>(json['stepsAchieved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'targetRank': serializer.toJson<String>(targetRank),
      'trialType': serializer.toJson<String>(trialType),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
      'streakDaysCompleted': serializer.toJson<int>(streakDaysCompleted),
      'requiredStreakDays': serializer.toJson<int>(requiredStreakDays),
      'calorieGoal': serializer.toJson<int?>(calorieGoal),
      'stepGoal': serializer.toJson<int?>(stepGoal),
      'caloriesAchieved': serializer.toJson<int>(caloriesAchieved),
      'stepsAchieved': serializer.toJson<int>(stepsAchieved),
    };
  }

  RankTrial copyWith({
    int? id,
    int? playerId,
    String? targetRank,
    String? trialType,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? status,
    int? streakDaysCompleted,
    int? requiredStreakDays,
    Value<int?> calorieGoal = const Value.absent(),
    Value<int?> stepGoal = const Value.absent(),
    int? caloriesAchieved,
    int? stepsAchieved,
  }) => RankTrial(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    targetRank: targetRank ?? this.targetRank,
    trialType: trialType ?? this.trialType,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
    streakDaysCompleted: streakDaysCompleted ?? this.streakDaysCompleted,
    requiredStreakDays: requiredStreakDays ?? this.requiredStreakDays,
    calorieGoal: calorieGoal.present ? calorieGoal.value : this.calorieGoal,
    stepGoal: stepGoal.present ? stepGoal.value : this.stepGoal,
    caloriesAchieved: caloriesAchieved ?? this.caloriesAchieved,
    stepsAchieved: stepsAchieved ?? this.stepsAchieved,
  );
  RankTrial copyWithCompanion(RankTrialsCompanion data) {
    return RankTrial(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      targetRank:
          data.targetRank.present ? data.targetRank.value : this.targetRank,
      trialType: data.trialType.present ? data.trialType.value : this.trialType,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      streakDaysCompleted:
          data.streakDaysCompleted.present
              ? data.streakDaysCompleted.value
              : this.streakDaysCompleted,
      requiredStreakDays:
          data.requiredStreakDays.present
              ? data.requiredStreakDays.value
              : this.requiredStreakDays,
      calorieGoal:
          data.calorieGoal.present ? data.calorieGoal.value : this.calorieGoal,
      stepGoal: data.stepGoal.present ? data.stepGoal.value : this.stepGoal,
      caloriesAchieved:
          data.caloriesAchieved.present
              ? data.caloriesAchieved.value
              : this.caloriesAchieved,
      stepsAchieved:
          data.stepsAchieved.present
              ? data.stepsAchieved.value
              : this.stepsAchieved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RankTrial(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('targetRank: $targetRank, ')
          ..write('trialType: $trialType, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('streakDaysCompleted: $streakDaysCompleted, ')
          ..write('requiredStreakDays: $requiredStreakDays, ')
          ..write('calorieGoal: $calorieGoal, ')
          ..write('stepGoal: $stepGoal, ')
          ..write('caloriesAchieved: $caloriesAchieved, ')
          ..write('stepsAchieved: $stepsAchieved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    targetRank,
    trialType,
    startedAt,
    completedAt,
    status,
    streakDaysCompleted,
    requiredStreakDays,
    calorieGoal,
    stepGoal,
    caloriesAchieved,
    stepsAchieved,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RankTrial &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.targetRank == this.targetRank &&
          other.trialType == this.trialType &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.streakDaysCompleted == this.streakDaysCompleted &&
          other.requiredStreakDays == this.requiredStreakDays &&
          other.calorieGoal == this.calorieGoal &&
          other.stepGoal == this.stepGoal &&
          other.caloriesAchieved == this.caloriesAchieved &&
          other.stepsAchieved == this.stepsAchieved);
}

class RankTrialsCompanion extends UpdateCompanion<RankTrial> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> targetRank;
  final Value<String> trialType;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  final Value<int> streakDaysCompleted;
  final Value<int> requiredStreakDays;
  final Value<int?> calorieGoal;
  final Value<int?> stepGoal;
  final Value<int> caloriesAchieved;
  final Value<int> stepsAchieved;
  const RankTrialsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.targetRank = const Value.absent(),
    this.trialType = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.streakDaysCompleted = const Value.absent(),
    this.requiredStreakDays = const Value.absent(),
    this.calorieGoal = const Value.absent(),
    this.stepGoal = const Value.absent(),
    this.caloriesAchieved = const Value.absent(),
    this.stepsAchieved = const Value.absent(),
  });
  RankTrialsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String targetRank,
    required String trialType,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.streakDaysCompleted = const Value.absent(),
    this.requiredStreakDays = const Value.absent(),
    this.calorieGoal = const Value.absent(),
    this.stepGoal = const Value.absent(),
    this.caloriesAchieved = const Value.absent(),
    this.stepsAchieved = const Value.absent(),
  }) : playerId = Value(playerId),
       targetRank = Value(targetRank),
       trialType = Value(trialType);
  static Insertable<RankTrial> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? targetRank,
    Expression<String>? trialType,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<int>? streakDaysCompleted,
    Expression<int>? requiredStreakDays,
    Expression<int>? calorieGoal,
    Expression<int>? stepGoal,
    Expression<int>? caloriesAchieved,
    Expression<int>? stepsAchieved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (targetRank != null) 'target_rank': targetRank,
      if (trialType != null) 'trial_type': trialType,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (streakDaysCompleted != null)
        'streak_days_completed': streakDaysCompleted,
      if (requiredStreakDays != null)
        'required_streak_days': requiredStreakDays,
      if (calorieGoal != null) 'calorie_goal': calorieGoal,
      if (stepGoal != null) 'step_goal': stepGoal,
      if (caloriesAchieved != null) 'calories_achieved': caloriesAchieved,
      if (stepsAchieved != null) 'steps_achieved': stepsAchieved,
    });
  }

  RankTrialsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? targetRank,
    Value<String>? trialType,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? status,
    Value<int>? streakDaysCompleted,
    Value<int>? requiredStreakDays,
    Value<int?>? calorieGoal,
    Value<int?>? stepGoal,
    Value<int>? caloriesAchieved,
    Value<int>? stepsAchieved,
  }) {
    return RankTrialsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      targetRank: targetRank ?? this.targetRank,
      trialType: trialType ?? this.trialType,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      streakDaysCompleted: streakDaysCompleted ?? this.streakDaysCompleted,
      requiredStreakDays: requiredStreakDays ?? this.requiredStreakDays,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      stepGoal: stepGoal ?? this.stepGoal,
      caloriesAchieved: caloriesAchieved ?? this.caloriesAchieved,
      stepsAchieved: stepsAchieved ?? this.stepsAchieved,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (targetRank.present) {
      map['target_rank'] = Variable<String>(targetRank.value);
    }
    if (trialType.present) {
      map['trial_type'] = Variable<String>(trialType.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (streakDaysCompleted.present) {
      map['streak_days_completed'] = Variable<int>(streakDaysCompleted.value);
    }
    if (requiredStreakDays.present) {
      map['required_streak_days'] = Variable<int>(requiredStreakDays.value);
    }
    if (calorieGoal.present) {
      map['calorie_goal'] = Variable<int>(calorieGoal.value);
    }
    if (stepGoal.present) {
      map['step_goal'] = Variable<int>(stepGoal.value);
    }
    if (caloriesAchieved.present) {
      map['calories_achieved'] = Variable<int>(caloriesAchieved.value);
    }
    if (stepsAchieved.present) {
      map['steps_achieved'] = Variable<int>(stepsAchieved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RankTrialsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('targetRank: $targetRank, ')
          ..write('trialType: $trialType, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('streakDaysCompleted: $streakDaysCompleted, ')
          ..write('requiredStreakDays: $requiredStreakDays, ')
          ..write('calorieGoal: $calorieGoal, ')
          ..write('stepGoal: $stepGoal, ')
          ..write('caloriesAchieved: $caloriesAchieved, ')
          ..write('stepsAchieved: $stepsAchieved')
          ..write(')'))
        .toString();
  }
}

class $ExerciseDbTable extends ExerciseDb
    with TableInfo<$ExerciseDbTable, ExerciseDbData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseDbTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _forceMeta = const VerificationMeta('force');
  @override
  late final GeneratedColumn<String> force = GeneratedColumn<String>(
    'force',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mechanicMeta = const VerificationMeta(
    'mechanic',
  );
  @override
  late final GeneratedColumn<String> mechanic = GeneratedColumn<String>(
    'mechanic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryMusclesMeta = const VerificationMeta(
    'primaryMuscles',
  );
  @override
  late final GeneratedColumn<String> primaryMuscles = GeneratedColumn<String>(
    'primary_muscles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryMusclesMeta = const VerificationMeta(
    'secondaryMuscles',
  );
  @override
  late final GeneratedColumn<String> secondaryMuscles = GeneratedColumn<String>(
    'secondary_muscles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _imagesMeta = const VerificationMeta('images');
  @override
  late final GeneratedColumn<String> images = GeneratedColumn<String>(
    'images',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    externalId,
    name,
    force,
    level,
    mechanic,
    equipment,
    category,
    instructions,
    primaryMuscles,
    secondaryMuscles,
    images,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_db';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseDbData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_externalIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('force')) {
      context.handle(
        _forceMeta,
        force.isAcceptableOrUnknown(data['force']!, _forceMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('mechanic')) {
      context.handle(
        _mechanicMeta,
        mechanic.isAcceptableOrUnknown(data['mechanic']!, _mechanicMeta),
      );
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('primary_muscles')) {
      context.handle(
        _primaryMusclesMeta,
        primaryMuscles.isAcceptableOrUnknown(
          data['primary_muscles']!,
          _primaryMusclesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMusclesMeta);
    }
    if (data.containsKey('secondary_muscles')) {
      context.handle(
        _secondaryMusclesMeta,
        secondaryMuscles.isAcceptableOrUnknown(
          data['secondary_muscles']!,
          _secondaryMusclesMeta,
        ),
      );
    }
    if (data.containsKey('images')) {
      context.handle(
        _imagesMeta,
        images.isAcceptableOrUnknown(data['images']!, _imagesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseDbData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseDbData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      externalId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}external_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      force: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}force'],
      ),
      level:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}level'],
          )!,
      mechanic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mechanic'],
      ),
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      ),
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      instructions:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}instructions'],
          )!,
      primaryMuscles:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}primary_muscles'],
          )!,
      secondaryMuscles:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}secondary_muscles'],
          )!,
      images:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}images'],
          )!,
    );
  }

  @override
  $ExerciseDbTable createAlias(String alias) {
    return $ExerciseDbTable(attachedDatabase, alias);
  }
}

class ExerciseDbData extends DataClass implements Insertable<ExerciseDbData> {
  final int id;

  /// Original ID from Free Exercise DB (e.g. 'Barbell_Full_Squat')
  final String externalId;
  final String name;

  /// Force type: 'push', 'pull', 'static', or null
  final String? force;

  /// Difficulty: 'beginner', 'intermediate', 'expert'
  final String level;

  /// Mechanic: 'compound', 'isolation', or null
  final String? mechanic;

  /// Equipment: 'barbell', 'dumbbell', 'body only', etc. or null
  final String? equipment;

  /// Category: 'strength', 'stretching', 'plyometrics', 'cardio', etc.
  final String category;

  /// Step-by-step instructions stored as JSON array string
  final String instructions;

  /// Comma-separated primary muscle names
  final String primaryMuscles;

  /// Comma-separated secondary muscle names (can be empty)
  final String secondaryMuscles;

  /// Relative image paths stored as JSON array string
  final String images;
  const ExerciseDbData({
    required this.id,
    required this.externalId,
    required this.name,
    this.force,
    required this.level,
    this.mechanic,
    this.equipment,
    required this.category,
    required this.instructions,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.images,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['external_id'] = Variable<String>(externalId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || force != null) {
      map['force'] = Variable<String>(force);
    }
    map['level'] = Variable<String>(level);
    if (!nullToAbsent || mechanic != null) {
      map['mechanic'] = Variable<String>(mechanic);
    }
    if (!nullToAbsent || equipment != null) {
      map['equipment'] = Variable<String>(equipment);
    }
    map['category'] = Variable<String>(category);
    map['instructions'] = Variable<String>(instructions);
    map['primary_muscles'] = Variable<String>(primaryMuscles);
    map['secondary_muscles'] = Variable<String>(secondaryMuscles);
    map['images'] = Variable<String>(images);
    return map;
  }

  ExerciseDbCompanion toCompanion(bool nullToAbsent) {
    return ExerciseDbCompanion(
      id: Value(id),
      externalId: Value(externalId),
      name: Value(name),
      force:
          force == null && nullToAbsent ? const Value.absent() : Value(force),
      level: Value(level),
      mechanic:
          mechanic == null && nullToAbsent
              ? const Value.absent()
              : Value(mechanic),
      equipment:
          equipment == null && nullToAbsent
              ? const Value.absent()
              : Value(equipment),
      category: Value(category),
      instructions: Value(instructions),
      primaryMuscles: Value(primaryMuscles),
      secondaryMuscles: Value(secondaryMuscles),
      images: Value(images),
    );
  }

  factory ExerciseDbData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseDbData(
      id: serializer.fromJson<int>(json['id']),
      externalId: serializer.fromJson<String>(json['externalId']),
      name: serializer.fromJson<String>(json['name']),
      force: serializer.fromJson<String?>(json['force']),
      level: serializer.fromJson<String>(json['level']),
      mechanic: serializer.fromJson<String?>(json['mechanic']),
      equipment: serializer.fromJson<String?>(json['equipment']),
      category: serializer.fromJson<String>(json['category']),
      instructions: serializer.fromJson<String>(json['instructions']),
      primaryMuscles: serializer.fromJson<String>(json['primaryMuscles']),
      secondaryMuscles: serializer.fromJson<String>(json['secondaryMuscles']),
      images: serializer.fromJson<String>(json['images']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'externalId': serializer.toJson<String>(externalId),
      'name': serializer.toJson<String>(name),
      'force': serializer.toJson<String?>(force),
      'level': serializer.toJson<String>(level),
      'mechanic': serializer.toJson<String?>(mechanic),
      'equipment': serializer.toJson<String?>(equipment),
      'category': serializer.toJson<String>(category),
      'instructions': serializer.toJson<String>(instructions),
      'primaryMuscles': serializer.toJson<String>(primaryMuscles),
      'secondaryMuscles': serializer.toJson<String>(secondaryMuscles),
      'images': serializer.toJson<String>(images),
    };
  }

  ExerciseDbData copyWith({
    int? id,
    String? externalId,
    String? name,
    Value<String?> force = const Value.absent(),
    String? level,
    Value<String?> mechanic = const Value.absent(),
    Value<String?> equipment = const Value.absent(),
    String? category,
    String? instructions,
    String? primaryMuscles,
    String? secondaryMuscles,
    String? images,
  }) => ExerciseDbData(
    id: id ?? this.id,
    externalId: externalId ?? this.externalId,
    name: name ?? this.name,
    force: force.present ? force.value : this.force,
    level: level ?? this.level,
    mechanic: mechanic.present ? mechanic.value : this.mechanic,
    equipment: equipment.present ? equipment.value : this.equipment,
    category: category ?? this.category,
    instructions: instructions ?? this.instructions,
    primaryMuscles: primaryMuscles ?? this.primaryMuscles,
    secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
    images: images ?? this.images,
  );
  ExerciseDbData copyWithCompanion(ExerciseDbCompanion data) {
    return ExerciseDbData(
      id: data.id.present ? data.id.value : this.id,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
      name: data.name.present ? data.name.value : this.name,
      force: data.force.present ? data.force.value : this.force,
      level: data.level.present ? data.level.value : this.level,
      mechanic: data.mechanic.present ? data.mechanic.value : this.mechanic,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      category: data.category.present ? data.category.value : this.category,
      instructions:
          data.instructions.present
              ? data.instructions.value
              : this.instructions,
      primaryMuscles:
          data.primaryMuscles.present
              ? data.primaryMuscles.value
              : this.primaryMuscles,
      secondaryMuscles:
          data.secondaryMuscles.present
              ? data.secondaryMuscles.value
              : this.secondaryMuscles,
      images: data.images.present ? data.images.value : this.images,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseDbData(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('name: $name, ')
          ..write('force: $force, ')
          ..write('level: $level, ')
          ..write('mechanic: $mechanic, ')
          ..write('equipment: $equipment, ')
          ..write('category: $category, ')
          ..write('instructions: $instructions, ')
          ..write('primaryMuscles: $primaryMuscles, ')
          ..write('secondaryMuscles: $secondaryMuscles, ')
          ..write('images: $images')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    externalId,
    name,
    force,
    level,
    mechanic,
    equipment,
    category,
    instructions,
    primaryMuscles,
    secondaryMuscles,
    images,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseDbData &&
          other.id == this.id &&
          other.externalId == this.externalId &&
          other.name == this.name &&
          other.force == this.force &&
          other.level == this.level &&
          other.mechanic == this.mechanic &&
          other.equipment == this.equipment &&
          other.category == this.category &&
          other.instructions == this.instructions &&
          other.primaryMuscles == this.primaryMuscles &&
          other.secondaryMuscles == this.secondaryMuscles &&
          other.images == this.images);
}

class ExerciseDbCompanion extends UpdateCompanion<ExerciseDbData> {
  final Value<int> id;
  final Value<String> externalId;
  final Value<String> name;
  final Value<String?> force;
  final Value<String> level;
  final Value<String?> mechanic;
  final Value<String?> equipment;
  final Value<String> category;
  final Value<String> instructions;
  final Value<String> primaryMuscles;
  final Value<String> secondaryMuscles;
  final Value<String> images;
  const ExerciseDbCompanion({
    this.id = const Value.absent(),
    this.externalId = const Value.absent(),
    this.name = const Value.absent(),
    this.force = const Value.absent(),
    this.level = const Value.absent(),
    this.mechanic = const Value.absent(),
    this.equipment = const Value.absent(),
    this.category = const Value.absent(),
    this.instructions = const Value.absent(),
    this.primaryMuscles = const Value.absent(),
    this.secondaryMuscles = const Value.absent(),
    this.images = const Value.absent(),
  });
  ExerciseDbCompanion.insert({
    this.id = const Value.absent(),
    required String externalId,
    required String name,
    this.force = const Value.absent(),
    required String level,
    this.mechanic = const Value.absent(),
    this.equipment = const Value.absent(),
    required String category,
    required String instructions,
    required String primaryMuscles,
    this.secondaryMuscles = const Value.absent(),
    this.images = const Value.absent(),
  }) : externalId = Value(externalId),
       name = Value(name),
       level = Value(level),
       category = Value(category),
       instructions = Value(instructions),
       primaryMuscles = Value(primaryMuscles);
  static Insertable<ExerciseDbData> custom({
    Expression<int>? id,
    Expression<String>? externalId,
    Expression<String>? name,
    Expression<String>? force,
    Expression<String>? level,
    Expression<String>? mechanic,
    Expression<String>? equipment,
    Expression<String>? category,
    Expression<String>? instructions,
    Expression<String>? primaryMuscles,
    Expression<String>? secondaryMuscles,
    Expression<String>? images,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (externalId != null) 'external_id': externalId,
      if (name != null) 'name': name,
      if (force != null) 'force': force,
      if (level != null) 'level': level,
      if (mechanic != null) 'mechanic': mechanic,
      if (equipment != null) 'equipment': equipment,
      if (category != null) 'category': category,
      if (instructions != null) 'instructions': instructions,
      if (primaryMuscles != null) 'primary_muscles': primaryMuscles,
      if (secondaryMuscles != null) 'secondary_muscles': secondaryMuscles,
      if (images != null) 'images': images,
    });
  }

  ExerciseDbCompanion copyWith({
    Value<int>? id,
    Value<String>? externalId,
    Value<String>? name,
    Value<String?>? force,
    Value<String>? level,
    Value<String?>? mechanic,
    Value<String?>? equipment,
    Value<String>? category,
    Value<String>? instructions,
    Value<String>? primaryMuscles,
    Value<String>? secondaryMuscles,
    Value<String>? images,
  }) {
    return ExerciseDbCompanion(
      id: id ?? this.id,
      externalId: externalId ?? this.externalId,
      name: name ?? this.name,
      force: force ?? this.force,
      level: level ?? this.level,
      mechanic: mechanic ?? this.mechanic,
      equipment: equipment ?? this.equipment,
      category: category ?? this.category,
      instructions: instructions ?? this.instructions,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      images: images ?? this.images,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (force.present) {
      map['force'] = Variable<String>(force.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (mechanic.present) {
      map['mechanic'] = Variable<String>(mechanic.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (primaryMuscles.present) {
      map['primary_muscles'] = Variable<String>(primaryMuscles.value);
    }
    if (secondaryMuscles.present) {
      map['secondary_muscles'] = Variable<String>(secondaryMuscles.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseDbCompanion(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('name: $name, ')
          ..write('force: $force, ')
          ..write('level: $level, ')
          ..write('mechanic: $mechanic, ')
          ..write('equipment: $equipment, ')
          ..write('category: $category, ')
          ..write('instructions: $instructions, ')
          ..write('primaryMuscles: $primaryMuscles, ')
          ..write('secondaryMuscles: $secondaryMuscles, ')
          ..write('images: $images')
          ..write(')'))
        .toString();
  }
}

class $StepMilestonesTable extends StepMilestones
    with TableInfo<$StepMilestonesTable, StepMilestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepMilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _milestonesClaimedMeta = const VerificationMeta(
    'milestonesClaimed',
  );
  @override
  late final GeneratedColumn<int> milestonesClaimed = GeneratedColumn<int>(
    'milestones_claimed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stepsAtLastClaimMeta = const VerificationMeta(
    'stepsAtLastClaim',
  );
  @override
  late final GeneratedColumn<int> stepsAtLastClaim = GeneratedColumn<int>(
    'steps_at_last_claim',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    date,
    milestonesClaimed,
    stepsAtLastClaim,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_milestones';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepMilestone> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('milestones_claimed')) {
      context.handle(
        _milestonesClaimedMeta,
        milestonesClaimed.isAcceptableOrUnknown(
          data['milestones_claimed']!,
          _milestonesClaimedMeta,
        ),
      );
    }
    if (data.containsKey('steps_at_last_claim')) {
      context.handle(
        _stepsAtLastClaimMeta,
        stepsAtLastClaim.isAcceptableOrUnknown(
          data['steps_at_last_claim']!,
          _stepsAtLastClaimMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepMilestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepMilestone(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
      milestonesClaimed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}milestones_claimed'],
          )!,
      stepsAtLastClaim:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}steps_at_last_claim'],
          )!,
    );
  }

  @override
  $StepMilestonesTable createAlias(String alias) {
    return $StepMilestonesTable(attachedDatabase, alias);
  }
}

class StepMilestone extends DataClass implements Insertable<StepMilestone> {
  final int id;
  final int playerId;

  /// Date string 'YYYY-MM-DD' for daily tracking
  final String date;

  /// Number of milestones claimed today
  final int milestonesClaimed;

  /// Steps at last milestone claim
  final int stepsAtLastClaim;
  const StepMilestone({
    required this.id,
    required this.playerId,
    required this.date,
    required this.milestonesClaimed,
    required this.stepsAtLastClaim,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['date'] = Variable<String>(date);
    map['milestones_claimed'] = Variable<int>(milestonesClaimed);
    map['steps_at_last_claim'] = Variable<int>(stepsAtLastClaim);
    return map;
  }

  StepMilestonesCompanion toCompanion(bool nullToAbsent) {
    return StepMilestonesCompanion(
      id: Value(id),
      playerId: Value(playerId),
      date: Value(date),
      milestonesClaimed: Value(milestonesClaimed),
      stepsAtLastClaim: Value(stepsAtLastClaim),
    );
  }

  factory StepMilestone.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepMilestone(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      date: serializer.fromJson<String>(json['date']),
      milestonesClaimed: serializer.fromJson<int>(json['milestonesClaimed']),
      stepsAtLastClaim: serializer.fromJson<int>(json['stepsAtLastClaim']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'date': serializer.toJson<String>(date),
      'milestonesClaimed': serializer.toJson<int>(milestonesClaimed),
      'stepsAtLastClaim': serializer.toJson<int>(stepsAtLastClaim),
    };
  }

  StepMilestone copyWith({
    int? id,
    int? playerId,
    String? date,
    int? milestonesClaimed,
    int? stepsAtLastClaim,
  }) => StepMilestone(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    date: date ?? this.date,
    milestonesClaimed: milestonesClaimed ?? this.milestonesClaimed,
    stepsAtLastClaim: stepsAtLastClaim ?? this.stepsAtLastClaim,
  );
  StepMilestone copyWithCompanion(StepMilestonesCompanion data) {
    return StepMilestone(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      date: data.date.present ? data.date.value : this.date,
      milestonesClaimed:
          data.milestonesClaimed.present
              ? data.milestonesClaimed.value
              : this.milestonesClaimed,
      stepsAtLastClaim:
          data.stepsAtLastClaim.present
              ? data.stepsAtLastClaim.value
              : this.stepsAtLastClaim,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepMilestone(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('date: $date, ')
          ..write('milestonesClaimed: $milestonesClaimed, ')
          ..write('stepsAtLastClaim: $stepsAtLastClaim')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playerId, date, milestonesClaimed, stepsAtLastClaim);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepMilestone &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.date == this.date &&
          other.milestonesClaimed == this.milestonesClaimed &&
          other.stepsAtLastClaim == this.stepsAtLastClaim);
}

class StepMilestonesCompanion extends UpdateCompanion<StepMilestone> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> date;
  final Value<int> milestonesClaimed;
  final Value<int> stepsAtLastClaim;
  const StepMilestonesCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.date = const Value.absent(),
    this.milestonesClaimed = const Value.absent(),
    this.stepsAtLastClaim = const Value.absent(),
  });
  StepMilestonesCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String date,
    this.milestonesClaimed = const Value.absent(),
    this.stepsAtLastClaim = const Value.absent(),
  }) : playerId = Value(playerId),
       date = Value(date);
  static Insertable<StepMilestone> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? date,
    Expression<int>? milestonesClaimed,
    Expression<int>? stepsAtLastClaim,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (date != null) 'date': date,
      if (milestonesClaimed != null) 'milestones_claimed': milestonesClaimed,
      if (stepsAtLastClaim != null) 'steps_at_last_claim': stepsAtLastClaim,
    });
  }

  StepMilestonesCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? date,
    Value<int>? milestonesClaimed,
    Value<int>? stepsAtLastClaim,
  }) {
    return StepMilestonesCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      date: date ?? this.date,
      milestonesClaimed: milestonesClaimed ?? this.milestonesClaimed,
      stepsAtLastClaim: stepsAtLastClaim ?? this.stepsAtLastClaim,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (milestonesClaimed.present) {
      map['milestones_claimed'] = Variable<int>(milestonesClaimed.value);
    }
    if (stepsAtLastClaim.present) {
      map['steps_at_last_claim'] = Variable<int>(stepsAtLastClaim.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepMilestonesCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('date: $date, ')
          ..write('milestonesClaimed: $milestonesClaimed, ')
          ..write('stepsAtLastClaim: $stepsAtLastClaim')
          ..write(')'))
        .toString();
  }
}

class $EggsTable extends Eggs with TableInfo<$EggsTable, Egg> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EggsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _companionTypeMeta = const VerificationMeta(
    'companionType',
  );
  @override
  late final GeneratedColumn<String> companionType = GeneratedColumn<String>(
    'companion_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsRequiredMeta = const VerificationMeta(
    'stepsRequired',
  );
  @override
  late final GeneratedColumn<int> stepsRequired = GeneratedColumn<int>(
    'steps_required',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsAccumulatedMeta = const VerificationMeta(
    'stepsAccumulated',
  );
  @override
  late final GeneratedColumn<int> stepsAccumulated = GeneratedColumn<int>(
    'steps_accumulated',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _foundAtMeta = const VerificationMeta(
    'foundAt',
  );
  @override
  late final GeneratedColumn<DateTime> foundAt = GeneratedColumn<DateTime>(
    'found_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _hatchedAtMeta = const VerificationMeta(
    'hatchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> hatchedAt = GeneratedColumn<DateTime>(
    'hatched_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    companionType,
    rarity,
    stepsRequired,
    stepsAccumulated,
    foundAt,
    hatchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eggs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Egg> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('companion_type')) {
      context.handle(
        _companionTypeMeta,
        companionType.isAcceptableOrUnknown(
          data['companion_type']!,
          _companionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companionTypeMeta);
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    } else if (isInserting) {
      context.missing(_rarityMeta);
    }
    if (data.containsKey('steps_required')) {
      context.handle(
        _stepsRequiredMeta,
        stepsRequired.isAcceptableOrUnknown(
          data['steps_required']!,
          _stepsRequiredMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stepsRequiredMeta);
    }
    if (data.containsKey('steps_accumulated')) {
      context.handle(
        _stepsAccumulatedMeta,
        stepsAccumulated.isAcceptableOrUnknown(
          data['steps_accumulated']!,
          _stepsAccumulatedMeta,
        ),
      );
    }
    if (data.containsKey('found_at')) {
      context.handle(
        _foundAtMeta,
        foundAt.isAcceptableOrUnknown(data['found_at']!, _foundAtMeta),
      );
    }
    if (data.containsKey('hatched_at')) {
      context.handle(
        _hatchedAtMeta,
        hatchedAt.isAcceptableOrUnknown(data['hatched_at']!, _hatchedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Egg map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Egg(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      companionType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}companion_type'],
          )!,
      rarity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rarity'],
          )!,
      stepsRequired:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}steps_required'],
          )!,
      stepsAccumulated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}steps_accumulated'],
          )!,
      foundAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}found_at'],
          )!,
      hatchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hatched_at'],
      ),
    );
  }

  @override
  $EggsTable createAlias(String alias) {
    return $EggsTable(attachedDatabase, alias);
  }
}

class Egg extends DataClass implements Insertable<Egg> {
  final int id;
  final int playerId;

  /// Companion type that will hatch (matches CompanionDef.type)
  final String companionType;

  /// Rarity: common, rare, epic, legendary
  final String rarity;

  /// Total steps required to hatch
  final int stepsRequired;

  /// Steps accumulated so far
  final int stepsAccumulated;
  final DateTime foundAt;
  final DateTime? hatchedAt;
  const Egg({
    required this.id,
    required this.playerId,
    required this.companionType,
    required this.rarity,
    required this.stepsRequired,
    required this.stepsAccumulated,
    required this.foundAt,
    this.hatchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['companion_type'] = Variable<String>(companionType);
    map['rarity'] = Variable<String>(rarity);
    map['steps_required'] = Variable<int>(stepsRequired);
    map['steps_accumulated'] = Variable<int>(stepsAccumulated);
    map['found_at'] = Variable<DateTime>(foundAt);
    if (!nullToAbsent || hatchedAt != null) {
      map['hatched_at'] = Variable<DateTime>(hatchedAt);
    }
    return map;
  }

  EggsCompanion toCompanion(bool nullToAbsent) {
    return EggsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      companionType: Value(companionType),
      rarity: Value(rarity),
      stepsRequired: Value(stepsRequired),
      stepsAccumulated: Value(stepsAccumulated),
      foundAt: Value(foundAt),
      hatchedAt:
          hatchedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(hatchedAt),
    );
  }

  factory Egg.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Egg(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      companionType: serializer.fromJson<String>(json['companionType']),
      rarity: serializer.fromJson<String>(json['rarity']),
      stepsRequired: serializer.fromJson<int>(json['stepsRequired']),
      stepsAccumulated: serializer.fromJson<int>(json['stepsAccumulated']),
      foundAt: serializer.fromJson<DateTime>(json['foundAt']),
      hatchedAt: serializer.fromJson<DateTime?>(json['hatchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'companionType': serializer.toJson<String>(companionType),
      'rarity': serializer.toJson<String>(rarity),
      'stepsRequired': serializer.toJson<int>(stepsRequired),
      'stepsAccumulated': serializer.toJson<int>(stepsAccumulated),
      'foundAt': serializer.toJson<DateTime>(foundAt),
      'hatchedAt': serializer.toJson<DateTime?>(hatchedAt),
    };
  }

  Egg copyWith({
    int? id,
    int? playerId,
    String? companionType,
    String? rarity,
    int? stepsRequired,
    int? stepsAccumulated,
    DateTime? foundAt,
    Value<DateTime?> hatchedAt = const Value.absent(),
  }) => Egg(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    companionType: companionType ?? this.companionType,
    rarity: rarity ?? this.rarity,
    stepsRequired: stepsRequired ?? this.stepsRequired,
    stepsAccumulated: stepsAccumulated ?? this.stepsAccumulated,
    foundAt: foundAt ?? this.foundAt,
    hatchedAt: hatchedAt.present ? hatchedAt.value : this.hatchedAt,
  );
  Egg copyWithCompanion(EggsCompanion data) {
    return Egg(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      companionType:
          data.companionType.present
              ? data.companionType.value
              : this.companionType,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      stepsRequired:
          data.stepsRequired.present
              ? data.stepsRequired.value
              : this.stepsRequired,
      stepsAccumulated:
          data.stepsAccumulated.present
              ? data.stepsAccumulated.value
              : this.stepsAccumulated,
      foundAt: data.foundAt.present ? data.foundAt.value : this.foundAt,
      hatchedAt: data.hatchedAt.present ? data.hatchedAt.value : this.hatchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Egg(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('companionType: $companionType, ')
          ..write('rarity: $rarity, ')
          ..write('stepsRequired: $stepsRequired, ')
          ..write('stepsAccumulated: $stepsAccumulated, ')
          ..write('foundAt: $foundAt, ')
          ..write('hatchedAt: $hatchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    companionType,
    rarity,
    stepsRequired,
    stepsAccumulated,
    foundAt,
    hatchedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Egg &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.companionType == this.companionType &&
          other.rarity == this.rarity &&
          other.stepsRequired == this.stepsRequired &&
          other.stepsAccumulated == this.stepsAccumulated &&
          other.foundAt == this.foundAt &&
          other.hatchedAt == this.hatchedAt);
}

class EggsCompanion extends UpdateCompanion<Egg> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> companionType;
  final Value<String> rarity;
  final Value<int> stepsRequired;
  final Value<int> stepsAccumulated;
  final Value<DateTime> foundAt;
  final Value<DateTime?> hatchedAt;
  const EggsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.companionType = const Value.absent(),
    this.rarity = const Value.absent(),
    this.stepsRequired = const Value.absent(),
    this.stepsAccumulated = const Value.absent(),
    this.foundAt = const Value.absent(),
    this.hatchedAt = const Value.absent(),
  });
  EggsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String companionType,
    required String rarity,
    required int stepsRequired,
    this.stepsAccumulated = const Value.absent(),
    this.foundAt = const Value.absent(),
    this.hatchedAt = const Value.absent(),
  }) : playerId = Value(playerId),
       companionType = Value(companionType),
       rarity = Value(rarity),
       stepsRequired = Value(stepsRequired);
  static Insertable<Egg> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? companionType,
    Expression<String>? rarity,
    Expression<int>? stepsRequired,
    Expression<int>? stepsAccumulated,
    Expression<DateTime>? foundAt,
    Expression<DateTime>? hatchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (companionType != null) 'companion_type': companionType,
      if (rarity != null) 'rarity': rarity,
      if (stepsRequired != null) 'steps_required': stepsRequired,
      if (stepsAccumulated != null) 'steps_accumulated': stepsAccumulated,
      if (foundAt != null) 'found_at': foundAt,
      if (hatchedAt != null) 'hatched_at': hatchedAt,
    });
  }

  EggsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? companionType,
    Value<String>? rarity,
    Value<int>? stepsRequired,
    Value<int>? stepsAccumulated,
    Value<DateTime>? foundAt,
    Value<DateTime?>? hatchedAt,
  }) {
    return EggsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      companionType: companionType ?? this.companionType,
      rarity: rarity ?? this.rarity,
      stepsRequired: stepsRequired ?? this.stepsRequired,
      stepsAccumulated: stepsAccumulated ?? this.stepsAccumulated,
      foundAt: foundAt ?? this.foundAt,
      hatchedAt: hatchedAt ?? this.hatchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (companionType.present) {
      map['companion_type'] = Variable<String>(companionType.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (stepsRequired.present) {
      map['steps_required'] = Variable<int>(stepsRequired.value);
    }
    if (stepsAccumulated.present) {
      map['steps_accumulated'] = Variable<int>(stepsAccumulated.value);
    }
    if (foundAt.present) {
      map['found_at'] = Variable<DateTime>(foundAt.value);
    }
    if (hatchedAt.present) {
      map['hatched_at'] = Variable<DateTime>(hatchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EggsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('companionType: $companionType, ')
          ..write('rarity: $rarity, ')
          ..write('stepsRequired: $stepsRequired, ')
          ..write('stepsAccumulated: $stepsAccumulated, ')
          ..write('foundAt: $foundAt, ')
          ..write('hatchedAt: $hatchedAt')
          ..write(')'))
        .toString();
  }
}

class $CompanionsTable extends Companions
    with TableInfo<$CompanionsTable, Companion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buffTypeMeta = const VerificationMeta(
    'buffType',
  );
  @override
  late final GeneratedColumn<String> buffType = GeneratedColumn<String>(
    'buff_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buffValueMeta = const VerificationMeta(
    'buffValue',
  );
  @override
  late final GeneratedColumn<int> buffValue = GeneratedColumn<int>(
    'buff_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hatchedAtMeta = const VerificationMeta(
    'hatchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> hatchedAt = GeneratedColumn<DateTime>(
    'hatched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    name,
    type,
    rarity,
    buffType,
    buffValue,
    isActive,
    hatchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Companion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    } else if (isInserting) {
      context.missing(_rarityMeta);
    }
    if (data.containsKey('buff_type')) {
      context.handle(
        _buffTypeMeta,
        buffType.isAcceptableOrUnknown(data['buff_type']!, _buffTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_buffTypeMeta);
    }
    if (data.containsKey('buff_value')) {
      context.handle(
        _buffValueMeta,
        buffValue.isAcceptableOrUnknown(data['buff_value']!, _buffValueMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('hatched_at')) {
      context.handle(
        _hatchedAtMeta,
        hatchedAt.isAcceptableOrUnknown(data['hatched_at']!, _hatchedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Companion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Companion(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}player_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      rarity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rarity'],
          )!,
      buffType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}buff_type'],
          )!,
      buffValue:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buff_value'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      hatchedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}hatched_at'],
          )!,
    );
  }

  @override
  $CompanionsTable createAlias(String alias) {
    return $CompanionsTable(attachedDatabase, alias);
  }
}

class Companion extends DataClass implements Insertable<Companion> {
  final int id;
  final int playerId;
  final String name;
  final String type;
  final String rarity;

  /// Passive buff type (e.g. 'gold_bonus', 'lp_bonus')
  final String buffType;

  /// Buff value (e.g. 5 for +5%)
  final int buffValue;

  /// Whether this companion is active (only 1 active at a time)
  final bool isActive;
  final DateTime hatchedAt;
  const Companion({
    required this.id,
    required this.playerId,
    required this.name,
    required this.type,
    required this.rarity,
    required this.buffType,
    required this.buffValue,
    required this.isActive,
    required this.hatchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['rarity'] = Variable<String>(rarity);
    map['buff_type'] = Variable<String>(buffType);
    map['buff_value'] = Variable<int>(buffValue);
    map['is_active'] = Variable<bool>(isActive);
    map['hatched_at'] = Variable<DateTime>(hatchedAt);
    return map;
  }

  CompanionsCompanion toCompanion(bool nullToAbsent) {
    return CompanionsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      name: Value(name),
      type: Value(type),
      rarity: Value(rarity),
      buffType: Value(buffType),
      buffValue: Value(buffValue),
      isActive: Value(isActive),
      hatchedAt: Value(hatchedAt),
    );
  }

  factory Companion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Companion(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      rarity: serializer.fromJson<String>(json['rarity']),
      buffType: serializer.fromJson<String>(json['buffType']),
      buffValue: serializer.fromJson<int>(json['buffValue']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      hatchedAt: serializer.fromJson<DateTime>(json['hatchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'rarity': serializer.toJson<String>(rarity),
      'buffType': serializer.toJson<String>(buffType),
      'buffValue': serializer.toJson<int>(buffValue),
      'isActive': serializer.toJson<bool>(isActive),
      'hatchedAt': serializer.toJson<DateTime>(hatchedAt),
    };
  }

  Companion copyWith({
    int? id,
    int? playerId,
    String? name,
    String? type,
    String? rarity,
    String? buffType,
    int? buffValue,
    bool? isActive,
    DateTime? hatchedAt,
  }) => Companion(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    name: name ?? this.name,
    type: type ?? this.type,
    rarity: rarity ?? this.rarity,
    buffType: buffType ?? this.buffType,
    buffValue: buffValue ?? this.buffValue,
    isActive: isActive ?? this.isActive,
    hatchedAt: hatchedAt ?? this.hatchedAt,
  );
  Companion copyWithCompanion(CompanionsCompanion data) {
    return Companion(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      buffType: data.buffType.present ? data.buffType.value : this.buffType,
      buffValue: data.buffValue.present ? data.buffValue.value : this.buffValue,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      hatchedAt: data.hatchedAt.present ? data.hatchedAt.value : this.hatchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Companion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('rarity: $rarity, ')
          ..write('buffType: $buffType, ')
          ..write('buffValue: $buffValue, ')
          ..write('isActive: $isActive, ')
          ..write('hatchedAt: $hatchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    name,
    type,
    rarity,
    buffType,
    buffValue,
    isActive,
    hatchedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Companion &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.name == this.name &&
          other.type == this.type &&
          other.rarity == this.rarity &&
          other.buffType == this.buffType &&
          other.buffValue == this.buffValue &&
          other.isActive == this.isActive &&
          other.hatchedAt == this.hatchedAt);
}

class CompanionsCompanion extends UpdateCompanion<Companion> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> name;
  final Value<String> type;
  final Value<String> rarity;
  final Value<String> buffType;
  final Value<int> buffValue;
  final Value<bool> isActive;
  final Value<DateTime> hatchedAt;
  const CompanionsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.rarity = const Value.absent(),
    this.buffType = const Value.absent(),
    this.buffValue = const Value.absent(),
    this.isActive = const Value.absent(),
    this.hatchedAt = const Value.absent(),
  });
  CompanionsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String name,
    required String type,
    required String rarity,
    required String buffType,
    this.buffValue = const Value.absent(),
    this.isActive = const Value.absent(),
    this.hatchedAt = const Value.absent(),
  }) : playerId = Value(playerId),
       name = Value(name),
       type = Value(type),
       rarity = Value(rarity),
       buffType = Value(buffType);
  static Insertable<Companion> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? rarity,
    Expression<String>? buffType,
    Expression<int>? buffValue,
    Expression<bool>? isActive,
    Expression<DateTime>? hatchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (rarity != null) 'rarity': rarity,
      if (buffType != null) 'buff_type': buffType,
      if (buffValue != null) 'buff_value': buffValue,
      if (isActive != null) 'is_active': isActive,
      if (hatchedAt != null) 'hatched_at': hatchedAt,
    });
  }

  CompanionsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? name,
    Value<String>? type,
    Value<String>? rarity,
    Value<String>? buffType,
    Value<int>? buffValue,
    Value<bool>? isActive,
    Value<DateTime>? hatchedAt,
  }) {
    return CompanionsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      name: name ?? this.name,
      type: type ?? this.type,
      rarity: rarity ?? this.rarity,
      buffType: buffType ?? this.buffType,
      buffValue: buffValue ?? this.buffValue,
      isActive: isActive ?? this.isActive,
      hatchedAt: hatchedAt ?? this.hatchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (buffType.present) {
      map['buff_type'] = Variable<String>(buffType.value);
    }
    if (buffValue.present) {
      map['buff_value'] = Variable<int>(buffValue.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (hatchedAt.present) {
      map['hatched_at'] = Variable<DateTime>(hatchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanionsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('rarity: $rarity, ')
          ..write('buffType: $buffType, ')
          ..write('buffValue: $buffValue, ')
          ..write('isActive: $isActive, ')
          ..write('hatchedAt: $hatchedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$QuestFitDatabase extends GeneratedDatabase {
  _$QuestFitDatabase(QueryExecutor e) : super(e);
  $QuestFitDatabaseManager get managers => $QuestFitDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $StatsTable stats = $StatsTable(this);
  late final $QuestsTable quests = $QuestsTable(this);
  late final $WorkoutLogsTable workoutLogs = $WorkoutLogsTable(this);
  late final $StreaksTable streaks = $StreaksTable(this);
  late final $RankHistoryTable rankHistory = $RankHistoryTable(this);
  late final $EquipmentTable equipment = $EquipmentTable(this);
  late final $EquipmentExercisesTable equipmentExercises =
      $EquipmentExercisesTable(this);
  late final $EquippedSlotsTable equippedSlots = $EquippedSlotsTable(this);
  late final $InventoryTable inventory = $InventoryTable(this);
  late final $RankTrialsTable rankTrials = $RankTrialsTable(this);
  late final $ExerciseDbTable exerciseDb = $ExerciseDbTable(this);
  late final $StepMilestonesTable stepMilestones = $StepMilestonesTable(this);
  late final $EggsTable eggs = $EggsTable(this);
  late final $CompanionsTable companions = $CompanionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    players,
    stats,
    quests,
    workoutLogs,
    streaks,
    rankHistory,
    equipment,
    equipmentExercises,
    equippedSlots,
    inventory,
    rankTrials,
    exerciseDb,
    stepMilestones,
    eggs,
    companions,
  ];
}

typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> level,
      Value<int> xp,
      Value<int> totalXp,
      Value<String> tier,
      Value<int> division,
      Value<int> lp,
      Value<int> totalQuestsCompleted,
      Value<DateTime?> lastActivityAt,
      Value<bool> pendingPromotion,
      Value<String> rank,
      Value<String> classType,
      Value<int> gold,
      Value<bool> awakeningComplete,
      Value<DateTime> createdAt,
      Value<int> dailyStepGoal,
      Value<bool> momentumBuffActive,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> level,
      Value<int> xp,
      Value<int> totalXp,
      Value<String> tier,
      Value<int> division,
      Value<int> lp,
      Value<int> totalQuestsCompleted,
      Value<DateTime?> lastActivityAt,
      Value<bool> pendingPromotion,
      Value<String> rank,
      Value<String> classType,
      Value<int> gold,
      Value<bool> awakeningComplete,
      Value<DateTime> createdAt,
      Value<int> dailyStepGoal,
      Value<bool> momentumBuffActive,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$QuestFitDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StatsTable, List<Stat>> _statsRefsTable(
    _$QuestFitDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.stats,
    aliasName: $_aliasNameGenerator(db.players.id, db.stats.playerId),
  );

  $$StatsTableProcessedTableManager get statsRefs {
    final manager = $$StatsTableTableManager(
      $_db,
      $_db.stats,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_statsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutLogsTable, List<WorkoutLog>>
  _workoutLogsRefsTable(_$QuestFitDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutLogs,
    aliasName: $_aliasNameGenerator(db.players.id, db.workoutLogs.playerId),
  );

  $$WorkoutLogsTableProcessedTableManager get workoutLogsRefs {
    final manager = $$WorkoutLogsTableTableManager(
      $_db,
      $_db.workoutLogs,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StreaksTable, List<Streak>> _streaksRefsTable(
    _$QuestFitDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.streaks,
    aliasName: $_aliasNameGenerator(db.players.id, db.streaks.playerId),
  );

  $$StreaksTableProcessedTableManager get streaksRefs {
    final manager = $$StreaksTableTableManager(
      $_db,
      $_db.streaks,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_streaksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RankHistoryTable, List<RankHistoryData>>
  _rankHistoryRefsTable(_$QuestFitDatabase db) => MultiTypedResultKey.fromTable(
    db.rankHistory,
    aliasName: $_aliasNameGenerator(db.players.id, db.rankHistory.playerId),
  );

  $$RankHistoryTableProcessedTableManager get rankHistoryRefs {
    final manager = $$RankHistoryTableTableManager(
      $_db,
      $_db.rankHistory,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rankHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EquippedSlotsTable, List<EquippedSlot>>
  _equippedSlotsRefsTable(_$QuestFitDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.equippedSlots,
        aliasName: $_aliasNameGenerator(
          db.players.id,
          db.equippedSlots.playerId,
        ),
      );

  $$EquippedSlotsTableProcessedTableManager get equippedSlotsRefs {
    final manager = $$EquippedSlotsTableTableManager(
      $_db,
      $_db.equippedSlots,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_equippedSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InventoryTable, List<InventoryData>>
  _inventoryRefsTable(_$QuestFitDatabase db) => MultiTypedResultKey.fromTable(
    db.inventory,
    aliasName: $_aliasNameGenerator(db.players.id, db.inventory.playerId),
  );

  $$InventoryTableProcessedTableManager get inventoryRefs {
    final manager = $$InventoryTableTableManager(
      $_db,
      $_db.inventory,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RankTrialsTable, List<RankTrial>>
  _rankTrialsRefsTable(_$QuestFitDatabase db) => MultiTypedResultKey.fromTable(
    db.rankTrials,
    aliasName: $_aliasNameGenerator(db.players.id, db.rankTrials.playerId),
  );

  $$RankTrialsTableProcessedTableManager get rankTrialsRefs {
    final manager = $$RankTrialsTableTableManager(
      $_db,
      $_db.rankTrials,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rankTrialsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StepMilestonesTable, List<StepMilestone>>
  _stepMilestonesRefsTable(_$QuestFitDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.stepMilestones,
        aliasName: $_aliasNameGenerator(
          db.players.id,
          db.stepMilestones.playerId,
        ),
      );

  $$StepMilestonesTableProcessedTableManager get stepMilestonesRefs {
    final manager = $$StepMilestonesTableTableManager(
      $_db,
      $_db.stepMilestones,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stepMilestonesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EggsTable, List<Egg>> _eggsRefsTable(
    _$QuestFitDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.eggs,
    aliasName: $_aliasNameGenerator(db.players.id, db.eggs.playerId),
  );

  $$EggsTableProcessedTableManager get eggsRefs {
    final manager = $$EggsTableTableManager(
      $_db,
      $_db.eggs,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eggsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CompanionsTable, List<Companion>>
  _companionsRefsTable(_$QuestFitDatabase db) => MultiTypedResultKey.fromTable(
    db.companions,
    aliasName: $_aliasNameGenerator(db.players.id, db.companions.playerId),
  );

  $$CompanionsTableProcessedTableManager get companionsRefs {
    final manager = $$CompanionsTableTableManager(
      $_db,
      $_db.companions,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_companionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$QuestFitDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lp => $composableBuilder(
    column: $table.lp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestsCompleted => $composableBuilder(
    column: $table.totalQuestsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActivityAt => $composableBuilder(
    column: $table.lastActivityAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingPromotion => $composableBuilder(
    column: $table.pendingPromotion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classType => $composableBuilder(
    column: $table.classType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get awakeningComplete => $composableBuilder(
    column: $table.awakeningComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyStepGoal => $composableBuilder(
    column: $table.dailyStepGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get momentumBuffActive => $composableBuilder(
    column: $table.momentumBuffActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> statsRefs(
    Expression<bool> Function($$StatsTableFilterComposer f) f,
  ) {
    final $$StatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stats,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatsTableFilterComposer(
            $db: $db,
            $table: $db.stats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutLogsRefs(
    Expression<bool> Function($$WorkoutLogsTableFilterComposer f) f,
  ) {
    final $$WorkoutLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutLogs,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutLogsTableFilterComposer(
            $db: $db,
            $table: $db.workoutLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> streaksRefs(
    Expression<bool> Function($$StreaksTableFilterComposer f) f,
  ) {
    final $$StreaksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.streaks,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StreaksTableFilterComposer(
            $db: $db,
            $table: $db.streaks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> rankHistoryRefs(
    Expression<bool> Function($$RankHistoryTableFilterComposer f) f,
  ) {
    final $$RankHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rankHistory,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RankHistoryTableFilterComposer(
            $db: $db,
            $table: $db.rankHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> equippedSlotsRefs(
    Expression<bool> Function($$EquippedSlotsTableFilterComposer f) f,
  ) {
    final $$EquippedSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equippedSlots,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquippedSlotsTableFilterComposer(
            $db: $db,
            $table: $db.equippedSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryRefs(
    Expression<bool> Function($$InventoryTableFilterComposer f) f,
  ) {
    final $$InventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventory,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryTableFilterComposer(
            $db: $db,
            $table: $db.inventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> rankTrialsRefs(
    Expression<bool> Function($$RankTrialsTableFilterComposer f) f,
  ) {
    final $$RankTrialsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rankTrials,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RankTrialsTableFilterComposer(
            $db: $db,
            $table: $db.rankTrials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stepMilestonesRefs(
    Expression<bool> Function($$StepMilestonesTableFilterComposer f) f,
  ) {
    final $$StepMilestonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stepMilestones,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StepMilestonesTableFilterComposer(
            $db: $db,
            $table: $db.stepMilestones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eggsRefs(
    Expression<bool> Function($$EggsTableFilterComposer f) f,
  ) {
    final $$EggsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eggs,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggsTableFilterComposer(
            $db: $db,
            $table: $db.eggs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> companionsRefs(
    Expression<bool> Function($$CompanionsTableFilterComposer f) f,
  ) {
    final $$CompanionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.companions,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompanionsTableFilterComposer(
            $db: $db,
            $table: $db.companions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lp => $composableBuilder(
    column: $table.lp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestsCompleted => $composableBuilder(
    column: $table.totalQuestsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActivityAt => $composableBuilder(
    column: $table.lastActivityAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingPromotion => $composableBuilder(
    column: $table.pendingPromotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classType => $composableBuilder(
    column: $table.classType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get awakeningComplete => $composableBuilder(
    column: $table.awakeningComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyStepGoal => $composableBuilder(
    column: $table.dailyStepGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get momentumBuffActive => $composableBuilder(
    column: $table.momentumBuffActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<int> get division =>
      $composableBuilder(column: $table.division, builder: (column) => column);

  GeneratedColumn<int> get lp =>
      $composableBuilder(column: $table.lp, builder: (column) => column);

  GeneratedColumn<int> get totalQuestsCompleted => $composableBuilder(
    column: $table.totalQuestsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActivityAt => $composableBuilder(
    column: $table.lastActivityAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingPromotion => $composableBuilder(
    column: $table.pendingPromotion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<String> get classType =>
      $composableBuilder(column: $table.classType, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  GeneratedColumn<bool> get awakeningComplete => $composableBuilder(
    column: $table.awakeningComplete,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get dailyStepGoal => $composableBuilder(
    column: $table.dailyStepGoal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get momentumBuffActive => $composableBuilder(
    column: $table.momentumBuffActive,
    builder: (column) => column,
  );

  Expression<T> statsRefs<T extends Object>(
    Expression<T> Function($$StatsTableAnnotationComposer a) f,
  ) {
    final $$StatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stats,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatsTableAnnotationComposer(
            $db: $db,
            $table: $db.stats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutLogsRefs<T extends Object>(
    Expression<T> Function($$WorkoutLogsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutLogs,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> streaksRefs<T extends Object>(
    Expression<T> Function($$StreaksTableAnnotationComposer a) f,
  ) {
    final $$StreaksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.streaks,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StreaksTableAnnotationComposer(
            $db: $db,
            $table: $db.streaks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> rankHistoryRefs<T extends Object>(
    Expression<T> Function($$RankHistoryTableAnnotationComposer a) f,
  ) {
    final $$RankHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rankHistory,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RankHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.rankHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> equippedSlotsRefs<T extends Object>(
    Expression<T> Function($$EquippedSlotsTableAnnotationComposer a) f,
  ) {
    final $$EquippedSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equippedSlots,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquippedSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.equippedSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventoryRefs<T extends Object>(
    Expression<T> Function($$InventoryTableAnnotationComposer a) f,
  ) {
    final $$InventoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventory,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryTableAnnotationComposer(
            $db: $db,
            $table: $db.inventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> rankTrialsRefs<T extends Object>(
    Expression<T> Function($$RankTrialsTableAnnotationComposer a) f,
  ) {
    final $$RankTrialsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rankTrials,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RankTrialsTableAnnotationComposer(
            $db: $db,
            $table: $db.rankTrials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stepMilestonesRefs<T extends Object>(
    Expression<T> Function($$StepMilestonesTableAnnotationComposer a) f,
  ) {
    final $$StepMilestonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stepMilestones,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StepMilestonesTableAnnotationComposer(
            $db: $db,
            $table: $db.stepMilestones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eggsRefs<T extends Object>(
    Expression<T> Function($$EggsTableAnnotationComposer a) f,
  ) {
    final $$EggsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eggs,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggsTableAnnotationComposer(
            $db: $db,
            $table: $db.eggs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> companionsRefs<T extends Object>(
    Expression<T> Function($$CompanionsTableAnnotationComposer a) f,
  ) {
    final $$CompanionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.companions,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompanionsTableAnnotationComposer(
            $db: $db,
            $table: $db.companions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({
            bool statsRefs,
            bool workoutLogsRefs,
            bool streaksRefs,
            bool rankHistoryRefs,
            bool equippedSlotsRefs,
            bool inventoryRefs,
            bool rankTrialsRefs,
            bool stepMilestonesRefs,
            bool eggsRefs,
            bool companionsRefs,
          })
        > {
  $$PlayersTableTableManager(_$QuestFitDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<int> division = const Value.absent(),
                Value<int> lp = const Value.absent(),
                Value<int> totalQuestsCompleted = const Value.absent(),
                Value<DateTime?> lastActivityAt = const Value.absent(),
                Value<bool> pendingPromotion = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<String> classType = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<bool> awakeningComplete = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> dailyStepGoal = const Value.absent(),
                Value<bool> momentumBuffActive = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                name: name,
                level: level,
                xp: xp,
                totalXp: totalXp,
                tier: tier,
                division: division,
                lp: lp,
                totalQuestsCompleted: totalQuestsCompleted,
                lastActivityAt: lastActivityAt,
                pendingPromotion: pendingPromotion,
                rank: rank,
                classType: classType,
                gold: gold,
                awakeningComplete: awakeningComplete,
                createdAt: createdAt,
                dailyStepGoal: dailyStepGoal,
                momentumBuffActive: momentumBuffActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<int> division = const Value.absent(),
                Value<int> lp = const Value.absent(),
                Value<int> totalQuestsCompleted = const Value.absent(),
                Value<DateTime?> lastActivityAt = const Value.absent(),
                Value<bool> pendingPromotion = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<String> classType = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<bool> awakeningComplete = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> dailyStepGoal = const Value.absent(),
                Value<bool> momentumBuffActive = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                level: level,
                xp: xp,
                totalXp: totalXp,
                tier: tier,
                division: division,
                lp: lp,
                totalQuestsCompleted: totalQuestsCompleted,
                lastActivityAt: lastActivityAt,
                pendingPromotion: pendingPromotion,
                rank: rank,
                classType: classType,
                gold: gold,
                awakeningComplete: awakeningComplete,
                createdAt: createdAt,
                dailyStepGoal: dailyStepGoal,
                momentumBuffActive: momentumBuffActive,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PlayersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            statsRefs = false,
            workoutLogsRefs = false,
            streaksRefs = false,
            rankHistoryRefs = false,
            equippedSlotsRefs = false,
            inventoryRefs = false,
            rankTrialsRefs = false,
            stepMilestonesRefs = false,
            eggsRefs = false,
            companionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (statsRefs) db.stats,
                if (workoutLogsRefs) db.workoutLogs,
                if (streaksRefs) db.streaks,
                if (rankHistoryRefs) db.rankHistory,
                if (equippedSlotsRefs) db.equippedSlots,
                if (inventoryRefs) db.inventory,
                if (rankTrialsRefs) db.rankTrials,
                if (stepMilestonesRefs) db.stepMilestones,
                if (eggsRefs) db.eggs,
                if (companionsRefs) db.companions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (statsRefs)
                    await $_getPrefetchedData<Player, $PlayersTable, Stat>(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences._statsRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(db, table, p0).statsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (workoutLogsRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      WorkoutLog
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._workoutLogsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutLogsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (streaksRefs)
                    await $_getPrefetchedData<Player, $PlayersTable, Streak>(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._streaksRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).streaksRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (rankHistoryRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      RankHistoryData
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._rankHistoryRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).rankHistoryRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (equippedSlotsRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      EquippedSlot
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._equippedSlotsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).equippedSlotsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (inventoryRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      InventoryData
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._inventoryRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (rankTrialsRefs)
                    await $_getPrefetchedData<Player, $PlayersTable, RankTrial>(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._rankTrialsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).rankTrialsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (stepMilestonesRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      StepMilestone
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._stepMilestonesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).stepMilestonesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (eggsRefs)
                    await $_getPrefetchedData<Player, $PlayersTable, Egg>(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences._eggsRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(db, table, p0).eggsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (companionsRefs)
                    await $_getPrefetchedData<Player, $PlayersTable, Companion>(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._companionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).companionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playerId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({
        bool statsRefs,
        bool workoutLogsRefs,
        bool streaksRefs,
        bool rankHistoryRefs,
        bool equippedSlotsRefs,
        bool inventoryRefs,
        bool rankTrialsRefs,
        bool stepMilestonesRefs,
        bool eggsRefs,
        bool companionsRefs,
      })
    >;
typedef $$StatsTableCreateCompanionBuilder =
    StatsCompanion Function({
      Value<int> id,
      required int playerId,
      Value<int> str,
      Value<int> end,
      Value<int> agi,
      Value<DateTime> updatedAt,
    });
typedef $$StatsTableUpdateCompanionBuilder =
    StatsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<int> str,
      Value<int> end,
      Value<int> agi,
      Value<DateTime> updatedAt,
    });

final class $$StatsTableReferences
    extends BaseReferences<_$QuestFitDatabase, $StatsTable, Stat> {
  $$StatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.stats.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StatsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $StatsTable> {
  $$StatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get str => $composableBuilder(
    column: $table.str,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get agi => $composableBuilder(
    column: $table.agi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StatsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $StatsTable> {
  $$StatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get str => $composableBuilder(
    column: $table.str,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get agi => $composableBuilder(
    column: $table.agi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StatsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $StatsTable> {
  $$StatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get str =>
      $composableBuilder(column: $table.str, builder: (column) => column);

  GeneratedColumn<int> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<int> get agi =>
      $composableBuilder(column: $table.agi, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StatsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $StatsTable,
          Stat,
          $$StatsTableFilterComposer,
          $$StatsTableOrderingComposer,
          $$StatsTableAnnotationComposer,
          $$StatsTableCreateCompanionBuilder,
          $$StatsTableUpdateCompanionBuilder,
          (Stat, $$StatsTableReferences),
          Stat,
          PrefetchHooks Function({bool playerId})
        > {
  $$StatsTableTableManager(_$QuestFitDatabase db, $StatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$StatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> str = const Value.absent(),
                Value<int> end = const Value.absent(),
                Value<int> agi = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StatsCompanion(
                id: id,
                playerId: playerId,
                str: str,
                end: end,
                agi: agi,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                Value<int> str = const Value.absent(),
                Value<int> end = const Value.absent(),
                Value<int> agi = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StatsCompanion.insert(
                id: id,
                playerId: playerId,
                str: str,
                end: end,
                agi: agi,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$StatsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$StatsTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$StatsTableReferences._playerIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StatsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $StatsTable,
      Stat,
      $$StatsTableFilterComposer,
      $$StatsTableOrderingComposer,
      $$StatsTableAnnotationComposer,
      $$StatsTableCreateCompanionBuilder,
      $$StatsTableUpdateCompanionBuilder,
      (Stat, $$StatsTableReferences),
      Stat,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$QuestsTableCreateCompanionBuilder =
    QuestsCompanion Function({
      Value<int> id,
      required String title,
      required String category,
      required String description,
      Value<int?> sets,
      Value<int?> reps,
      Value<int?> duration,
      required int xpReward,
      Value<int> lpReward,
      Value<int> goldReward,
      Value<bool> isDaily,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
    });
typedef $$QuestsTableUpdateCompanionBuilder =
    QuestsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> category,
      Value<String> description,
      Value<int?> sets,
      Value<int?> reps,
      Value<int?> duration,
      Value<int> xpReward,
      Value<int> lpReward,
      Value<int> goldReward,
      Value<bool> isDaily,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
    });

final class $$QuestsTableReferences
    extends BaseReferences<_$QuestFitDatabase, $QuestsTable, Quest> {
  $$QuestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutLogsTable, List<WorkoutLog>>
  _workoutLogsRefsTable(_$QuestFitDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutLogs,
    aliasName: $_aliasNameGenerator(db.quests.id, db.workoutLogs.questId),
  );

  $$WorkoutLogsTableProcessedTableManager get workoutLogsRefs {
    final manager = $$WorkoutLogsTableTableManager(
      $_db,
      $_db.workoutLogs,
    ).filter((f) => f.questId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $QuestsTable> {
  $$QuestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lpReward => $composableBuilder(
    column: $table.lpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goldReward => $composableBuilder(
    column: $table.goldReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDaily => $composableBuilder(
    column: $table.isDaily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutLogsRefs(
    Expression<bool> Function($$WorkoutLogsTableFilterComposer f) f,
  ) {
    final $$WorkoutLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutLogs,
      getReferencedColumn: (t) => t.questId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutLogsTableFilterComposer(
            $db: $db,
            $table: $db.workoutLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $QuestsTable> {
  $$QuestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lpReward => $composableBuilder(
    column: $table.lpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goldReward => $composableBuilder(
    column: $table.goldReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDaily => $composableBuilder(
    column: $table.isDaily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $QuestsTable> {
  $$QuestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<int> get lpReward =>
      $composableBuilder(column: $table.lpReward, builder: (column) => column);

  GeneratedColumn<int> get goldReward => $composableBuilder(
    column: $table.goldReward,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDaily =>
      $composableBuilder(column: $table.isDaily, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> workoutLogsRefs<T extends Object>(
    Expression<T> Function($$WorkoutLogsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutLogs,
      getReferencedColumn: (t) => t.questId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $QuestsTable,
          Quest,
          $$QuestsTableFilterComposer,
          $$QuestsTableOrderingComposer,
          $$QuestsTableAnnotationComposer,
          $$QuestsTableCreateCompanionBuilder,
          $$QuestsTableUpdateCompanionBuilder,
          (Quest, $$QuestsTableReferences),
          Quest,
          PrefetchHooks Function({bool workoutLogsRefs})
        > {
  $$QuestsTableTableManager(_$QuestFitDatabase db, $QuestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$QuestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$QuestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$QuestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int?> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<int> lpReward = const Value.absent(),
                Value<int> goldReward = const Value.absent(),
                Value<bool> isDaily = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuestsCompanion(
                id: id,
                title: title,
                category: category,
                description: description,
                sets: sets,
                reps: reps,
                duration: duration,
                xpReward: xpReward,
                lpReward: lpReward,
                goldReward: goldReward,
                isDaily: isDaily,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String category,
                required String description,
                Value<int?> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                required int xpReward,
                Value<int> lpReward = const Value.absent(),
                Value<int> goldReward = const Value.absent(),
                Value<bool> isDaily = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuestsCompanion.insert(
                id: id,
                title: title,
                category: category,
                description: description,
                sets: sets,
                reps: reps,
                duration: duration,
                xpReward: xpReward,
                lpReward: lpReward,
                goldReward: goldReward,
                isDaily: isDaily,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$QuestsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({workoutLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workoutLogsRefs) db.workoutLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutLogsRefs)
                    await $_getPrefetchedData<Quest, $QuestsTable, WorkoutLog>(
                      currentTable: table,
                      referencedTable: $$QuestsTableReferences
                          ._workoutLogsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$QuestsTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutLogsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.questId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$QuestsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $QuestsTable,
      Quest,
      $$QuestsTableFilterComposer,
      $$QuestsTableOrderingComposer,
      $$QuestsTableAnnotationComposer,
      $$QuestsTableCreateCompanionBuilder,
      $$QuestsTableUpdateCompanionBuilder,
      (Quest, $$QuestsTableReferences),
      Quest,
      PrefetchHooks Function({bool workoutLogsRefs})
    >;
typedef $$WorkoutLogsTableCreateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<int> id,
      Value<int?> questId,
      required int playerId,
      required DateTime completedAt,
      required int xpEarned,
      Value<String> source,
      Value<String?> healthConnectId,
    });
typedef $$WorkoutLogsTableUpdateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<int> id,
      Value<int?> questId,
      Value<int> playerId,
      Value<DateTime> completedAt,
      Value<int> xpEarned,
      Value<String> source,
      Value<String?> healthConnectId,
    });

final class $$WorkoutLogsTableReferences
    extends BaseReferences<_$QuestFitDatabase, $WorkoutLogsTable, WorkoutLog> {
  $$WorkoutLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestsTable _questIdTable(_$QuestFitDatabase db) => db.quests
      .createAlias($_aliasNameGenerator(db.workoutLogs.questId, db.quests.id));

  $$QuestsTableProcessedTableManager? get questId {
    final $_column = $_itemColumn<int>('quest_id');
    if ($_column == null) return null;
    final manager = $$QuestsTableTableManager(
      $_db,
      $_db.quests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.workoutLogs.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutLogsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthConnectId => $composableBuilder(
    column: $table.healthConnectId,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestsTableFilterComposer get questId {
    final $$QuestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questId,
      referencedTable: $db.quests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestsTableFilterComposer(
            $db: $db,
            $table: $db.quests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutLogsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthConnectId => $composableBuilder(
    column: $table.healthConnectId,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestsTableOrderingComposer get questId {
    final $$QuestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questId,
      referencedTable: $db.quests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestsTableOrderingComposer(
            $db: $db,
            $table: $db.quests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutLogsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get healthConnectId => $composableBuilder(
    column: $table.healthConnectId,
    builder: (column) => column,
  );

  $$QuestsTableAnnotationComposer get questId {
    final $$QuestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questId,
      referencedTable: $db.quests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestsTableAnnotationComposer(
            $db: $db,
            $table: $db.quests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutLogsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $WorkoutLogsTable,
          WorkoutLog,
          $$WorkoutLogsTableFilterComposer,
          $$WorkoutLogsTableOrderingComposer,
          $$WorkoutLogsTableAnnotationComposer,
          $$WorkoutLogsTableCreateCompanionBuilder,
          $$WorkoutLogsTableUpdateCompanionBuilder,
          (WorkoutLog, $$WorkoutLogsTableReferences),
          WorkoutLog,
          PrefetchHooks Function({bool questId, bool playerId})
        > {
  $$WorkoutLogsTableTableManager(_$QuestFitDatabase db, $WorkoutLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorkoutLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorkoutLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$WorkoutLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> questId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> healthConnectId = const Value.absent(),
              }) => WorkoutLogsCompanion(
                id: id,
                questId: questId,
                playerId: playerId,
                completedAt: completedAt,
                xpEarned: xpEarned,
                source: source,
                healthConnectId: healthConnectId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> questId = const Value.absent(),
                required int playerId,
                required DateTime completedAt,
                required int xpEarned,
                Value<String> source = const Value.absent(),
                Value<String?> healthConnectId = const Value.absent(),
              }) => WorkoutLogsCompanion.insert(
                id: id,
                questId: questId,
                playerId: playerId,
                completedAt: completedAt,
                xpEarned: xpEarned,
                source: source,
                healthConnectId: healthConnectId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WorkoutLogsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({questId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (questId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.questId,
                            referencedTable: $$WorkoutLogsTableReferences
                                ._questIdTable(db),
                            referencedColumn:
                                $$WorkoutLogsTableReferences
                                    ._questIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$WorkoutLogsTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$WorkoutLogsTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $WorkoutLogsTable,
      WorkoutLog,
      $$WorkoutLogsTableFilterComposer,
      $$WorkoutLogsTableOrderingComposer,
      $$WorkoutLogsTableAnnotationComposer,
      $$WorkoutLogsTableCreateCompanionBuilder,
      $$WorkoutLogsTableUpdateCompanionBuilder,
      (WorkoutLog, $$WorkoutLogsTableReferences),
      WorkoutLog,
      PrefetchHooks Function({bool questId, bool playerId})
    >;
typedef $$StreaksTableCreateCompanionBuilder =
    StreaksCompanion Function({
      Value<int> id,
      required int playerId,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<String?> lastActiveDate,
    });
typedef $$StreaksTableUpdateCompanionBuilder =
    StreaksCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<String?> lastActiveDate,
    });

final class $$StreaksTableReferences
    extends BaseReferences<_$QuestFitDatabase, $StreaksTable, Streak> {
  $$StreaksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.streaks.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StreaksTableFilterComposer
    extends Composer<_$QuestFitDatabase, $StreaksTable> {
  $$StreaksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StreaksTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $StreaksTable> {
  $$StreaksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StreaksTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $StreaksTable> {
  $$StreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => column,
  );

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StreaksTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $StreaksTable,
          Streak,
          $$StreaksTableFilterComposer,
          $$StreaksTableOrderingComposer,
          $$StreaksTableAnnotationComposer,
          $$StreaksTableCreateCompanionBuilder,
          $$StreaksTableUpdateCompanionBuilder,
          (Streak, $$StreaksTableReferences),
          Streak,
          PrefetchHooks Function({bool playerId})
        > {
  $$StreaksTableTableManager(_$QuestFitDatabase db, $StreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$StreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<String?> lastActiveDate = const Value.absent(),
              }) => StreaksCompanion(
                id: id,
                playerId: playerId,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastActiveDate: lastActiveDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<String?> lastActiveDate = const Value.absent(),
              }) => StreaksCompanion.insert(
                id: id,
                playerId: playerId,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastActiveDate: lastActiveDate,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$StreaksTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$StreaksTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$StreaksTableReferences._playerIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $StreaksTable,
      Streak,
      $$StreaksTableFilterComposer,
      $$StreaksTableOrderingComposer,
      $$StreaksTableAnnotationComposer,
      $$StreaksTableCreateCompanionBuilder,
      $$StreaksTableUpdateCompanionBuilder,
      (Streak, $$StreaksTableReferences),
      Streak,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$RankHistoryTableCreateCompanionBuilder =
    RankHistoryCompanion Function({
      Value<int> id,
      required int playerId,
      required String rank,
      Value<DateTime> achievedAt,
    });
typedef $$RankHistoryTableUpdateCompanionBuilder =
    RankHistoryCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> rank,
      Value<DateTime> achievedAt,
    });

final class $$RankHistoryTableReferences
    extends
        BaseReferences<_$QuestFitDatabase, $RankHistoryTable, RankHistoryData> {
  $$RankHistoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.rankHistory.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RankHistoryTableFilterComposer
    extends Composer<_$QuestFitDatabase, $RankHistoryTable> {
  $$RankHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RankHistoryTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $RankHistoryTable> {
  $$RankHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RankHistoryTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $RankHistoryTable> {
  $$RankHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RankHistoryTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $RankHistoryTable,
          RankHistoryData,
          $$RankHistoryTableFilterComposer,
          $$RankHistoryTableOrderingComposer,
          $$RankHistoryTableAnnotationComposer,
          $$RankHistoryTableCreateCompanionBuilder,
          $$RankHistoryTableUpdateCompanionBuilder,
          (RankHistoryData, $$RankHistoryTableReferences),
          RankHistoryData,
          PrefetchHooks Function({bool playerId})
        > {
  $$RankHistoryTableTableManager(_$QuestFitDatabase db, $RankHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RankHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RankHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$RankHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
              }) => RankHistoryCompanion(
                id: id,
                playerId: playerId,
                rank: rank,
                achievedAt: achievedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String rank,
                Value<DateTime> achievedAt = const Value.absent(),
              }) => RankHistoryCompanion.insert(
                id: id,
                playerId: playerId,
                rank: rank,
                achievedAt: achievedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RankHistoryTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$RankHistoryTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$RankHistoryTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RankHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $RankHistoryTable,
      RankHistoryData,
      $$RankHistoryTableFilterComposer,
      $$RankHistoryTableOrderingComposer,
      $$RankHistoryTableAnnotationComposer,
      $$RankHistoryTableCreateCompanionBuilder,
      $$RankHistoryTableUpdateCompanionBuilder,
      (RankHistoryData, $$RankHistoryTableReferences),
      RankHistoryData,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$EquipmentTableCreateCompanionBuilder =
    EquipmentCompanion Function({
      Value<int> id,
      required String key,
      required String name,
      required String description,
      Value<String> rarity,
      required String imagePath,
      required String category,
      Value<bool> isOwned,
      Value<int> price,
    });
typedef $$EquipmentTableUpdateCompanionBuilder =
    EquipmentCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> name,
      Value<String> description,
      Value<String> rarity,
      Value<String> imagePath,
      Value<String> category,
      Value<bool> isOwned,
      Value<int> price,
    });

final class $$EquipmentTableReferences
    extends BaseReferences<_$QuestFitDatabase, $EquipmentTable, EquipmentData> {
  $$EquipmentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EquipmentExercisesTable, List<EquipmentExercise>>
  _equipmentExercisesRefsTable(_$QuestFitDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.equipmentExercises,
        aliasName: $_aliasNameGenerator(
          db.equipment.id,
          db.equipmentExercises.equipmentId,
        ),
      );

  $$EquipmentExercisesTableProcessedTableManager get equipmentExercisesRefs {
    final manager = $$EquipmentExercisesTableTableManager(
      $_db,
      $_db.equipmentExercises,
    ).filter((f) => f.equipmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _equipmentExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EquippedSlotsTable, List<EquippedSlot>>
  _equippedSlotsRefsTable(_$QuestFitDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.equippedSlots,
        aliasName: $_aliasNameGenerator(
          db.equipment.id,
          db.equippedSlots.equipmentId,
        ),
      );

  $$EquippedSlotsTableProcessedTableManager get equippedSlotsRefs {
    final manager = $$EquippedSlotsTableTableManager(
      $_db,
      $_db.equippedSlots,
    ).filter((f) => f.equipmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_equippedSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EquipmentTableFilterComposer
    extends Composer<_$QuestFitDatabase, $EquipmentTable> {
  $$EquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOwned => $composableBuilder(
    column: $table.isOwned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> equipmentExercisesRefs(
    Expression<bool> Function($$EquipmentExercisesTableFilterComposer f) f,
  ) {
    final $$EquipmentExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equipmentExercises,
      getReferencedColumn: (t) => t.equipmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentExercisesTableFilterComposer(
            $db: $db,
            $table: $db.equipmentExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> equippedSlotsRefs(
    Expression<bool> Function($$EquippedSlotsTableFilterComposer f) f,
  ) {
    final $$EquippedSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equippedSlots,
      getReferencedColumn: (t) => t.equipmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquippedSlotsTableFilterComposer(
            $db: $db,
            $table: $db.equippedSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquipmentTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $EquipmentTable> {
  $$EquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOwned => $composableBuilder(
    column: $table.isOwned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipmentTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $EquipmentTable> {
  $$EquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isOwned =>
      $composableBuilder(column: $table.isOwned, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  Expression<T> equipmentExercisesRefs<T extends Object>(
    Expression<T> Function($$EquipmentExercisesTableAnnotationComposer a) f,
  ) {
    final $$EquipmentExercisesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.equipmentExercises,
          getReferencedColumn: (t) => t.equipmentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EquipmentExercisesTableAnnotationComposer(
                $db: $db,
                $table: $db.equipmentExercises,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> equippedSlotsRefs<T extends Object>(
    Expression<T> Function($$EquippedSlotsTableAnnotationComposer a) f,
  ) {
    final $$EquippedSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equippedSlots,
      getReferencedColumn: (t) => t.equipmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquippedSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.equippedSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquipmentTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $EquipmentTable,
          EquipmentData,
          $$EquipmentTableFilterComposer,
          $$EquipmentTableOrderingComposer,
          $$EquipmentTableAnnotationComposer,
          $$EquipmentTableCreateCompanionBuilder,
          $$EquipmentTableUpdateCompanionBuilder,
          (EquipmentData, $$EquipmentTableReferences),
          EquipmentData,
          PrefetchHooks Function({
            bool equipmentExercisesRefs,
            bool equippedSlotsRefs,
          })
        > {
  $$EquipmentTableTableManager(_$QuestFitDatabase db, $EquipmentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> rarity = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isOwned = const Value.absent(),
                Value<int> price = const Value.absent(),
              }) => EquipmentCompanion(
                id: id,
                key: key,
                name: name,
                description: description,
                rarity: rarity,
                imagePath: imagePath,
                category: category,
                isOwned: isOwned,
                price: price,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String name,
                required String description,
                Value<String> rarity = const Value.absent(),
                required String imagePath,
                required String category,
                Value<bool> isOwned = const Value.absent(),
                Value<int> price = const Value.absent(),
              }) => EquipmentCompanion.insert(
                id: id,
                key: key,
                name: name,
                description: description,
                rarity: rarity,
                imagePath: imagePath,
                category: category,
                isOwned: isOwned,
                price: price,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EquipmentTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            equipmentExercisesRefs = false,
            equippedSlotsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (equipmentExercisesRefs) db.equipmentExercises,
                if (equippedSlotsRefs) db.equippedSlots,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (equipmentExercisesRefs)
                    await $_getPrefetchedData<
                      EquipmentData,
                      $EquipmentTable,
                      EquipmentExercise
                    >(
                      currentTable: table,
                      referencedTable: $$EquipmentTableReferences
                          ._equipmentExercisesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$EquipmentTableReferences(
                                db,
                                table,
                                p0,
                              ).equipmentExercisesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.equipmentId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (equippedSlotsRefs)
                    await $_getPrefetchedData<
                      EquipmentData,
                      $EquipmentTable,
                      EquippedSlot
                    >(
                      currentTable: table,
                      referencedTable: $$EquipmentTableReferences
                          ._equippedSlotsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$EquipmentTableReferences(
                                db,
                                table,
                                p0,
                              ).equippedSlotsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.equipmentId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EquipmentTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $EquipmentTable,
      EquipmentData,
      $$EquipmentTableFilterComposer,
      $$EquipmentTableOrderingComposer,
      $$EquipmentTableAnnotationComposer,
      $$EquipmentTableCreateCompanionBuilder,
      $$EquipmentTableUpdateCompanionBuilder,
      (EquipmentData, $$EquipmentTableReferences),
      EquipmentData,
      PrefetchHooks Function({
        bool equipmentExercisesRefs,
        bool equippedSlotsRefs,
      })
    >;
typedef $$EquipmentExercisesTableCreateCompanionBuilder =
    EquipmentExercisesCompanion Function({
      Value<int> id,
      required int equipmentId,
      required String exerciseTitle,
      required String exerciseCategory,
      Value<int?> sets,
      Value<int?> reps,
      Value<int?> duration,
      required int baseXp,
      Value<String> emoji,
    });
typedef $$EquipmentExercisesTableUpdateCompanionBuilder =
    EquipmentExercisesCompanion Function({
      Value<int> id,
      Value<int> equipmentId,
      Value<String> exerciseTitle,
      Value<String> exerciseCategory,
      Value<int?> sets,
      Value<int?> reps,
      Value<int?> duration,
      Value<int> baseXp,
      Value<String> emoji,
    });

final class $$EquipmentExercisesTableReferences
    extends
        BaseReferences<
          _$QuestFitDatabase,
          $EquipmentExercisesTable,
          EquipmentExercise
        > {
  $$EquipmentExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EquipmentTable _equipmentIdTable(_$QuestFitDatabase db) =>
      db.equipment.createAlias(
        $_aliasNameGenerator(
          db.equipmentExercises.equipmentId,
          db.equipment.id,
        ),
      );

  $$EquipmentTableProcessedTableManager get equipmentId {
    final $_column = $_itemColumn<int>('equipment_id')!;

    final manager = $$EquipmentTableTableManager(
      $_db,
      $_db.equipment,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_equipmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EquipmentExercisesTableFilterComposer
    extends Composer<_$QuestFitDatabase, $EquipmentExercisesTable> {
  $$EquipmentExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseTitle => $composableBuilder(
    column: $table.exerciseTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseCategory => $composableBuilder(
    column: $table.exerciseCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseXp => $composableBuilder(
    column: $table.baseXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  $$EquipmentTableFilterComposer get equipmentId {
    final $$EquipmentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableFilterComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquipmentExercisesTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $EquipmentExercisesTable> {
  $$EquipmentExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseTitle => $composableBuilder(
    column: $table.exerciseTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseCategory => $composableBuilder(
    column: $table.exerciseCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseXp => $composableBuilder(
    column: $table.baseXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  $$EquipmentTableOrderingComposer get equipmentId {
    final $$EquipmentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableOrderingComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquipmentExercisesTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $EquipmentExercisesTable> {
  $$EquipmentExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseTitle => $composableBuilder(
    column: $table.exerciseTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseCategory => $composableBuilder(
    column: $table.exerciseCategory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get baseXp =>
      $composableBuilder(column: $table.baseXp, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  $$EquipmentTableAnnotationComposer get equipmentId {
    final $$EquipmentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableAnnotationComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquipmentExercisesTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $EquipmentExercisesTable,
          EquipmentExercise,
          $$EquipmentExercisesTableFilterComposer,
          $$EquipmentExercisesTableOrderingComposer,
          $$EquipmentExercisesTableAnnotationComposer,
          $$EquipmentExercisesTableCreateCompanionBuilder,
          $$EquipmentExercisesTableUpdateCompanionBuilder,
          (EquipmentExercise, $$EquipmentExercisesTableReferences),
          EquipmentExercise,
          PrefetchHooks Function({bool equipmentId})
        > {
  $$EquipmentExercisesTableTableManager(
    _$QuestFitDatabase db,
    $EquipmentExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EquipmentExercisesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$EquipmentExercisesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EquipmentExercisesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> equipmentId = const Value.absent(),
                Value<String> exerciseTitle = const Value.absent(),
                Value<String> exerciseCategory = const Value.absent(),
                Value<int?> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int> baseXp = const Value.absent(),
                Value<String> emoji = const Value.absent(),
              }) => EquipmentExercisesCompanion(
                id: id,
                equipmentId: equipmentId,
                exerciseTitle: exerciseTitle,
                exerciseCategory: exerciseCategory,
                sets: sets,
                reps: reps,
                duration: duration,
                baseXp: baseXp,
                emoji: emoji,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int equipmentId,
                required String exerciseTitle,
                required String exerciseCategory,
                Value<int?> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                required int baseXp,
                Value<String> emoji = const Value.absent(),
              }) => EquipmentExercisesCompanion.insert(
                id: id,
                equipmentId: equipmentId,
                exerciseTitle: exerciseTitle,
                exerciseCategory: exerciseCategory,
                sets: sets,
                reps: reps,
                duration: duration,
                baseXp: baseXp,
                emoji: emoji,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EquipmentExercisesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({equipmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (equipmentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.equipmentId,
                            referencedTable: $$EquipmentExercisesTableReferences
                                ._equipmentIdTable(db),
                            referencedColumn:
                                $$EquipmentExercisesTableReferences
                                    ._equipmentIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EquipmentExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $EquipmentExercisesTable,
      EquipmentExercise,
      $$EquipmentExercisesTableFilterComposer,
      $$EquipmentExercisesTableOrderingComposer,
      $$EquipmentExercisesTableAnnotationComposer,
      $$EquipmentExercisesTableCreateCompanionBuilder,
      $$EquipmentExercisesTableUpdateCompanionBuilder,
      (EquipmentExercise, $$EquipmentExercisesTableReferences),
      EquipmentExercise,
      PrefetchHooks Function({bool equipmentId})
    >;
typedef $$EquippedSlotsTableCreateCompanionBuilder =
    EquippedSlotsCompanion Function({
      Value<int> id,
      required int playerId,
      required int slotIndex,
      required int equipmentId,
    });
typedef $$EquippedSlotsTableUpdateCompanionBuilder =
    EquippedSlotsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<int> slotIndex,
      Value<int> equipmentId,
    });

final class $$EquippedSlotsTableReferences
    extends
        BaseReferences<_$QuestFitDatabase, $EquippedSlotsTable, EquippedSlot> {
  $$EquippedSlotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.equippedSlots.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EquipmentTable _equipmentIdTable(_$QuestFitDatabase db) =>
      db.equipment.createAlias(
        $_aliasNameGenerator(db.equippedSlots.equipmentId, db.equipment.id),
      );

  $$EquipmentTableProcessedTableManager get equipmentId {
    final $_column = $_itemColumn<int>('equipment_id')!;

    final manager = $$EquipmentTableTableManager(
      $_db,
      $_db.equipment,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_equipmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EquippedSlotsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $EquippedSlotsTable> {
  $$EquippedSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EquipmentTableFilterComposer get equipmentId {
    final $$EquipmentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableFilterComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquippedSlotsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $EquippedSlotsTable> {
  $$EquippedSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EquipmentTableOrderingComposer get equipmentId {
    final $$EquipmentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableOrderingComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquippedSlotsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $EquippedSlotsTable> {
  $$EquippedSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get slotIndex =>
      $composableBuilder(column: $table.slotIndex, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EquipmentTableAnnotationComposer get equipmentId {
    final $$EquipmentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableAnnotationComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquippedSlotsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $EquippedSlotsTable,
          EquippedSlot,
          $$EquippedSlotsTableFilterComposer,
          $$EquippedSlotsTableOrderingComposer,
          $$EquippedSlotsTableAnnotationComposer,
          $$EquippedSlotsTableCreateCompanionBuilder,
          $$EquippedSlotsTableUpdateCompanionBuilder,
          (EquippedSlot, $$EquippedSlotsTableReferences),
          EquippedSlot,
          PrefetchHooks Function({bool playerId, bool equipmentId})
        > {
  $$EquippedSlotsTableTableManager(
    _$QuestFitDatabase db,
    $EquippedSlotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EquippedSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$EquippedSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EquippedSlotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> slotIndex = const Value.absent(),
                Value<int> equipmentId = const Value.absent(),
              }) => EquippedSlotsCompanion(
                id: id,
                playerId: playerId,
                slotIndex: slotIndex,
                equipmentId: equipmentId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required int slotIndex,
                required int equipmentId,
              }) => EquippedSlotsCompanion.insert(
                id: id,
                playerId: playerId,
                slotIndex: slotIndex,
                equipmentId: equipmentId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EquippedSlotsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false, equipmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$EquippedSlotsTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$EquippedSlotsTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (equipmentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.equipmentId,
                            referencedTable: $$EquippedSlotsTableReferences
                                ._equipmentIdTable(db),
                            referencedColumn:
                                $$EquippedSlotsTableReferences
                                    ._equipmentIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EquippedSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $EquippedSlotsTable,
      EquippedSlot,
      $$EquippedSlotsTableFilterComposer,
      $$EquippedSlotsTableOrderingComposer,
      $$EquippedSlotsTableAnnotationComposer,
      $$EquippedSlotsTableCreateCompanionBuilder,
      $$EquippedSlotsTableUpdateCompanionBuilder,
      (EquippedSlot, $$EquippedSlotsTableReferences),
      EquippedSlot,
      PrefetchHooks Function({bool playerId, bool equipmentId})
    >;
typedef $$InventoryTableCreateCompanionBuilder =
    InventoryCompanion Function({
      Value<int> id,
      required int playerId,
      required String itemKey,
      Value<int> quantity,
    });
typedef $$InventoryTableUpdateCompanionBuilder =
    InventoryCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> itemKey,
      Value<int> quantity,
    });

final class $$InventoryTableReferences
    extends BaseReferences<_$QuestFitDatabase, $InventoryTable, InventoryData> {
  $$InventoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.inventory.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryTableFilterComposer
    extends Composer<_$QuestFitDatabase, $InventoryTable> {
  $$InventoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemKey => $composableBuilder(
    column: $table.itemKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $InventoryTable> {
  $$InventoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemKey => $composableBuilder(
    column: $table.itemKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $InventoryTable> {
  $$InventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemKey =>
      $composableBuilder(column: $table.itemKey, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $InventoryTable,
          InventoryData,
          $$InventoryTableFilterComposer,
          $$InventoryTableOrderingComposer,
          $$InventoryTableAnnotationComposer,
          $$InventoryTableCreateCompanionBuilder,
          $$InventoryTableUpdateCompanionBuilder,
          (InventoryData, $$InventoryTableReferences),
          InventoryData,
          PrefetchHooks Function({bool playerId})
        > {
  $$InventoryTableTableManager(_$QuestFitDatabase db, $InventoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$InventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$InventoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> itemKey = const Value.absent(),
                Value<int> quantity = const Value.absent(),
              }) => InventoryCompanion(
                id: id,
                playerId: playerId,
                itemKey: itemKey,
                quantity: quantity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String itemKey,
                Value<int> quantity = const Value.absent(),
              }) => InventoryCompanion.insert(
                id: id,
                playerId: playerId,
                itemKey: itemKey,
                quantity: quantity,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$InventoryTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$InventoryTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$InventoryTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $InventoryTable,
      InventoryData,
      $$InventoryTableFilterComposer,
      $$InventoryTableOrderingComposer,
      $$InventoryTableAnnotationComposer,
      $$InventoryTableCreateCompanionBuilder,
      $$InventoryTableUpdateCompanionBuilder,
      (InventoryData, $$InventoryTableReferences),
      InventoryData,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$RankTrialsTableCreateCompanionBuilder =
    RankTrialsCompanion Function({
      Value<int> id,
      required int playerId,
      required String targetRank,
      required String trialType,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
      Value<int> streakDaysCompleted,
      Value<int> requiredStreakDays,
      Value<int?> calorieGoal,
      Value<int?> stepGoal,
      Value<int> caloriesAchieved,
      Value<int> stepsAchieved,
    });
typedef $$RankTrialsTableUpdateCompanionBuilder =
    RankTrialsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> targetRank,
      Value<String> trialType,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
      Value<int> streakDaysCompleted,
      Value<int> requiredStreakDays,
      Value<int?> calorieGoal,
      Value<int?> stepGoal,
      Value<int> caloriesAchieved,
      Value<int> stepsAchieved,
    });

final class $$RankTrialsTableReferences
    extends BaseReferences<_$QuestFitDatabase, $RankTrialsTable, RankTrial> {
  $$RankTrialsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.rankTrials.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RankTrialsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $RankTrialsTable> {
  $$RankTrialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetRank => $composableBuilder(
    column: $table.targetRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trialType => $composableBuilder(
    column: $table.trialType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDaysCompleted => $composableBuilder(
    column: $table.streakDaysCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get requiredStreakDays => $composableBuilder(
    column: $table.requiredStreakDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calorieGoal => $composableBuilder(
    column: $table.calorieGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepGoal => $composableBuilder(
    column: $table.stepGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesAchieved => $composableBuilder(
    column: $table.caloriesAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepsAchieved => $composableBuilder(
    column: $table.stepsAchieved,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RankTrialsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $RankTrialsTable> {
  $$RankTrialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetRank => $composableBuilder(
    column: $table.targetRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trialType => $composableBuilder(
    column: $table.trialType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDaysCompleted => $composableBuilder(
    column: $table.streakDaysCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get requiredStreakDays => $composableBuilder(
    column: $table.requiredStreakDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calorieGoal => $composableBuilder(
    column: $table.calorieGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepGoal => $composableBuilder(
    column: $table.stepGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesAchieved => $composableBuilder(
    column: $table.caloriesAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepsAchieved => $composableBuilder(
    column: $table.stepsAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RankTrialsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $RankTrialsTable> {
  $$RankTrialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetRank => $composableBuilder(
    column: $table.targetRank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trialType =>
      $composableBuilder(column: $table.trialType, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get streakDaysCompleted => $composableBuilder(
    column: $table.streakDaysCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get requiredStreakDays => $composableBuilder(
    column: $table.requiredStreakDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calorieGoal => $composableBuilder(
    column: $table.calorieGoal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepGoal =>
      $composableBuilder(column: $table.stepGoal, builder: (column) => column);

  GeneratedColumn<int> get caloriesAchieved => $composableBuilder(
    column: $table.caloriesAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepsAchieved => $composableBuilder(
    column: $table.stepsAchieved,
    builder: (column) => column,
  );

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RankTrialsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $RankTrialsTable,
          RankTrial,
          $$RankTrialsTableFilterComposer,
          $$RankTrialsTableOrderingComposer,
          $$RankTrialsTableAnnotationComposer,
          $$RankTrialsTableCreateCompanionBuilder,
          $$RankTrialsTableUpdateCompanionBuilder,
          (RankTrial, $$RankTrialsTableReferences),
          RankTrial,
          PrefetchHooks Function({bool playerId})
        > {
  $$RankTrialsTableTableManager(_$QuestFitDatabase db, $RankTrialsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RankTrialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RankTrialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RankTrialsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> targetRank = const Value.absent(),
                Value<String> trialType = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> streakDaysCompleted = const Value.absent(),
                Value<int> requiredStreakDays = const Value.absent(),
                Value<int?> calorieGoal = const Value.absent(),
                Value<int?> stepGoal = const Value.absent(),
                Value<int> caloriesAchieved = const Value.absent(),
                Value<int> stepsAchieved = const Value.absent(),
              }) => RankTrialsCompanion(
                id: id,
                playerId: playerId,
                targetRank: targetRank,
                trialType: trialType,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                streakDaysCompleted: streakDaysCompleted,
                requiredStreakDays: requiredStreakDays,
                calorieGoal: calorieGoal,
                stepGoal: stepGoal,
                caloriesAchieved: caloriesAchieved,
                stepsAchieved: stepsAchieved,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String targetRank,
                required String trialType,
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> streakDaysCompleted = const Value.absent(),
                Value<int> requiredStreakDays = const Value.absent(),
                Value<int?> calorieGoal = const Value.absent(),
                Value<int?> stepGoal = const Value.absent(),
                Value<int> caloriesAchieved = const Value.absent(),
                Value<int> stepsAchieved = const Value.absent(),
              }) => RankTrialsCompanion.insert(
                id: id,
                playerId: playerId,
                targetRank: targetRank,
                trialType: trialType,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                streakDaysCompleted: streakDaysCompleted,
                requiredStreakDays: requiredStreakDays,
                calorieGoal: calorieGoal,
                stepGoal: stepGoal,
                caloriesAchieved: caloriesAchieved,
                stepsAchieved: stepsAchieved,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RankTrialsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$RankTrialsTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$RankTrialsTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RankTrialsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $RankTrialsTable,
      RankTrial,
      $$RankTrialsTableFilterComposer,
      $$RankTrialsTableOrderingComposer,
      $$RankTrialsTableAnnotationComposer,
      $$RankTrialsTableCreateCompanionBuilder,
      $$RankTrialsTableUpdateCompanionBuilder,
      (RankTrial, $$RankTrialsTableReferences),
      RankTrial,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$ExerciseDbTableCreateCompanionBuilder =
    ExerciseDbCompanion Function({
      Value<int> id,
      required String externalId,
      required String name,
      Value<String?> force,
      required String level,
      Value<String?> mechanic,
      Value<String?> equipment,
      required String category,
      required String instructions,
      required String primaryMuscles,
      Value<String> secondaryMuscles,
      Value<String> images,
    });
typedef $$ExerciseDbTableUpdateCompanionBuilder =
    ExerciseDbCompanion Function({
      Value<int> id,
      Value<String> externalId,
      Value<String> name,
      Value<String?> force,
      Value<String> level,
      Value<String?> mechanic,
      Value<String?> equipment,
      Value<String> category,
      Value<String> instructions,
      Value<String> primaryMuscles,
      Value<String> secondaryMuscles,
      Value<String> images,
    });

class $$ExerciseDbTableFilterComposer
    extends Composer<_$QuestFitDatabase, $ExerciseDbTable> {
  $$ExerciseDbTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get force => $composableBuilder(
    column: $table.force,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mechanic => $composableBuilder(
    column: $table.mechanic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMuscles => $composableBuilder(
    column: $table.primaryMuscles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get images => $composableBuilder(
    column: $table.images,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseDbTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $ExerciseDbTable> {
  $$ExerciseDbTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get force => $composableBuilder(
    column: $table.force,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mechanic => $composableBuilder(
    column: $table.mechanic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMuscles => $composableBuilder(
    column: $table.primaryMuscles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get images => $composableBuilder(
    column: $table.images,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseDbTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $ExerciseDbTable> {
  $$ExerciseDbTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get force =>
      $composableBuilder(column: $table.force, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get mechanic =>
      $composableBuilder(column: $table.mechanic, builder: (column) => column);

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryMuscles => $composableBuilder(
    column: $table.primaryMuscles,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => column,
  );

  GeneratedColumn<String> get images =>
      $composableBuilder(column: $table.images, builder: (column) => column);
}

class $$ExerciseDbTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $ExerciseDbTable,
          ExerciseDbData,
          $$ExerciseDbTableFilterComposer,
          $$ExerciseDbTableOrderingComposer,
          $$ExerciseDbTableAnnotationComposer,
          $$ExerciseDbTableCreateCompanionBuilder,
          $$ExerciseDbTableUpdateCompanionBuilder,
          (
            ExerciseDbData,
            BaseReferences<
              _$QuestFitDatabase,
              $ExerciseDbTable,
              ExerciseDbData
            >,
          ),
          ExerciseDbData,
          PrefetchHooks Function()
        > {
  $$ExerciseDbTableTableManager(_$QuestFitDatabase db, $ExerciseDbTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ExerciseDbTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ExerciseDbTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ExerciseDbTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> externalId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> force = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String?> mechanic = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<String> primaryMuscles = const Value.absent(),
                Value<String> secondaryMuscles = const Value.absent(),
                Value<String> images = const Value.absent(),
              }) => ExerciseDbCompanion(
                id: id,
                externalId: externalId,
                name: name,
                force: force,
                level: level,
                mechanic: mechanic,
                equipment: equipment,
                category: category,
                instructions: instructions,
                primaryMuscles: primaryMuscles,
                secondaryMuscles: secondaryMuscles,
                images: images,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String externalId,
                required String name,
                Value<String?> force = const Value.absent(),
                required String level,
                Value<String?> mechanic = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                required String category,
                required String instructions,
                required String primaryMuscles,
                Value<String> secondaryMuscles = const Value.absent(),
                Value<String> images = const Value.absent(),
              }) => ExerciseDbCompanion.insert(
                id: id,
                externalId: externalId,
                name: name,
                force: force,
                level: level,
                mechanic: mechanic,
                equipment: equipment,
                category: category,
                instructions: instructions,
                primaryMuscles: primaryMuscles,
                secondaryMuscles: secondaryMuscles,
                images: images,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseDbTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $ExerciseDbTable,
      ExerciseDbData,
      $$ExerciseDbTableFilterComposer,
      $$ExerciseDbTableOrderingComposer,
      $$ExerciseDbTableAnnotationComposer,
      $$ExerciseDbTableCreateCompanionBuilder,
      $$ExerciseDbTableUpdateCompanionBuilder,
      (
        ExerciseDbData,
        BaseReferences<_$QuestFitDatabase, $ExerciseDbTable, ExerciseDbData>,
      ),
      ExerciseDbData,
      PrefetchHooks Function()
    >;
typedef $$StepMilestonesTableCreateCompanionBuilder =
    StepMilestonesCompanion Function({
      Value<int> id,
      required int playerId,
      required String date,
      Value<int> milestonesClaimed,
      Value<int> stepsAtLastClaim,
    });
typedef $$StepMilestonesTableUpdateCompanionBuilder =
    StepMilestonesCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> date,
      Value<int> milestonesClaimed,
      Value<int> stepsAtLastClaim,
    });

final class $$StepMilestonesTableReferences
    extends
        BaseReferences<
          _$QuestFitDatabase,
          $StepMilestonesTable,
          StepMilestone
        > {
  $$StepMilestonesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.stepMilestones.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StepMilestonesTableFilterComposer
    extends Composer<_$QuestFitDatabase, $StepMilestonesTable> {
  $$StepMilestonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get milestonesClaimed => $composableBuilder(
    column: $table.milestonesClaimed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepsAtLastClaim => $composableBuilder(
    column: $table.stepsAtLastClaim,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StepMilestonesTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $StepMilestonesTable> {
  $$StepMilestonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get milestonesClaimed => $composableBuilder(
    column: $table.milestonesClaimed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepsAtLastClaim => $composableBuilder(
    column: $table.stepsAtLastClaim,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StepMilestonesTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $StepMilestonesTable> {
  $$StepMilestonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get milestonesClaimed => $composableBuilder(
    column: $table.milestonesClaimed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepsAtLastClaim => $composableBuilder(
    column: $table.stepsAtLastClaim,
    builder: (column) => column,
  );

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StepMilestonesTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $StepMilestonesTable,
          StepMilestone,
          $$StepMilestonesTableFilterComposer,
          $$StepMilestonesTableOrderingComposer,
          $$StepMilestonesTableAnnotationComposer,
          $$StepMilestonesTableCreateCompanionBuilder,
          $$StepMilestonesTableUpdateCompanionBuilder,
          (StepMilestone, $$StepMilestonesTableReferences),
          StepMilestone,
          PrefetchHooks Function({bool playerId})
        > {
  $$StepMilestonesTableTableManager(
    _$QuestFitDatabase db,
    $StepMilestonesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StepMilestonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$StepMilestonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StepMilestonesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<int> milestonesClaimed = const Value.absent(),
                Value<int> stepsAtLastClaim = const Value.absent(),
              }) => StepMilestonesCompanion(
                id: id,
                playerId: playerId,
                date: date,
                milestonesClaimed: milestonesClaimed,
                stepsAtLastClaim: stepsAtLastClaim,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String date,
                Value<int> milestonesClaimed = const Value.absent(),
                Value<int> stepsAtLastClaim = const Value.absent(),
              }) => StepMilestonesCompanion.insert(
                id: id,
                playerId: playerId,
                date: date,
                milestonesClaimed: milestonesClaimed,
                stepsAtLastClaim: stepsAtLastClaim,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$StepMilestonesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$StepMilestonesTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$StepMilestonesTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StepMilestonesTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $StepMilestonesTable,
      StepMilestone,
      $$StepMilestonesTableFilterComposer,
      $$StepMilestonesTableOrderingComposer,
      $$StepMilestonesTableAnnotationComposer,
      $$StepMilestonesTableCreateCompanionBuilder,
      $$StepMilestonesTableUpdateCompanionBuilder,
      (StepMilestone, $$StepMilestonesTableReferences),
      StepMilestone,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$EggsTableCreateCompanionBuilder =
    EggsCompanion Function({
      Value<int> id,
      required int playerId,
      required String companionType,
      required String rarity,
      required int stepsRequired,
      Value<int> stepsAccumulated,
      Value<DateTime> foundAt,
      Value<DateTime?> hatchedAt,
    });
typedef $$EggsTableUpdateCompanionBuilder =
    EggsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> companionType,
      Value<String> rarity,
      Value<int> stepsRequired,
      Value<int> stepsAccumulated,
      Value<DateTime> foundAt,
      Value<DateTime?> hatchedAt,
    });

final class $$EggsTableReferences
    extends BaseReferences<_$QuestFitDatabase, $EggsTable, Egg> {
  $$EggsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.eggs.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EggsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $EggsTable> {
  $$EggsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companionType => $composableBuilder(
    column: $table.companionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepsRequired => $composableBuilder(
    column: $table.stepsRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepsAccumulated => $composableBuilder(
    column: $table.stepsAccumulated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get foundAt => $composableBuilder(
    column: $table.foundAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get hatchedAt => $composableBuilder(
    column: $table.hatchedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EggsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $EggsTable> {
  $$EggsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companionType => $composableBuilder(
    column: $table.companionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepsRequired => $composableBuilder(
    column: $table.stepsRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepsAccumulated => $composableBuilder(
    column: $table.stepsAccumulated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get foundAt => $composableBuilder(
    column: $table.foundAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get hatchedAt => $composableBuilder(
    column: $table.hatchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EggsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $EggsTable> {
  $$EggsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companionType => $composableBuilder(
    column: $table.companionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<int> get stepsRequired => $composableBuilder(
    column: $table.stepsRequired,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepsAccumulated => $composableBuilder(
    column: $table.stepsAccumulated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get foundAt =>
      $composableBuilder(column: $table.foundAt, builder: (column) => column);

  GeneratedColumn<DateTime> get hatchedAt =>
      $composableBuilder(column: $table.hatchedAt, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EggsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $EggsTable,
          Egg,
          $$EggsTableFilterComposer,
          $$EggsTableOrderingComposer,
          $$EggsTableAnnotationComposer,
          $$EggsTableCreateCompanionBuilder,
          $$EggsTableUpdateCompanionBuilder,
          (Egg, $$EggsTableReferences),
          Egg,
          PrefetchHooks Function({bool playerId})
        > {
  $$EggsTableTableManager(_$QuestFitDatabase db, $EggsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EggsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EggsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EggsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> companionType = const Value.absent(),
                Value<String> rarity = const Value.absent(),
                Value<int> stepsRequired = const Value.absent(),
                Value<int> stepsAccumulated = const Value.absent(),
                Value<DateTime> foundAt = const Value.absent(),
                Value<DateTime?> hatchedAt = const Value.absent(),
              }) => EggsCompanion(
                id: id,
                playerId: playerId,
                companionType: companionType,
                rarity: rarity,
                stepsRequired: stepsRequired,
                stepsAccumulated: stepsAccumulated,
                foundAt: foundAt,
                hatchedAt: hatchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String companionType,
                required String rarity,
                required int stepsRequired,
                Value<int> stepsAccumulated = const Value.absent(),
                Value<DateTime> foundAt = const Value.absent(),
                Value<DateTime?> hatchedAt = const Value.absent(),
              }) => EggsCompanion.insert(
                id: id,
                playerId: playerId,
                companionType: companionType,
                rarity: rarity,
                stepsRequired: stepsRequired,
                stepsAccumulated: stepsAccumulated,
                foundAt: foundAt,
                hatchedAt: hatchedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EggsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$EggsTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$EggsTableReferences._playerIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EggsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $EggsTable,
      Egg,
      $$EggsTableFilterComposer,
      $$EggsTableOrderingComposer,
      $$EggsTableAnnotationComposer,
      $$EggsTableCreateCompanionBuilder,
      $$EggsTableUpdateCompanionBuilder,
      (Egg, $$EggsTableReferences),
      Egg,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$CompanionsTableCreateCompanionBuilder =
    CompanionsCompanion Function({
      Value<int> id,
      required int playerId,
      required String name,
      required String type,
      required String rarity,
      required String buffType,
      Value<int> buffValue,
      Value<bool> isActive,
      Value<DateTime> hatchedAt,
    });
typedef $$CompanionsTableUpdateCompanionBuilder =
    CompanionsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> name,
      Value<String> type,
      Value<String> rarity,
      Value<String> buffType,
      Value<int> buffValue,
      Value<bool> isActive,
      Value<DateTime> hatchedAt,
    });

final class $$CompanionsTableReferences
    extends BaseReferences<_$QuestFitDatabase, $CompanionsTable, Companion> {
  $$CompanionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$QuestFitDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.companions.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CompanionsTableFilterComposer
    extends Composer<_$QuestFitDatabase, $CompanionsTable> {
  $$CompanionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buffType => $composableBuilder(
    column: $table.buffType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buffValue => $composableBuilder(
    column: $table.buffValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get hatchedAt => $composableBuilder(
    column: $table.hatchedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompanionsTableOrderingComposer
    extends Composer<_$QuestFitDatabase, $CompanionsTable> {
  $$CompanionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buffType => $composableBuilder(
    column: $table.buffType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buffValue => $composableBuilder(
    column: $table.buffValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get hatchedAt => $composableBuilder(
    column: $table.hatchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompanionsTableAnnotationComposer
    extends Composer<_$QuestFitDatabase, $CompanionsTable> {
  $$CompanionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get buffType =>
      $composableBuilder(column: $table.buffType, builder: (column) => column);

  GeneratedColumn<int> get buffValue =>
      $composableBuilder(column: $table.buffValue, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get hatchedAt =>
      $composableBuilder(column: $table.hatchedAt, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompanionsTableTableManager
    extends
        RootTableManager<
          _$QuestFitDatabase,
          $CompanionsTable,
          Companion,
          $$CompanionsTableFilterComposer,
          $$CompanionsTableOrderingComposer,
          $$CompanionsTableAnnotationComposer,
          $$CompanionsTableCreateCompanionBuilder,
          $$CompanionsTableUpdateCompanionBuilder,
          (Companion, $$CompanionsTableReferences),
          Companion,
          PrefetchHooks Function({bool playerId})
        > {
  $$CompanionsTableTableManager(_$QuestFitDatabase db, $CompanionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CompanionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CompanionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CompanionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> rarity = const Value.absent(),
                Value<String> buffType = const Value.absent(),
                Value<int> buffValue = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> hatchedAt = const Value.absent(),
              }) => CompanionsCompanion(
                id: id,
                playerId: playerId,
                name: name,
                type: type,
                rarity: rarity,
                buffType: buffType,
                buffValue: buffValue,
                isActive: isActive,
                hatchedAt: hatchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String name,
                required String type,
                required String rarity,
                required String buffType,
                Value<int> buffValue = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> hatchedAt = const Value.absent(),
              }) => CompanionsCompanion.insert(
                id: id,
                playerId: playerId,
                name: name,
                type: type,
                rarity: rarity,
                buffType: buffType,
                buffValue: buffValue,
                isActive: isActive,
                hatchedAt: hatchedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CompanionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playerId,
                            referencedTable: $$CompanionsTableReferences
                                ._playerIdTable(db),
                            referencedColumn:
                                $$CompanionsTableReferences
                                    ._playerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CompanionsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuestFitDatabase,
      $CompanionsTable,
      Companion,
      $$CompanionsTableFilterComposer,
      $$CompanionsTableOrderingComposer,
      $$CompanionsTableAnnotationComposer,
      $$CompanionsTableCreateCompanionBuilder,
      $$CompanionsTableUpdateCompanionBuilder,
      (Companion, $$CompanionsTableReferences),
      Companion,
      PrefetchHooks Function({bool playerId})
    >;

class $QuestFitDatabaseManager {
  final _$QuestFitDatabase _db;
  $QuestFitDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$StatsTableTableManager get stats =>
      $$StatsTableTableManager(_db, _db.stats);
  $$QuestsTableTableManager get quests =>
      $$QuestsTableTableManager(_db, _db.quests);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db, _db.workoutLogs);
  $$StreaksTableTableManager get streaks =>
      $$StreaksTableTableManager(_db, _db.streaks);
  $$RankHistoryTableTableManager get rankHistory =>
      $$RankHistoryTableTableManager(_db, _db.rankHistory);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db, _db.equipment);
  $$EquipmentExercisesTableTableManager get equipmentExercises =>
      $$EquipmentExercisesTableTableManager(_db, _db.equipmentExercises);
  $$EquippedSlotsTableTableManager get equippedSlots =>
      $$EquippedSlotsTableTableManager(_db, _db.equippedSlots);
  $$InventoryTableTableManager get inventory =>
      $$InventoryTableTableManager(_db, _db.inventory);
  $$RankTrialsTableTableManager get rankTrials =>
      $$RankTrialsTableTableManager(_db, _db.rankTrials);
  $$ExerciseDbTableTableManager get exerciseDb =>
      $$ExerciseDbTableTableManager(_db, _db.exerciseDb);
  $$StepMilestonesTableTableManager get stepMilestones =>
      $$StepMilestonesTableTableManager(_db, _db.stepMilestones);
  $$EggsTableTableManager get eggs => $$EggsTableTableManager(_db, _db.eggs);
  $$CompanionsTableTableManager get companions =>
      $$CompanionsTableTableManager(_db, _db.companions);
}
