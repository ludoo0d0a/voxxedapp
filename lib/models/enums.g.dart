// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EventCategory _$VOXXED = const EventCategory._('VOXXED');
const EventCategory _$DEVOXX = const EventCategory._('DEVOXX');

EventCategory _$valueOf(String name) {
  switch (name) {
    case 'VOXXED':
      return _$VOXXED;
    case 'DEVOXX':
      return _$DEVOXX;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EventCategory> _$values =
    new BuiltSet<EventCategory>(const <EventCategory>[
  _$VOXXED,
  _$DEVOXX,
]);

Serializer<EventCategory> _$eventCategorySerializer =
    new _$EventCategorySerializer();

class _$EventCategorySerializer implements PrimitiveSerializer<EventCategory> {
  @override
  final Iterable<Type> types = const <Type>[EventCategory];
  @override
  final String wireName = 'EventCategory';

  @override
  Object serialize(Serializers serializers, EventCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EventCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EventCategory.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
