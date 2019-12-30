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

import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:voxxedapp/blocs/app_state_bloc.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/blocs/favorites_bloc.dart';
import 'package:voxxedapp/blocs/logger_bloc.dart';
import 'package:voxxedapp/blocs/navigation_bloc.dart';
import 'package:voxxedapp/blocs/schedule_bloc.dart';
import 'package:voxxedapp/blocs/speaker_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/screens/about_screen.dart';
import 'package:voxxedapp/screens/conference_detail.dart';
import 'package:voxxedapp/screens/conference_list.dart';
import 'package:voxxedapp/screens/speaker_detail.dart';
import 'package:voxxedapp/screens/splash_screen.dart';
import 'package:voxxedapp/screens/talk_detail.dart';
import 'package:voxxedapp/screens/track_detail.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // This is created separately so we can refer to it later in [build].
  final navigatorKey = GlobalKey<NavigatorState>();

  // Holds and manages application state for the app.
  final store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [
      LoggerBloc(),
      DebouncerBloc<AppState>(
        [SaveAppStateAction],
        duration: Duration(seconds: 5),
      ),
      NavigationBloc(navigatorKey),
      AppStateBloc(),
      ConferenceBloc(),
      SpeakerBloc(),
      ScheduleBloc(),
      FavoritesBloc(),
    ],
  );

  // This will attempt to load a previously-saved app state from disk. A
  // request to the server for the list of conferences will automatically
  // follow. If both fail, the app can't run, and will halt on the splash
  // screen with a warning message.
  store.dispatch(LoadAppStateAction());

  runApp(new VoxxedDayApp(store, navigatorKey));
}

class VoxxedDayApp extends StatelessWidget {
  VoxxedDayApp(this.store, this.navigatorKey);

  final Store<AppState> store;
  final GlobalKey<NavigatorState> navigatorKey;

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');

    // Conference selector page.
    if (path[1] == 'conferences') {
      return new MaterialPageRoute<int>(
        builder: (context) => ConferenceListScreen(),
        settings: settings,
      );
    }

    // Details page for a single conference.
    if (path[1] == 'conference') {
      final conferenceId = int.parse(path[2]);

      if (path.length < 5) {
        return MaterialPageRoute(
          builder: (context) => ConferenceDetailScreen(conferenceId),
          settings: settings,
        );
      }

      // List of speakers for drill-down.
      if (path[3] == 'speaker') {
        final uuid = path[4];
        return MaterialPageRoute(
          builder: (context) => SpeakerDetailScreen(conferenceId, uuid),
          settings: settings,
        );
      }

      // Details of a conference track.
      if (path[3] == 'track') {
        final trackId = int.parse(path[4]);
        return MaterialPageRoute(
          builder: (context) => TrackDetailScreen(conferenceId, trackId),
          settings: settings,
        );
      }

      // Details of a conference talk.
      if (path[3] == 'talk') {
        final talkId = path[4];
        return MaterialPageRoute(
          builder: (context) => TalkDetailScreen(conferenceId, talkId),
          settings: settings,
        );
      }
    }

    // List of speakers for drill-down.
    if (path[1] == 'about') {
      return MaterialPageRoute(
        builder: (context) => AboutScreen(),
        settings: settings,
      );
    }

    // Must be time for the splash screen.
    return MaterialPageRoute(
      builder: (context) => SplashScreen(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Voxxed Days',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
        ),
        onGenerateRoute: _onGenerateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
