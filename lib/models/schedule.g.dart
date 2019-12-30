// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Schedule> _$scheduleSerializer = new _$ScheduleSerializer();

class _$ScheduleSerializer implements StructuredSerializer<Schedule> {
  @override
  final Iterable<Type> types = const [Schedule, _$Schedule];
  @override
  final String wireName = 'Schedule';

  @override
  Iterable<Object> serialize(Serializers serializers, Schedule object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'day',
      serializers.serialize(object.day, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'slots',
      serializers.serialize(object.slots,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ScheduleSlot)])),
    ];

    return result;
  }

  @override
  Schedule deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'slots':
          result.slots.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ScheduleSlot)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$Schedule extends Schedule {
  @override
  final String day;
  @override
  final String title;
  @override
  final BuiltList<ScheduleSlot> slots;

  factory _$Schedule([void Function(ScheduleBuilder) updates]) =>
      (new ScheduleBuilder()..update(updates)).build();

  _$Schedule._({this.day, this.title, this.slots}) : super._() {
    if (day == null) {
      throw new BuiltValueNullFieldError('Schedule', 'day');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Schedule', 'title');
    }
    if (slots == null) {
      throw new BuiltValueNullFieldError('Schedule', 'slots');
    }
  }

  @override
  Schedule rebuild(void Function(ScheduleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleBuilder toBuilder() => new ScheduleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Schedule &&
        day == other.day &&
        title == other.title &&
        slots == other.slots;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, day.hashCode), title.hashCode), slots.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Schedule')
          ..add('day', day)
          ..add('title', title)
          ..add('slots', slots))
        .toString();
  }
}

class ScheduleBuilder implements Builder<Schedule, ScheduleBuilder> {
  _$Schedule _$v;

  String _day;
  String get day => _$this._day;
  set day(String day) => _$this._day = day;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<ScheduleSlot> _slots;
  ListBuilder<ScheduleSlot> get slots =>
      _$this._slots ??= new ListBuilder<ScheduleSlot>();
  set slots(ListBuilder<ScheduleSlot> slots) => _$this._slots = slots;

  ScheduleBuilder();

  ScheduleBuilder get _$this {
    if (_$v != null) {
      _day = _$v.day;
      _title = _$v.title;
      _slots = _$v.slots?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Schedule other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Schedule;
  }

  @override
  void update(void Function(ScheduleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Schedule build() {
    _$Schedule _$result;
    try {
      _$result =
          _$v ?? new _$Schedule._(day: day, title: title, slots: slots.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'slots';
        slots.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Schedule', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
