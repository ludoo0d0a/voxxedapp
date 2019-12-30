// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SessionType> _$sessionTypeSerializer = new _$SessionTypeSerializer();

class _$SessionTypeSerializer implements StructuredSerializer<SessionType> {
  @override
  final Iterable<Type> types = const [SessionType, _$SessionType];
  @override
  final String wireName = 'SessionType';

  @override
  Iterable<Object> serialize(Serializers serializers, SessionType object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'pause',
      serializers.serialize(object.pause, specifiedType: const FullType(bool)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(int)),
    ];
    if (object.color != null) {
      result
        ..add('color')
        ..add(serializers.serialize(object.color,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SessionType deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SessionTypeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pause':
          result.pause = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SessionType extends SessionType {
  @override
  final int id;
  @override
  final String code;
  @override
  final String name;
  @override
  final bool pause;
  @override
  final int duration;
  @override
  final String color;

  factory _$SessionType([void Function(SessionTypeBuilder) updates]) =>
      (new SessionTypeBuilder()..update(updates)).build();

  _$SessionType._(
      {this.id, this.code, this.name, this.pause, this.duration, this.color})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('SessionType', 'id');
    }
    if (code == null) {
      throw new BuiltValueNullFieldError('SessionType', 'code');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SessionType', 'name');
    }
    if (pause == null) {
      throw new BuiltValueNullFieldError('SessionType', 'pause');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('SessionType', 'duration');
    }
  }

  @override
  SessionType rebuild(void Function(SessionTypeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionTypeBuilder toBuilder() => new SessionTypeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionType &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        pause == other.pause &&
        duration == other.duration &&
        color == other.color;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), code.hashCode), name.hashCode),
                pause.hashCode),
            duration.hashCode),
        color.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SessionType')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('pause', pause)
          ..add('duration', duration)
          ..add('color', color))
        .toString();
  }
}

class SessionTypeBuilder implements Builder<SessionType, SessionTypeBuilder> {
  _$SessionType _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _pause;
  bool get pause => _$this._pause;
  set pause(bool pause) => _$this._pause = pause;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  SessionTypeBuilder();

  SessionTypeBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _code = _$v.code;
      _name = _$v.name;
      _pause = _$v.pause;
      _duration = _$v.duration;
      _color = _$v.color;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionType other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SessionType;
  }

  @override
  void update(void Function(SessionTypeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SessionType build() {
    final _$result = _$v ??
        new _$SessionType._(
            id: id,
            code: code,
            name: name,
            pause: pause,
            duration: duration,
            color: color);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
