// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DecksTable extends Decks with TableInfo<$DecksTable, Deck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decks';
  @override
  VerificationContext validateIntegrity(Insertable<Deck> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deck(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DecksTable createAlias(String alias) {
    return $DecksTable(attachedDatabase, alias);
  }
}

class Deck extends DataClass implements Insertable<Deck> {
  final int id;
  final String name;
  final DateTime createdAt;
  const Deck({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DecksCompanion toCompanion(bool nullToAbsent) {
    return DecksCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Deck.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deck(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Deck copyWith({int? id, String? name, DateTime? createdAt}) => Deck(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  Deck copyWithCompanion(DecksCompanion data) {
    return Deck(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deck(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deck &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class DecksCompanion extends UpdateCompanion<Deck> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DecksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Deck> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DecksCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<DateTime>? createdAt}) {
    return DecksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
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
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<int> deckId = GeneratedColumn<int>(
      'deck_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES decks (id) ON DELETE CASCADE'));
  static const VerificationMeta _frontMeta = const VerificationMeta('front');
  @override
  late final GeneratedColumn<String> front = GeneratedColumn<String>(
      'front', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backMeta = const VerificationMeta('back');
  @override
  late final GeneratedColumn<String> back = GeneratedColumn<String>(
      'back', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _frontImagePathMeta =
      const VerificationMeta('frontImagePath');
  @override
  late final GeneratedColumn<String> frontImagePath = GeneratedColumn<String>(
      'front_image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backImagePathMeta =
      const VerificationMeta('backImagePath');
  @override
  late final GeneratedColumn<String> backImagePath = GeneratedColumn<String>(
      'back_image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _boxMeta = const VerificationMeta('box');
  @override
  late final GeneratedColumn<int> box = GeneratedColumn<int>(
      'box', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _nextReviewDateMeta =
      const VerificationMeta('nextReviewDate');
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> nextReviewDate =
      GeneratedColumn<String>('next_review_date', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DateTime>($CardsTable.$converternextReviewDate);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        deckId,
        front,
        back,
        frontImagePath,
        backImagePath,
        box,
        nextReviewDate,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<Card> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deck_id')) {
      context.handle(_deckIdMeta,
          deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta));
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('front')) {
      context.handle(
          _frontMeta, front.isAcceptableOrUnknown(data['front']!, _frontMeta));
    }
    if (data.containsKey('back')) {
      context.handle(
          _backMeta, back.isAcceptableOrUnknown(data['back']!, _backMeta));
    }
    if (data.containsKey('front_image_path')) {
      context.handle(
          _frontImagePathMeta,
          frontImagePath.isAcceptableOrUnknown(
              data['front_image_path']!, _frontImagePathMeta));
    }
    if (data.containsKey('back_image_path')) {
      context.handle(
          _backImagePathMeta,
          backImagePath.isAcceptableOrUnknown(
              data['back_image_path']!, _backImagePathMeta));
    }
    if (data.containsKey('box')) {
      context.handle(
          _boxMeta, box.isAcceptableOrUnknown(data['box']!, _boxMeta));
    }
    context.handle(_nextReviewDateMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      deckId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deck_id'])!,
      front: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}front']),
      back: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}back']),
      frontImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}front_image_path']),
      backImagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}back_image_path']),
      box: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}box'])!,
      nextReviewDate: $CardsTable.$converternextReviewDate.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}next_review_date'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, String> $converternextReviewDate =
      const DateOnlyConverter();
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final int deckId;
  final String? front;
  final String? back;
  final String? frontImagePath;
  final String? backImagePath;
  final int box;
  final DateTime nextReviewDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Card(
      {required this.id,
      required this.deckId,
      this.front,
      this.back,
      this.frontImagePath,
      this.backImagePath,
      required this.box,
      required this.nextReviewDate,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deck_id'] = Variable<int>(deckId);
    if (!nullToAbsent || front != null) {
      map['front'] = Variable<String>(front);
    }
    if (!nullToAbsent || back != null) {
      map['back'] = Variable<String>(back);
    }
    if (!nullToAbsent || frontImagePath != null) {
      map['front_image_path'] = Variable<String>(frontImagePath);
    }
    if (!nullToAbsent || backImagePath != null) {
      map['back_image_path'] = Variable<String>(backImagePath);
    }
    map['box'] = Variable<int>(box);
    {
      map['next_review_date'] = Variable<String>(
          $CardsTable.$converternextReviewDate.toSql(nextReviewDate));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      deckId: Value(deckId),
      front:
          front == null && nullToAbsent ? const Value.absent() : Value(front),
      back: back == null && nullToAbsent ? const Value.absent() : Value(back),
      frontImagePath: frontImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(frontImagePath),
      backImagePath: backImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(backImagePath),
      box: Value(box),
      nextReviewDate: Value(nextReviewDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      deckId: serializer.fromJson<int>(json['deckId']),
      front: serializer.fromJson<String?>(json['front']),
      back: serializer.fromJson<String?>(json['back']),
      frontImagePath: serializer.fromJson<String?>(json['frontImagePath']),
      backImagePath: serializer.fromJson<String?>(json['backImagePath']),
      box: serializer.fromJson<int>(json['box']),
      nextReviewDate: serializer.fromJson<DateTime>(json['nextReviewDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deckId': serializer.toJson<int>(deckId),
      'front': serializer.toJson<String?>(front),
      'back': serializer.toJson<String?>(back),
      'frontImagePath': serializer.toJson<String?>(frontImagePath),
      'backImagePath': serializer.toJson<String?>(backImagePath),
      'box': serializer.toJson<int>(box),
      'nextReviewDate': serializer.toJson<DateTime>(nextReviewDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Card copyWith(
          {int? id,
          int? deckId,
          Value<String?> front = const Value.absent(),
          Value<String?> back = const Value.absent(),
          Value<String?> frontImagePath = const Value.absent(),
          Value<String?> backImagePath = const Value.absent(),
          int? box,
          DateTime? nextReviewDate,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Card(
        id: id ?? this.id,
        deckId: deckId ?? this.deckId,
        front: front.present ? front.value : this.front,
        back: back.present ? back.value : this.back,
        frontImagePath:
            frontImagePath.present ? frontImagePath.value : this.frontImagePath,
        backImagePath:
            backImagePath.present ? backImagePath.value : this.backImagePath,
        box: box ?? this.box,
        nextReviewDate: nextReviewDate ?? this.nextReviewDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      front: data.front.present ? data.front.value : this.front,
      back: data.back.present ? data.back.value : this.back,
      frontImagePath: data.frontImagePath.present
          ? data.frontImagePath.value
          : this.frontImagePath,
      backImagePath: data.backImagePath.present
          ? data.backImagePath.value
          : this.backImagePath,
      box: data.box.present ? data.box.value : this.box,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('frontImagePath: $frontImagePath, ')
          ..write('backImagePath: $backImagePath, ')
          ..write('box: $box, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, deckId, front, back, frontImagePath,
      backImagePath, box, nextReviewDate, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.front == this.front &&
          other.back == this.back &&
          other.frontImagePath == this.frontImagePath &&
          other.backImagePath == this.backImagePath &&
          other.box == this.box &&
          other.nextReviewDate == this.nextReviewDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<int> deckId;
  final Value<String?> front;
  final Value<String?> back;
  final Value<String?> frontImagePath;
  final Value<String?> backImagePath;
  final Value<int> box;
  final Value<DateTime> nextReviewDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.frontImagePath = const Value.absent(),
    this.backImagePath = const Value.absent(),
    this.box = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required int deckId,
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.frontImagePath = const Value.absent(),
    this.backImagePath = const Value.absent(),
    this.box = const Value.absent(),
    required DateTime nextReviewDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : deckId = Value(deckId),
        nextReviewDate = Value(nextReviewDate);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<int>? deckId,
    Expression<String>? front,
    Expression<String>? back,
    Expression<String>? frontImagePath,
    Expression<String>? backImagePath,
    Expression<int>? box,
    Expression<String>? nextReviewDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (front != null) 'front': front,
      if (back != null) 'back': back,
      if (frontImagePath != null) 'front_image_path': frontImagePath,
      if (backImagePath != null) 'back_image_path': backImagePath,
      if (box != null) 'box': box,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? deckId,
      Value<String?>? front,
      Value<String?>? back,
      Value<String?>? frontImagePath,
      Value<String?>? backImagePath,
      Value<int>? box,
      Value<DateTime>? nextReviewDate,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CardsCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      frontImagePath: frontImagePath ?? this.frontImagePath,
      backImagePath: backImagePath ?? this.backImagePath,
      box: box ?? this.box,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<int>(deckId.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (frontImagePath.present) {
      map['front_image_path'] = Variable<String>(frontImagePath.value);
    }
    if (backImagePath.present) {
      map['back_image_path'] = Variable<String>(backImagePath.value);
    }
    if (box.present) {
      map['box'] = Variable<int>(box.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<String>(
          $CardsTable.$converternextReviewDate.toSql(nextReviewDate.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('frontImagePath: $frontImagePath, ')
          ..write('backImagePath: $backImagePath, ')
          ..write('box: $box, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewLogsTable extends ReviewLogs
    with TableInfo<$ReviewLogsTable, ReviewLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cards (id) ON DELETE CASCADE'));
  static const VerificationMeta _reviewedAtMeta =
      const VerificationMeta('reviewedAt');
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
      'reviewed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _wasCorrectMeta =
      const VerificationMeta('wasCorrect');
  @override
  late final GeneratedColumn<bool> wasCorrect = GeneratedColumn<bool>(
      'was_correct', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("was_correct" IN (0, 1))'));
  static const VerificationMeta _boxBeforeMeta =
      const VerificationMeta('boxBefore');
  @override
  late final GeneratedColumn<int> boxBefore = GeneratedColumn<int>(
      'box_before', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _boxAfterMeta =
      const VerificationMeta('boxAfter');
  @override
  late final GeneratedColumn<int> boxAfter = GeneratedColumn<int>(
      'box_after', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cardId, reviewedAt, wasCorrect, boxBefore, boxAfter];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_logs';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
          _reviewedAtMeta,
          reviewedAt.isAcceptableOrUnknown(
              data['reviewed_at']!, _reviewedAtMeta));
    }
    if (data.containsKey('was_correct')) {
      context.handle(
          _wasCorrectMeta,
          wasCorrect.isAcceptableOrUnknown(
              data['was_correct']!, _wasCorrectMeta));
    } else if (isInserting) {
      context.missing(_wasCorrectMeta);
    }
    if (data.containsKey('box_before')) {
      context.handle(_boxBeforeMeta,
          boxBefore.isAcceptableOrUnknown(data['box_before']!, _boxBeforeMeta));
    } else if (isInserting) {
      context.missing(_boxBeforeMeta);
    }
    if (data.containsKey('box_after')) {
      context.handle(_boxAfterMeta,
          boxAfter.isAcceptableOrUnknown(data['box_after']!, _boxAfterMeta));
    } else if (isInserting) {
      context.missing(_boxAfterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      reviewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reviewed_at'])!,
      wasCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}was_correct'])!,
      boxBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}box_before'])!,
      boxAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}box_after'])!,
    );
  }

  @override
  $ReviewLogsTable createAlias(String alias) {
    return $ReviewLogsTable(attachedDatabase, alias);
  }
}

class ReviewLog extends DataClass implements Insertable<ReviewLog> {
  final int id;
  final int cardId;
  final DateTime reviewedAt;
  final bool wasCorrect;
  final int boxBefore;
  final int boxAfter;
  const ReviewLog(
      {required this.id,
      required this.cardId,
      required this.reviewedAt,
      required this.wasCorrect,
      required this.boxBefore,
      required this.boxAfter});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    map['was_correct'] = Variable<bool>(wasCorrect);
    map['box_before'] = Variable<int>(boxBefore);
    map['box_after'] = Variable<int>(boxAfter);
    return map;
  }

  ReviewLogsCompanion toCompanion(bool nullToAbsent) {
    return ReviewLogsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      reviewedAt: Value(reviewedAt),
      wasCorrect: Value(wasCorrect),
      boxBefore: Value(boxBefore),
      boxAfter: Value(boxAfter),
    );
  }

  factory ReviewLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewLog(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
      wasCorrect: serializer.fromJson<bool>(json['wasCorrect']),
      boxBefore: serializer.fromJson<int>(json['boxBefore']),
      boxAfter: serializer.fromJson<int>(json['boxAfter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
      'wasCorrect': serializer.toJson<bool>(wasCorrect),
      'boxBefore': serializer.toJson<int>(boxBefore),
      'boxAfter': serializer.toJson<int>(boxAfter),
    };
  }

  ReviewLog copyWith(
          {int? id,
          int? cardId,
          DateTime? reviewedAt,
          bool? wasCorrect,
          int? boxBefore,
          int? boxAfter}) =>
      ReviewLog(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        reviewedAt: reviewedAt ?? this.reviewedAt,
        wasCorrect: wasCorrect ?? this.wasCorrect,
        boxBefore: boxBefore ?? this.boxBefore,
        boxAfter: boxAfter ?? this.boxAfter,
      );
  ReviewLog copyWithCompanion(ReviewLogsCompanion data) {
    return ReviewLog(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      reviewedAt:
          data.reviewedAt.present ? data.reviewedAt.value : this.reviewedAt,
      wasCorrect:
          data.wasCorrect.present ? data.wasCorrect.value : this.wasCorrect,
      boxBefore: data.boxBefore.present ? data.boxBefore.value : this.boxBefore,
      boxAfter: data.boxAfter.present ? data.boxAfter.value : this.boxAfter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLog(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('wasCorrect: $wasCorrect, ')
          ..write('boxBefore: $boxBefore, ')
          ..write('boxAfter: $boxAfter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cardId, reviewedAt, wasCorrect, boxBefore, boxAfter);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewLog &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.reviewedAt == this.reviewedAt &&
          other.wasCorrect == this.wasCorrect &&
          other.boxBefore == this.boxBefore &&
          other.boxAfter == this.boxAfter);
}

class ReviewLogsCompanion extends UpdateCompanion<ReviewLog> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<DateTime> reviewedAt;
  final Value<bool> wasCorrect;
  final Value<int> boxBefore;
  final Value<int> boxAfter;
  const ReviewLogsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.wasCorrect = const Value.absent(),
    this.boxBefore = const Value.absent(),
    this.boxAfter = const Value.absent(),
  });
  ReviewLogsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    this.reviewedAt = const Value.absent(),
    required bool wasCorrect,
    required int boxBefore,
    required int boxAfter,
  })  : cardId = Value(cardId),
        wasCorrect = Value(wasCorrect),
        boxBefore = Value(boxBefore),
        boxAfter = Value(boxAfter);
  static Insertable<ReviewLog> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<DateTime>? reviewedAt,
    Expression<bool>? wasCorrect,
    Expression<int>? boxBefore,
    Expression<int>? boxAfter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (wasCorrect != null) 'was_correct': wasCorrect,
      if (boxBefore != null) 'box_before': boxBefore,
      if (boxAfter != null) 'box_after': boxAfter,
    });
  }

  ReviewLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? cardId,
      Value<DateTime>? reviewedAt,
      Value<bool>? wasCorrect,
      Value<int>? boxBefore,
      Value<int>? boxAfter}) {
    return ReviewLogsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      wasCorrect: wasCorrect ?? this.wasCorrect,
      boxBefore: boxBefore ?? this.boxBefore,
      boxAfter: boxAfter ?? this.boxAfter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (wasCorrect.present) {
      map['was_correct'] = Variable<bool>(wasCorrect.value);
    }
    if (boxBefore.present) {
      map['box_before'] = Variable<int>(boxBefore.value);
    }
    if (boxAfter.present) {
      map['box_after'] = Variable<int>(boxAfter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLogsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('wasCorrect: $wasCorrect, ')
          ..write('boxBefore: $boxBefore, ')
          ..write('boxAfter: $boxAfter')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DecksTable decks = $DecksTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $ReviewLogsTable reviewLogs = $ReviewLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [decks, cards, reviewLogs];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('decks',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('cards', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('cards',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_logs', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$DecksTableCreateCompanionBuilder = DecksCompanion Function({
  Value<int> id,
  required String name,
  Value<DateTime> createdAt,
});
typedef $$DecksTableUpdateCompanionBuilder = DecksCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> createdAt,
});

final class $$DecksTableReferences
    extends BaseReferences<_$AppDatabase, $DecksTable, Deck> {
  $$DecksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: $_aliasNameGenerator(db.decks.id, db.cards.deckId));

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.deckId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DecksTableFilterComposer extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> cardsRefs(
      Expression<bool> Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.deckId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DecksTableOrderingComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> cardsRefs<T extends Object>(
      Expression<T> Function($$CardsTableAnnotationComposer a) f) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.deckId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DecksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DecksTable,
    Deck,
    $$DecksTableFilterComposer,
    $$DecksTableOrderingComposer,
    $$DecksTableAnnotationComposer,
    $$DecksTableCreateCompanionBuilder,
    $$DecksTableUpdateCompanionBuilder,
    (Deck, $$DecksTableReferences),
    Deck,
    PrefetchHooks Function({bool cardsRefs})> {
  $$DecksTableTableManager(_$AppDatabase db, $DecksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DecksCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DecksCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DecksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({cardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (cardsRefs) db.cards],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$DecksTableReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DecksTableReferences(db, table, p0).cardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.deckId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DecksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DecksTable,
    Deck,
    $$DecksTableFilterComposer,
    $$DecksTableOrderingComposer,
    $$DecksTableAnnotationComposer,
    $$DecksTableCreateCompanionBuilder,
    $$DecksTableUpdateCompanionBuilder,
    (Deck, $$DecksTableReferences),
    Deck,
    PrefetchHooks Function({bool cardsRefs})>;
typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required int deckId,
  Value<String?> front,
  Value<String?> back,
  Value<String?> frontImagePath,
  Value<String?> backImagePath,
  Value<int> box,
  required DateTime nextReviewDate,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<int> deckId,
  Value<String?> front,
  Value<String?> back,
  Value<String?> frontImagePath,
  Value<String?> backImagePath,
  Value<int> box,
  Value<DateTime> nextReviewDate,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$CardsTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTable, Card> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias($_aliasNameGenerator(db.cards.deckId, db.decks.id));

  $$DecksTableProcessedTableManager get deckId {
    final manager = $$DecksTableTableManager($_db, $_db.decks)
        .filter((f) => f.id($_item.deckId));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ReviewLogsTable, List<ReviewLog>>
      _reviewLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.reviewLogs,
          aliasName: $_aliasNameGenerator(db.cards.id, db.reviewLogs.cardId));

  $$ReviewLogsTableProcessedTableManager get reviewLogsRefs {
    final manager = $$ReviewLogsTableTableManager($_db, $_db.reviewLogs)
        .filter((f) => f.cardId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_reviewLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get front => $composableBuilder(
      column: $table.front, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get back => $composableBuilder(
      column: $table.back, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frontImagePath => $composableBuilder(
      column: $table.frontImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backImagePath => $composableBuilder(
      column: $table.backImagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get box => $composableBuilder(
      column: $table.box, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DateTime, DateTime, String>
      get nextReviewDate => $composableBuilder(
          column: $table.nextReviewDate,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.deckId,
        referencedTable: $db.decks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DecksTableFilterComposer(
              $db: $db,
              $table: $db.decks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> reviewLogsRefs(
      Expression<bool> Function($$ReviewLogsTableFilterComposer f) f) {
    final $$ReviewLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviewLogs,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewLogsTableFilterComposer(
              $db: $db,
              $table: $db.reviewLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get front => $composableBuilder(
      column: $table.front, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get back => $composableBuilder(
      column: $table.back, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frontImagePath => $composableBuilder(
      column: $table.frontImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backImagePath => $composableBuilder(
      column: $table.backImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get box => $composableBuilder(
      column: $table.box, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.deckId,
        referencedTable: $db.decks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DecksTableOrderingComposer(
              $db: $db,
              $table: $db.decks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get front =>
      $composableBuilder(column: $table.front, builder: (column) => column);

  GeneratedColumn<String> get back =>
      $composableBuilder(column: $table.back, builder: (column) => column);

  GeneratedColumn<String> get frontImagePath => $composableBuilder(
      column: $table.frontImagePath, builder: (column) => column);

  GeneratedColumn<String> get backImagePath => $composableBuilder(
      column: $table.backImagePath, builder: (column) => column);

  GeneratedColumn<int> get box =>
      $composableBuilder(column: $table.box, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, String> get nextReviewDate =>
      $composableBuilder(
          column: $table.nextReviewDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.deckId,
        referencedTable: $db.decks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DecksTableAnnotationComposer(
              $db: $db,
              $table: $db.decks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> reviewLogsRefs<T extends Object>(
      Expression<T> Function($$ReviewLogsTableAnnotationComposer a) f) {
    final $$ReviewLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviewLogs,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.reviewLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool deckId, bool reviewLogsRefs})> {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> deckId = const Value.absent(),
            Value<String?> front = const Value.absent(),
            Value<String?> back = const Value.absent(),
            Value<String?> frontImagePath = const Value.absent(),
            Value<String?> backImagePath = const Value.absent(),
            Value<int> box = const Value.absent(),
            Value<DateTime> nextReviewDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            deckId: deckId,
            front: front,
            back: back,
            frontImagePath: frontImagePath,
            backImagePath: backImagePath,
            box: box,
            nextReviewDate: nextReviewDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int deckId,
            Value<String?> front = const Value.absent(),
            Value<String?> back = const Value.absent(),
            Value<String?> frontImagePath = const Value.absent(),
            Value<String?> backImagePath = const Value.absent(),
            Value<int> box = const Value.absent(),
            required DateTime nextReviewDate,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CardsCompanion.insert(
            id: id,
            deckId: deckId,
            front: front,
            back: back,
            frontImagePath: frontImagePath,
            backImagePath: backImagePath,
            box: box,
            nextReviewDate: nextReviewDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({deckId = false, reviewLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (reviewLogsRefs) db.reviewLogs],
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
                      dynamic>>(state) {
                if (deckId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.deckId,
                    referencedTable: $$CardsTableReferences._deckIdTable(db),
                    referencedColumn:
                        $$CardsTableReferences._deckIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewLogsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CardsTableReferences._reviewLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0)
                                .reviewLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool deckId, bool reviewLogsRefs})>;
typedef $$ReviewLogsTableCreateCompanionBuilder = ReviewLogsCompanion Function({
  Value<int> id,
  required int cardId,
  Value<DateTime> reviewedAt,
  required bool wasCorrect,
  required int boxBefore,
  required int boxAfter,
});
typedef $$ReviewLogsTableUpdateCompanionBuilder = ReviewLogsCompanion Function({
  Value<int> id,
  Value<int> cardId,
  Value<DateTime> reviewedAt,
  Value<bool> wasCorrect,
  Value<int> boxBefore,
  Value<int> boxAfter,
});

final class $$ReviewLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewLogsTable, ReviewLog> {
  $$ReviewLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CardsTable _cardIdTable(_$AppDatabase db) => db.cards
      .createAlias($_aliasNameGenerator(db.reviewLogs.cardId, db.cards.id));

  $$CardsTableProcessedTableManager get cardId {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id($_item.cardId));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReviewLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get wasCorrect => $composableBuilder(
      column: $table.wasCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get boxBefore => $composableBuilder(
      column: $table.boxBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get boxAfter => $composableBuilder(
      column: $table.boxAfter, builder: (column) => ColumnFilters(column));

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get wasCorrect => $composableBuilder(
      column: $table.wasCorrect, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get boxBefore => $composableBuilder(
      column: $table.boxBefore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get boxAfter => $composableBuilder(
      column: $table.boxAfter, builder: (column) => ColumnOrderings(column));

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => column);

  GeneratedColumn<bool> get wasCorrect => $composableBuilder(
      column: $table.wasCorrect, builder: (column) => column);

  GeneratedColumn<int> get boxBefore =>
      $composableBuilder(column: $table.boxBefore, builder: (column) => column);

  GeneratedColumn<int> get boxAfter =>
      $composableBuilder(column: $table.boxAfter, builder: (column) => column);

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewLogsTable,
    ReviewLog,
    $$ReviewLogsTableFilterComposer,
    $$ReviewLogsTableOrderingComposer,
    $$ReviewLogsTableAnnotationComposer,
    $$ReviewLogsTableCreateCompanionBuilder,
    $$ReviewLogsTableUpdateCompanionBuilder,
    (ReviewLog, $$ReviewLogsTableReferences),
    ReviewLog,
    PrefetchHooks Function({bool cardId})> {
  $$ReviewLogsTableTableManager(_$AppDatabase db, $ReviewLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cardId = const Value.absent(),
            Value<DateTime> reviewedAt = const Value.absent(),
            Value<bool> wasCorrect = const Value.absent(),
            Value<int> boxBefore = const Value.absent(),
            Value<int> boxAfter = const Value.absent(),
          }) =>
              ReviewLogsCompanion(
            id: id,
            cardId: cardId,
            reviewedAt: reviewedAt,
            wasCorrect: wasCorrect,
            boxBefore: boxBefore,
            boxAfter: boxAfter,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cardId,
            Value<DateTime> reviewedAt = const Value.absent(),
            required bool wasCorrect,
            required int boxBefore,
            required int boxAfter,
          }) =>
              ReviewLogsCompanion.insert(
            id: id,
            cardId: cardId,
            reviewedAt: reviewedAt,
            wasCorrect: wasCorrect,
            boxBefore: boxBefore,
            boxAfter: boxAfter,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReviewLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
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
                      dynamic>>(state) {
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable:
                        $$ReviewLogsTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$ReviewLogsTableReferences._cardIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReviewLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewLogsTable,
    ReviewLog,
    $$ReviewLogsTableFilterComposer,
    $$ReviewLogsTableOrderingComposer,
    $$ReviewLogsTableAnnotationComposer,
    $$ReviewLogsTableCreateCompanionBuilder,
    $$ReviewLogsTableUpdateCompanionBuilder,
    (ReviewLog, $$ReviewLogsTableReferences),
    ReviewLog,
    PrefetchHooks Function({bool cardId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DecksTableTableManager get decks =>
      $$DecksTableTableManager(_db, _db.decks);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$ReviewLogsTableTableManager get reviewLogs =>
      $$ReviewLogsTableTableManager(_db, _db.reviewLogs);
}
