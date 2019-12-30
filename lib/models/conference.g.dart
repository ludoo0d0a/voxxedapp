// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Conference> _$conferenceSerializer = new _$ConferenceSerializer();

class _$ConferenceSerializer implements StructuredSerializer<Conference> {
  @override
  final Iterable<Type> types = const [Conference, _$Conference];
  @override
  final String wireName = 'Conference';

  @override
  Iterable<Object> serialize(Serializers serializers, Conference object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'website',
      serializers.serialize(object.website,
          specifiedType: const FullType(String)),
      'imageURL',
      serializers.serialize(object.imageURL,
          specifiedType: const FullType(String)),
      'apiURL',
      serializers.serialize(object.apiURL,
          specifiedType: const FullType(String)),
      'fromDate',
      serializers.serialize(object.fromDate,
          specifiedType: const FullType(String)),
      'toDate',
      serializers.serialize(object.toDate,
          specifiedType: const FullType(String)),
      'eventCategory',
      serializers.serialize(object.eventCategory,
          specifiedType: const FullType(EventCategory)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.scheduleURL != null) {
      result
        ..add('scheduleURL')
        ..add(serializers.serialize(object.scheduleURL,
            specifiedType: const FullType(String)));
    }
    if (object.eventImagesURL != null) {
      result
        ..add('eventImagesURL')
        ..add(serializers.serialize(object.eventImagesURL,
            specifiedType: const FullType(String)));
    }
    if (object.youTubeURL != null) {
      result
        ..add('youTubeURL')
        ..add(serializers.serialize(object.youTubeURL,
            specifiedType: const FullType(String)));
    }
    if (object.cfpURL != null) {
      result
        ..add('cfpURL')
        ..add(serializers.serialize(object.cfpURL,
            specifiedType: const FullType(String)));
    }
    if (object.archived != null) {
      result
        ..add('archived')
        ..add(serializers.serialize(object.archived,
            specifiedType: const FullType(bool)));
    }
    if (object.cfpActive != null) {
      result
        ..add('cfpActive')
        ..add(serializers.serialize(object.cfpActive,
            specifiedType: const FullType(bool)));
    }
    if (object.locationId != null) {
      result
        ..add('locationId')
        ..add(serializers.serialize(object.locationId,
            specifiedType: const FullType(int)));
    }
    if (object.locationName != null) {
      result
        ..add('locationName')
        ..add(serializers.serialize(object.locationName,
            specifiedType: const FullType(String)));
    }
    if (object.timezone != null) {
      result
        ..add('timezone')
        ..add(serializers.serialize(object.timezone,
            specifiedType: const FullType(String)));
    }
    if (object.cfpFromDate != null) {
      result
        ..add('cfpFromDate')
        ..add(serializers.serialize(object.cfpFromDate,
            specifiedType: const FullType(String)));
    }
    if (object.cfpEndDate != null) {
      result
        ..add('cfpEndDate')
        ..add(serializers.serialize(object.cfpEndDate,
            specifiedType: const FullType(String)));
    }
    if (object.cfpKey != null) {
      result
        ..add('cfpKey')
        ..add(serializers.serialize(object.cfpKey,
            specifiedType: const FullType(String)));
    }
    if (object.tracks != null) {
      result
        ..add('tracks')
        ..add(serializers.serialize(object.tracks,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Track)])));
    }
    if (object.languages != null) {
      result
        ..add('languages')
        ..add(serializers.serialize(object.languages,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Language)])));
    }
    if (object.sessionTypes != null) {
      result
        ..add('sessionTypes')
        ..add(serializers.serialize(object.sessionTypes,
            specifiedType: const FullType(
                BuiltList, const [const FullType(SessionType)])));
    }
    return result;
  }

  @override
  Conference deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConferenceBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageURL':
          result.imageURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'apiURL':
          result.apiURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fromDate':
          result.fromDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'toDate':
          result.toDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventCategory':
          result.eventCategory = serializers.deserialize(value,
              specifiedType: const FullType(EventCategory)) as EventCategory;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'scheduleURL':
          result.scheduleURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventImagesURL':
          result.eventImagesURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'youTubeURL':
          result.youTubeURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpURL':
          result.cfpURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'archived':
          result.archived = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'cfpActive':
          result.cfpActive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'locationId':
          result.locationId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'locationName':
          result.locationName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timezone':
          result.timezone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpFromDate':
          result.cfpFromDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpEndDate':
          result.cfpEndDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpKey':
          result.cfpKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tracks':
          result.tracks.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Track)]))
              as BuiltList<dynamic>);
          break;
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Language)]))
              as BuiltList<dynamic>);
          break;
        case 'sessionTypes':
          result.sessionTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SessionType)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$Conference extends Conference {
  @override
  final int id;
  @override
  final String name;
  @override
  final String website;
  @override
  final String imageURL;
  @override
  final String apiURL;
  @override
  final String fromDate;
  @override
  final String toDate;
  @override
  final EventCategory eventCategory;
  @override
  final String description;
  @override
  final String scheduleURL;
  @override
  final String eventImagesURL;
  @override
  final String youTubeURL;
  @override
  final String cfpURL;
  @override
  final bool archived;
  @override
  final bool cfpActive;
  @override
  final int locationId;
  @override
  final String locationName;
  @override
  final String timezone;
  @override
  final String cfpFromDate;
  @override
  final String cfpEndDate;
  @override
  final String cfpKey;
  @override
  final BuiltList<Track> tracks;
  @override
  final BuiltList<Language> languages;
  @override
  final BuiltList<SessionType> sessionTypes;

  factory _$Conference([void Function(ConferenceBuilder) updates]) =>
      (new ConferenceBuilder()..update(updates)).build();

  _$Conference._(
      {this.id,
      this.name,
      this.website,
      this.imageURL,
      this.apiURL,
      this.fromDate,
      this.toDate,
      this.eventCategory,
      this.description,
      this.scheduleURL,
      this.eventImagesURL,
      this.youTubeURL,
      this.cfpURL,
      this.archived,
      this.cfpActive,
      this.locationId,
      this.locationName,
      this.timezone,
      this.cfpFromDate,
      this.cfpEndDate,
      this.cfpKey,
      this.tracks,
      this.languages,
      this.sessionTypes})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Conference', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Conference', 'name');
    }
    if (website == null) {
      throw new BuiltValueNullFieldError('Conference', 'website');
    }
    if (imageURL == null) {
      throw new BuiltValueNullFieldError('Conference', 'imageURL');
    }
    if (apiURL == null) {
      throw new BuiltValueNullFieldError('Conference', 'apiURL');
    }
    if (fromDate == null) {
      throw new BuiltValueNullFieldError('Conference', 'fromDate');
    }
    if (toDate == null) {
      throw new BuiltValueNullFieldError('Conference', 'toDate');
    }
    if (eventCategory == null) {
      throw new BuiltValueNullFieldError('Conference', 'eventCategory');
    }
  }

  @override
  Conference rebuild(void Function(ConferenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConferenceBuilder toBuilder() => new ConferenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Conference &&
        id == other.id &&
        name == other.name &&
        website == other.website &&
        imageURL == other.imageURL &&
        apiURL == other.apiURL &&
        fromDate == other.fromDate &&
        toDate == other.toDate &&
        eventCategory == other.eventCategory &&
        description == other.description &&
        scheduleURL == other.scheduleURL &&
        eventImagesURL == other.eventImagesURL &&
        youTubeURL == other.youTubeURL &&
        cfpURL == other.cfpURL &&
        archived == other.archived &&
        cfpActive == other.cfpActive &&
        locationId == other.locationId &&
        locationName == other.locationName &&
        timezone == other.timezone &&
        cfpFromDate == other.cfpFromDate &&
        cfpEndDate == other.cfpEndDate &&
        cfpKey == other.cfpKey &&
        tracks == other.tracks &&
        languages == other.languages &&
        sessionTypes == other.sessionTypes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc(0, id.hashCode), name.hashCode), website.hashCode), imageURL.hashCode), apiURL.hashCode),
                                                                                fromDate.hashCode),
                                                                            toDate.hashCode),
                                                                        eventCategory.hashCode),
                                                                    description.hashCode),
                                                                scheduleURL.hashCode),
                                                            eventImagesURL.hashCode),
                                                        youTubeURL.hashCode),
                                                    cfpURL.hashCode),
                                                archived.hashCode),
                                            cfpActive.hashCode),
                                        locationId.hashCode),
                                    locationName.hashCode),
                                timezone.hashCode),
                            cfpFromDate.hashCode),
                        cfpEndDate.hashCode),
                    cfpKey.hashCode),
                tracks.hashCode),
            languages.hashCode),
        sessionTypes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Conference')
          ..add('id', id)
          ..add('name', name)
          ..add('website', website)
          ..add('imageURL', imageURL)
          ..add('apiURL', apiURL)
          ..add('fromDate', fromDate)
          ..add('toDate', toDate)
          ..add('eventCategory', eventCategory)
          ..add('description', description)
          ..add('scheduleURL', scheduleURL)
          ..add('eventImagesURL', eventImagesURL)
          ..add('youTubeURL', youTubeURL)
          ..add('cfpURL', cfpURL)
          ..add('archived', archived)
          ..add('cfpActive', cfpActive)
          ..add('locationId', locationId)
          ..add('locationName', locationName)
          ..add('timezone', timezone)
          ..add('cfpFromDate', cfpFromDate)
          ..add('cfpEndDate', cfpEndDate)
          ..add('cfpKey', cfpKey)
          ..add('tracks', tracks)
          ..add('languages', languages)
          ..add('sessionTypes', sessionTypes))
        .toString();
  }
}

