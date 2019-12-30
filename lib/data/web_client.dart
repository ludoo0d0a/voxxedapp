// Copyright 2018, Devoxx
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/schedule.dart';
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/models/serializers.dart';
import 'package:voxxedapp/models/speaker.dart';

class WebClientException implements Exception {
  final String message;

  const WebClientException(this.message);
}

class WebClient {
  static const _requestTimeoutDuration = Duration(seconds: 10);
  static const maxAttempts = 3;

  static const String url_base = "https://www.devoxxians.com";

  const WebClient();

  String createAllConferencesUrl() =>
      '${url_base}/api/voxxeddays/events/future/voxxed';

  String createSingleConferenceUrl(int id) =>
      '${url_base}/api/voxxeddays/events/$id';

  String createAllSpeakersUrl(String cfpUrl, String cfpKey) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpKey/speakers';

  String createSingleSpeakerUrl(
          String cfpUrl, String cfpKey, String uuid) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpKey/speakers/$uuid';

  String createAllSchedulesUrl(String cfpUrl, String cfpKey) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpKey/schedules/';

  String createSingleScheduleUrl(
          String cfpUrl, String cfpKey, String day) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpKey/schedules/$day/';

  // Some (but not all) CFP Urls come back with a trailing slash. This method
  // removes any that are found, so the URL creation getters above always return
  // a URL that doesn't have double-up slashes.
  String _trimFinalSlash(String url) {
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  Future<http.Response> _makeRequest(String url) async {
    int attempts = 0;
    http.Response response;

    do {
      attempts++;
      response =
          await http.get(url).timeout(_requestTimeoutDuration).catchError((_) {
        throw WebClientException('Timed out requesting $url.');
      });
    } while (response.statusCode == 500 && attempts < maxAttempts);

    return response;
  }

  Future<BuiltList<Conference>> fetchConferences() async {
    try {
      final response = await _makeRequest(createAllConferencesUrl());

      if (response.statusCode != 200) {
        throw WebClientException(
            'Failed to fetch conferences, status: ${response.statusCode}');
      }

      final parsedJson = json.decode(response.body);
      final deserialized = serializers.deserialize(
        parsedJson,
        specifiedType: Conference.listSerializationType,
      );

      return deserialized;
    } on http.ClientException catch (e) {
      throw WebClientException(e.message);
    } on FormatException catch (e) {
      throw WebClientException(e.message);
    }
  }

  Future<Conference> fetchConference(int id) async {
    try {
      final response = await _makeRequest(createSingleConferenceUrl(id));

      if (response.statusCode != 200) {
        throw WebClientException(
            'Failed to fetch conference $id, status: ${response.statusCode}');
      }

      final parsedJson = json.decode(response.body);
      final deserialized =
          serializers.deserializeWith(Conference.serializer, parsedJson);
      return deserialized;
    } on http.ClientException catch (e) {
      throw WebClientException(e.message);
    } on FormatException catch (e) {
      throw WebClientException(e.message);
    }
  }

  Future<BuiltList<Speaker>> fetchSpeakers(
      String cfpUrl, String cfpKey) async {
    try {
      final response =
          await _makeRequest(createAllSpeakersUrl(cfpUrl, cfpKey));

      if (response.statusCode != 200) {
        throw WebClientException('Failed to fetch speakers for $cfpKey, '
            'status: ${response.statusCode}');
      }

      final parsedJson = json.decode(response.body);
      final deserialized = serializers.deserialize(
        parsedJson,
        specifiedType: Speaker.listSerializationType,
      );

      return deserialized;
    } on http.ClientException catch (e) {
      throw WebClientException(e.message);
    } on FormatException catch (e) {
      throw WebClientException(e.message);
    }
  }

  Future<Speaker> fetchSpeaker(
      String cfpUrl, String cfpKey, String uuid) async {
    try {
      final response =
          await _makeRequest(createSingleSpeakerUrl(cfpUrl, cfpKey, uuid));

      if (response.statusCode != 200) {
        throw WebClientException('Failed to fetch speaker for $uuid at '
            '$cfpKey, status: ${response.statusCode}');
      }

      final parsedJson = json.decode(response.body);
      final deserialized =
          serializers.deserializeWith(Speaker.serializer, parsedJson);

      return deserialized;
    } on http.ClientException catch (e) {
      throw WebClientException(e.message);
    } on FormatException catch (e) {
      throw WebClientException(e.message);
    }
  }

  Future<BuiltList<Schedule>> fetchSchedules(
      String cfpUrl, String cfpKey) async {
    try {
      final response =
          await _makeRequest(createAllSchedulesUrl(cfpUrl, cfpKey));

      if (response.statusCode != 200) {
        throw WebClientException('Failed to fetch schedules for $cfpKey, '
            'status: ${response.statusCode}');
      }

      final parsedJson = json.decode(response.body);
      final schedules = <Schedule>[];

      // Pulls individual details out of the list provided by the API and
      // creates Schedule objects with them. The day property is the last part
      // of the URL, so it's nipped off and stored.
      //
      // The title string for each schedule currently has a template field
      // added, which this code removes.
      for (final link in parsedJson['links']) {
        final hrefParts = link['href'].split('/');
        schedules.add(
          Schedule((b) => b
            ..day = hrefParts[hrefParts.length - 1]
            ..title = link['title'].toString().replaceAll(', {0}', '')),
        );
      }

      return BuiltList<Schedule>(schedules);
    } on http.ClientException catch (e) {
      throw WebClientException(e.message);
    } on FormatException catch (e) {
      throw WebClientException(e.message);
    }
  }

  Future<BuiltList<ScheduleSlot>> fetchScheduleSlots(
      String cfpUrl, String cfpKey, String day) async {
    try {
      final response =
          await _makeRequest(createSingleScheduleUrl(cfpUrl, cfpKey, day));

      if (response.statusCode != 200) {
        throw WebClientException('Failed to fetch $day schedule at '
            '$cfpKey, status: ${response.statusCode}');
      }

      final parsedJson = json.decode(response.body)['slots'];

      for (final slot in parsedJson as List) {
        if (slot['talk'] != null && slot['talk']['speakers'] != null) {
          final uuids = <String>[];
          for (final speaker in slot['talk']['speakers']) {
            uuids.add(speaker['link']['uuid']);
          }
          slot['talk']['speakerUuids'] = uuids;
        }
      }

      // The slots for a schedule are returned as a list inside a JSON object
      // with a single property, "slots." This method only cares about the
      // talks, so everything else is ignored.
      final slots = serializers.deserialize(
        parsedJson,
        specifiedType: ScheduleSlot.listSerializationType,
      );

      return BuiltList<ScheduleSlot>(slots);
    } on http.ClientException catch (e) {
      throw WebClientException(e.message);
    } on FormatException catch (e) {
      throw WebClientException(e.message);
    }
  }
}
