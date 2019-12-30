// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AppState.serializer)
      ..add(Conference.serializer)
      ..add(EventCategory.serializer)
      ..add(Language.serializer)
      ..add(Schedule.serializer)
      ..add(ScheduleBreak.serializer)
      ..add(ScheduleSlot.serializer)
      ..add(SessionType.serializer)
      ..add(Speaker.serializer)
      ..add(Talk.serializer)
      ..add(Track.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ScheduleSlot)]),
          () => new ListBuilder<ScheduleSlot>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Track)]),
          () => new ListBuilder<Track>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Language)]),
          () => new ListBuilder<Language>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SessionType)]),
          () => new ListBuilder<SessionType>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(Conference)]),
          () => new MapBuilder<int, Conference>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(BuiltList, const [const FullType(Speaker)])
          ]),
          () => new MapBuilder<int, BuiltList<Speaker>>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(BuiltList, const [const FullType(Schedule)])
          ]),
          () => new MapBuilder<int, BuiltList<Schedule>>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(int)]),
          () => new MapBuilder<String, int>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