class ConferenceBuilder implements Builder<Conference, ConferenceBuilder> {
  _$Conference _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _imageURL;
  String get imageURL => _$this._imageURL;
  set imageURL(String imageURL) => _$this._imageURL = imageURL;

  String _apiURL;
  String get apiURL => _$this._apiURL;
  set apiURL(String apiURL) => _$this._apiURL = apiURL;

  String _fromDate;
  String get fromDate => _$this._fromDate;
  set fromDate(String fromDate) => _$this._fromDate = fromDate;

  String _toDate;
  String get toDate => _$this._toDate;
  set toDate(String toDate) => _$this._toDate = toDate;

  EventCategory _eventCategory;
  EventCategory get eventCategory => _$this._eventCategory;
  set eventCategory(EventCategory eventCategory) =>
      _$this._eventCategory = eventCategory;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _scheduleURL;
  String get scheduleURL => _$this._scheduleURL;
  set scheduleURL(String scheduleURL) => _$this._scheduleURL = scheduleURL;

  String _eventImagesURL;
  String get eventImagesURL => _$this._eventImagesURL;
  set eventImagesURL(String eventImagesURL) =>
      _$this._eventImagesURL = eventImagesURL;

  String _youTubeURL;
  String get youTubeURL => _$this._youTubeURL;
  set youTubeURL(String youTubeURL) => _$this._youTubeURL = youTubeURL;

