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

import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/data/web_client.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/schedule.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/util/logger.dart';

class SelectConferenceAction extends Action {
  final int selectedConferenceId;

  SelectConferenceAction(this.selectedConferenceId);
}

/// Refresh the entire conference list (partial data for each conference):
class RefreshConferencesAction extends Action {}

class RefreshedConferencesAction extends Action {
  final BuiltList<Conference> conferences;

  RefreshedConferencesAction(this.conferences);
}

class RefreshConferencesFailedAction extends Action {}

/// Refresh a single conference:
class RefreshConferenceAction extends Action {
  final int id;

  RefreshConferenceAction(this.id);
}

class RefreshedConferenceAction extends Action {
  final conference;

  RefreshedConferenceAction(this.conference);
}

class RefreshConferenceFailedAction extends Action {}

/// Manages the loading and caching of conference records.
class ConferenceBloc extends SimpleBloc<AppState> {
  final WebClient webClient;

  ConferenceBloc({this.webClient = const WebClient()});

  Future<void> _refreshConferences(DispatchFunction dispatcher, AppState state,
      RefreshConferencesAction action) async {
    try {
      final conferences = await webClient.fetchConferences();
      final action = RefreshedConferencesAction(conferences);
      dispatcher(action);
    } on WebClientException catch (e) {
      logException('_refreshConferences', e.message);
      dispatcher(RefreshConferencesFailedAction());
    }
  }

  Future<void> _refreshConference(DispatchFunction dispatcher, AppState state,
      RefreshConferenceAction action) async {
    try {
      final conference = await webClient.fetchConference(action.id);
      if (conference != null) {
        dispatcher(RefreshedConferenceAction(conference));
      } else {
        dispatcher(RefreshConferenceFailedAction());
      }
    } on WebClientException catch (e) {
      logException('_refreshConference', e.message);
      dispatcher(RefreshConferenceFailedAction());
    }
  }

  AppState _refreshedConferences(
      AppState state, RefreshedConferencesAction action) {
    final oldIds = state.conferences.keys.toList();
    final newIds = action.conferences.map((c) => c.id);

    // Conferences currently in the app state that shouldn't be.
    final staleIds = oldIds.where((id) => !newIds.contains(id));

    // Conferences that are new and aren't in the app state.
    final newConfs = action.conferences.where((c) => !oldIds.contains(c.id));

    // Conferences that are already in the app state and should be updated with
    // any new data that was just loaded.
    final oldConfs = action.conferences.where((c) => oldIds.contains(c.id));

    // If the old selected conference is no longer around, pick the first one as
    // a replacement.
    final selectedConferenceId = (newIds.contains(state.selectedConferenceId))
        ? state.selectedConferenceId
        : newIds.first;

    var newState = state.rebuild((b) {
      for (int staleId in staleIds) {
        b.conferences.remove(staleId);
      }
      for (Conference newConf in newConfs) {
        b.conferences[newConf.id] = newConf;
      }
      for (Conference oldConf in oldConfs) {
        b.conferences[oldConf.id].rebuild((cb) => cb
          ..name = oldConf.name
          ..eventCategory = oldConf.eventCategory
          ..fromDate = oldConf.fromDate
          ..toDate = oldConf.toDate
          ..imageURL = oldConf.imageURL
          ..website = oldConf.website);
      }
      b.selectedConferenceId = selectedConferenceId;
    });

    return newState.rebuild((b) => b
      ..speakers.replace(_reconcileSpeakerLists(newState))
      ..schedules.replace(_reconcileScheduleLists(newState)));
  }

  AppState _refreshedConference(
      AppState state, RefreshedConferenceAction action) {
    return state.rebuild(
        (b) => b..conferences[action.conference.id] = action.conference);
  }

  BuiltMap<int, BuiltList<Speaker>> _reconcileSpeakerLists(AppState state) {
    // IDs that are no longer in the list of conferences, so their corresponding
    // speaker lists should be removed.
    final staleIds = state.speakers.keys.toList()
      ..removeWhere((id) => state.conferences.containsKey(id));

    // New conference IDs for which speaker lists haven't yet been created.
    final newIds = state.conferences.keys
        .where((id) => !state.speakers.containsKey(id))
        .toList();

    // Add the new stuff and remove the stale.
    return state.speakers.rebuild((b) {
      b.addIterable(newIds, key: (i) => i, value: (_) => BuiltList<Speaker>());
      for (int staleId in staleIds) {
        b.remove(staleId);
      }
    });
  }

  BuiltMap<int, BuiltList<Schedule>> _reconcileScheduleLists(AppState state) {
    // IDs that are no longer in the list of conferences, so their corresponding
    // schedule lists should be removed.
    final staleIds = state.schedules.keys.toList()
      ..removeWhere((id) => state.conferences.containsKey(id));

    // New conference IDs for which speaker lists haven't yet been created.
    final newIds = state.conferences.keys
        .where((id) => !state.schedules.containsKey(id))
        .toList();

    // Add the new stuff and remove the stale.
    return state.schedules.rebuild((b) {
      b.addIterable(newIds, key: (i) => i, value: (_) => BuiltList<Schedule>());
      for (int staleId in staleIds) {
        b.remove(staleId);
      }
    });
  }

  AppState _selectConference(AppState state, SelectConferenceAction action) {
    if (state.conferences.containsKey(action.selectedConferenceId)) {
      return state.rebuild(
          (b) => b..selectedConferenceId = action.selectedConferenceId);
    }

    return state;
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshConferencesAction) {
      _refreshConferences(dispatcher, state, action);
    }

    if (action is RefreshConferenceAction) {
      _refreshConference(dispatcher, state, action);
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is RefreshedConferencesAction) {
      return _refreshedConferences(state, action);
    }

    if (action is RefreshedConferenceAction) {
      return _refreshedConference(state, action);
    }

    if (action is SelectConferenceAction) {
      return _selectConference(state, action);
    }

    return state;
  }

  @override
  FutureOr<Action> afterware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is RefreshedConferencesAction) {
      dispatcher(RefreshConferenceAction(state.selectedConferenceId));
    }

    return action;
  }
}
