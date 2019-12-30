// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';

import 'package:voxxedapp/models/enums.dart';
import 'package:voxxedapp/models/serializers.dart';
import 'package:voxxedapp/models/conference.dart';

const String voxxedDayJson = '''
  {
        id: 66,
        name: "UnVoxxed Hawaii",
        eventCategory: "VOXXED",
        fromDate: "2020-02-24T09:00:00Z",
        toDate: "2020-02-25T17:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/ce33723c-5802-4a2d-8dbf-b23d927209cc.jpg",
        website: "https://voxxeddays.com/hawaii/",
        apiURL: "UnVoxxedHawaii.comfinabox.com/api",
        cfpKey: "unvoxxedhawaii"
    }
''';

const String listOfVoxxedDaysJson = '''
  [{
        id: 66,
        name: "UnVoxxed Hawaii",
        eventCategory: "VOXXED",
        fromDate: "2020-02-24T09:00:00Z",
        toDate: "2020-02-25T17:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/ce33723c-5802-4a2d-8dbf-b23d927209cc.jpg",
        website: "https://voxxeddays.com/hawaii/",
        apiURL: "UnVoxxedHawaii.comfinabox.com/api",
        cfpKey: "unvoxxedhawaii"
    },
    {
        id: 72,
        name: "Voxxed Days Zürich 2020",
        eventCategory: "VOXXED",
        fromDate: "2020-03-10T08:00:00Z",
        toDate: "2020-03-10T18:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/9156e2a7-1495-41d3-8361-2782b38b581e.jpg",
        website: "https://voxxeddays.com/zurich/",
        apiURL: "vdz20.cfp.dev/api",
        cfpKey: "vdz20"
    },
    {
        id: 71,
        name: "Voxxed Days Bucharest 2020",
        eventCategory: "VOXXED",
        fromDate: "2020-03-11T09:00:00Z",
        toDate: "2020-03-13T18:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/c478a000-c100-4e3b-8e97-91fa7f240e8b.jpg",
        website: "https://romania.voxxeddays.com/bucharest/2019-03-20/",
        apiURL: "vxdbuh20.confinabox.com",
        cfpKey: "vxdbuh20"
    },
    {
        id: 73,
        name: "Voxxed Days Thessaloniki 2020",
        eventCategory: "VOXXED",
        fromDate: "2020-04-03T07:00:00Z",
        toDate: "2020-04-04T17:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/19181d96-570c-4bdb-9603-b01d7647d715.jpg",
        website: "https://voxxeddays.com/thessaloniki/",
        apiURL: "https://vdthess2020.cfp.dev/api",
        cfpKey: "vdthess2020"
    },
    {
        id: 75,
        name: "Voxxed Days Milan 2020",
        eventCategory: "VOXXED",
        fromDate: "2020-05-16T07:00:00Z",
        toDate: "2020-05-16T17:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/585b94e0-bb79-4d4d-830a-7291294a1c37.jpg",
        website: "https://voxxeddays.com/milan/",
        apiURL: "vdm20.cfp.dev/api",
        cfpKey: "vdm20"
    },
    {
        id: 74,
        name: "Voxxed Days Frontend 2020",
        eventCategory: "VOXXED",
        fromDate: "2020-05-19T07:00:00Z",
        toDate: "2020-05-20T17:00:00Z",
        imageURL: "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/7e4e9cf0-5196-42ee-b78c-45560b655bc1.jpg",
        website: "https://romania.voxxeddays.com/frontend/",
        apiURL: "vxdfrontend@cfp.dev",
        cfpKey: "vxdfrontend"
    }
]
''';

void main() {
  group('VoxxedDay serialization', () {
    test('Correctly deserialize a typical VoxxedDay', () {
      final voxxedDay = serializers.deserializeWith(
          Conference.serializer, json.decode(voxxedDayJson));
      expect(voxxedDay.id, 66);
      expect(voxxedDay.name, 'UnVoxxed Hawaii');
      expect(voxxedDay.eventCategory, EventCategory.VOXXED);
      expect(voxxedDay.fromDate, '2020-02-24T09:00:00Z');
      expect(voxxedDay.toDate, '2020-02-25T17:00:00Z');
//      expect(voxxedDay.toDate, '2018-10-20');
      expect(voxxedDay.imageURL,
          'https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/ce33723c-5802-4a2d-8dbf-b23d927209cc.jpg');
      expect(voxxedDay.website, 'https://voxxeddays.com/hawaii/');
    });

    test('Correctly deserialize a list of VoxxedDays', () {
      final list = json
          .decode(listOfVoxxedDaysJson)
          .map((o) => serializers.deserializeWith(Conference.serializer, o))
          .toList();

      expect(list.length, 6);
    });
  });
}