  String _cfpURL;
  String get cfpURL => _$this._cfpURL;
  set cfpURL(String cfpURL) => _$this._cfpURL = cfpURL;

  bool _archived;
  bool get archived => _$this._archived;
  set archived(bool archived) => _$this._archived = archived;

  bool _cfpActive;
  bool get cfpActive => _$this._cfpActive;
  set cfpActive(bool cfpActive) => _$this._cfpActive = cfpActive;

  int _locationId;
  int get locationId => _$this._locationId;
  set locationId(int locationId) => _$this._locationId = locationId;

  String _locationName;
  String get locationName => _$this._locationName;
  set locationName(String locationName) => _$this._locationName = locationName;

  String _timezone;
  String get timezone => _$this._timezone;
  set timezone(String timezone) => _$this._timezone = timezone;

  String _cfpFromDate;
  String get cfpFromDate => _$this._cfpFromDate;
  set cfpFromDate(String cfpFromDate) => _$this._cfpFromDate = cfpFromDate;

  String _cfpEndDate;
  String get cfpEndDate => _$this._cfpEndDate;
  set cfpEndDate(String cfpEndDate) => _$this._cfpEndDate = cfpEndDate;

  String _cfpKey;
  String get cfpKey => _$this._cfpKey;
  set cfpKey(String cfpKey) => _$this._cfpKey = cfpKey;

  ListBuilder<Track> _tracks;
  ListBuilder<Track> get tracks => _$this._tracks ??= new ListBuilder<Track>();
  set tracks(ListBuilder<Track> tracks) => _$this._tracks = tracks;

  ListBuilder<Language> _languages;
  ListBuilder<Language> get languages =>
      _$this._languages ??= new ListBuilder<Language>();
  set languages(ListBuilder<Language> languages) =>
      _$this._languages = languages;

  ListBuilder<SessionType> _sessionTypes;
  ListBuilder<SessionType> get sessionTypes =>
      _$this._sessionTypes ??= new ListBuilder<SessionType>();
  set sessionTypes(ListBuilder<SessionType> sessionTypes) =>
      _$this._sessionTypes = sessionTypes;

  ConferenceBuilder();

  ConferenceBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _website = _$v.website;
      _imageURL = _$v.imageURL;
      _apiURL = _$v.apiURL;
      _fromDate = _$v.fromDate;
      _toDate = _$v.toDate;
      _eventCategory = _$v.eventCategory;
      _description = _$v.description;
      _scheduleURL = _$v.scheduleURL;
      _eventImagesURL = _$v.eventImagesURL;
      _youTubeURL = _$v.youTubeURL;
      _cfpURL = _$v.cfpURL;
      _archived = _$v.archived;
      _cfpActive = _$v.cfpActive;
      _locationId = _$v.locationId;
      _locationName = _$v.locationName;
      _timezone = _$v.timezone;
      _cfpFromDate = _$v.cfpFromDate;
      _cfpEndDate = _$v.cfpEndDate;
      _cfpKey = _$v.cfpKey;
      _tracks = _$v.tracks?.toBuilder();
      _languages = _$v.languages?.toBuilder();
      _sessionTypes = _$v.sessionTypes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Conference other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Conference;
  }

  @override
  void update(void Function(ConferenceBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Conference build() {
    _$Conference _$result;
    try {
      _$result = _$v ??
          new _$Conference._(
              id: id,
              name: name,
              website: website,
              imageURL: imageURL,
              apiURL: apiURL,
              fromDate: fromDate,
              toDate: toDate,
              eventCategory: eventCategory,
              description: description,
              scheduleURL: scheduleURL,
              eventImagesURL: eventImagesURL,
              youTubeURL: youTubeURL,
              cfpURL: cfpURL,
              archived: archived,
              cfpActive: cfpActive,
              locationId: locationId,
              locationName: locationName,
              timezone: timezone,
              cfpFromDate: cfpFromDate,
              cfpEndDate: cfpEndDate,
              cfpKey: cfpKey,
              tracks: _tracks?.build(),
              languages: _languages?.build(),
              sessionTypes: _sessionTypes?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tracks';
        _tracks?.build();
        _$failedField = 'languages';
        _languages?.build();
        _$failedField = 'sessionTypes';
        _sessionTypes?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Conference', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
