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

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/blocs/schedule_bloc.dart';
import 'package:voxxedapp/blocs/speaker_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/schedule.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/util/string_utils.dart' as strutils;
import 'package:voxxedapp/widgets/invalid_navigation_notice.dart';
import 'package:voxxedapp/widgets/main_drawer.dart';
import 'package:voxxedapp/widgets/schedule_slot_item.dart';
import 'package:voxxedapp/widgets/speaker_item.dart';
import 'package:voxxedapp/widgets/track_item.dart';

class NoDataNotice extends StatelessWidget {
  const NoDataNotice(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontStyle: FontStyle.italic),
      ),
    );
  }
}

class SpeakerPanel extends StatelessWidget {
  const SpeakerPanel(this.conferenceId);

  final int conferenceId;

  @override
  Widget build(BuildContext context) {
    return FirstBuildDispatcher<AppState>(
      action: RefreshSpeakersForConferenceAction(conferenceId),
      child: ViewModelSubscriber<AppState, List<Speaker>>(
        converter: (state) {
          return state.speakers.containsKey(conferenceId)
              ? (state.speakers[conferenceId].toList()..sort())
              : <Speaker>[];
        },
        builder: (context, dispatcher, speakerList) {
          if (speakerList == null || speakerList.length == 0) {
            return NoDataNotice('Speaker list not yet finalized.');
          }

          return ListView(
            children: speakerList
                .map<Widget>((s) => SpeakerItem(s, conferenceId))
                .toList(),
          );
        },
      ),
    );
  }
}

class ConferenceInfoPanel extends StatelessWidget {
  const ConferenceInfoPanel(this.conferenceId);

  final int conferenceId;

  Widget _buildHeader(
      BuildContext context, Conference conference, ThemeData theme) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 200.0),
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Image.network(
              conference.imageURL,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 10.0,
              ),
              color: Colors.white,
              child: Text(
                conference.name,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(
      BuildContext context, Conference conference, ThemeData theme) {
    String dateStr;

    if (conference.fromDate == null && conference.toDate == null) {
      dateStr = 'Not yet determined';
    } else if (conference.fromDate == conference.toDate) {
      dateStr = conference.fromDate;
    } else {
      dateStr = '${conference.fromDate} to ${conference.toDate}';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            conference.locationName ?? 'Location not yet determined',
            style: theme.textTheme.subhead,
          ),
          SizedBox(height: 4.0),
          Text(
            dateStr,
            style: theme.textTheme.subhead.copyWith(
              color: Color(0xff808080),
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              conference.description ?? 'No description provided.',
              style: theme.textTheme.body1,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTrackList(
      BuildContext context, Conference conference, ThemeData theme) {
    var children = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Conference tracks', style: theme.textTheme.subhead),
      ),
    ];

    if (conference.tracks == null || conference.tracks.length == 0) {
      children.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Not yet finalized.',
            style: theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      );
    } else {
      var count = 0;
      for (final track in conference.tracks) {
        children.add(
            TrackItem(track, conferenceId, alternateColor: count % 2 == 0));
        count++;
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelSubscriber<AppState, Conference>(
      converter: (state) => state.conferences[conferenceId],
      builder: (context, dispatcher, conference) => ListView(
            children: <Widget>[
              _buildHeader(context, conference, theme),
              SizedBox(height: 12.0),
              _buildInfoBlock(context, conference, theme),
              SizedBox(height: 12.0),
            ]..addAll(_buildTrackList(context, conference, theme)),
          ),
    );
  }
}

class ScheduleViewModel {
  final int conferenceId;
  final BuiltList<Speaker> speakers;
  final BuiltList<Schedule> schedules;
  final BuiltMap<String, int> sessionNotifications;

  ScheduleViewModel(AppState state, this.conferenceId)
      : schedules = state.schedules[conferenceId],
        speakers = state.speakers[conferenceId],
        sessionNotifications = state.sessionNotifications;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleViewModel &&
          runtimeType == other.runtimeType &&
          conferenceId == other.conferenceId &&
          speakers == other.speakers &&
          schedules == other.schedules &&
          sessionNotifications == other.sessionNotifications;

  @override
  int get hashCode =>
      conferenceId.hashCode ^
      speakers.hashCode ^
      schedules.hashCode ^
      sessionNotifications.hashCode;
}

class SchedulePanel extends StatelessWidget {
  const SchedulePanel(this.conferenceId);

  final int conferenceId;

  List<Widget> _buildScheduleWidgets(
      ScheduleViewModel model, String day, ThemeData theme) {
    // Locate correct schedule for the day.
    final sched = model.schedules.firstWhere((s) => s.day == day);

    // Occasionally the API will return empty slots, though this isn't supposed
    // to ever happen.
    final slots =
        sched.slots.where((s) => s.talk != null || s.scheduleBreak != null);

    // In order to group the slots by time range, the most recent range is
    // stored. Only when it changes from one slot to the next while iterating
    // the list will a new Text be created to show it.
    String lastTimeStr = '';

    final widgets = <Widget>[];

    for (final slot in slots) {
      bool isFavorite = model.sessionNotifications.containsKey(slot.talk?.id);
      final speakers = <Speaker>[];

      for (final uuid in slot.talk.speakerUuids) {
        final speaker = model.speakers
            ?.firstWhere((s) => s.uuid == uuid, orElse: () => null);
        if (speaker != null) {
          speakers.add(speaker);
        }
      }

      String timeStr = '${slot.fromTime} to ${slot.toTime}';

      if (timeStr != lastTimeStr) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 8.0),
          child: Text(
            timeStr,
            style: theme.textTheme.headline,
          ),
        ));

        lastTimeStr = timeStr;
      }

      widgets.add(
        ScheduleSlotItem(
          slot,
          conferenceId,
          speakers,
          isFavorite: isFavorite,
        ),
      );
    }

    widgets.add(SizedBox(height: 16.0));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return FirstBuildDispatcher<AppState>(
      action: RefreshSchedulesAction(conferenceId),
      child: ViewModelSubscriber<AppState, ScheduleViewModel>(
        converter: (state) => ScheduleViewModel(state, conferenceId),
        builder: (context, dispatcher, model) {
          final theme = Theme.of(context);

          if (model.schedules == null || model.schedules.isEmpty) {
            return NoDataNotice('Schedule not yet finalized');
          }

          final scheduleLists = <Widget>[];

          for (final sch in model.schedules) {
            if (sch.slots == null || sch.slots.isEmpty) {
              scheduleLists.add(
                NoDataNotice('${strutils.capitalize(sch.day)} '
                    'schedule not yet finalized.'),
              );
            } else {
              scheduleLists.add(
                ListView(
                  children: _buildScheduleWidgets(model, sch.day, theme),
                ),
              );
            }
          }

          // If there is more than day's schedule for the conference, the AppBar
          // that will contain this widget will have a TabBar and controller set
          // up, so the lists should be returned in a TabVarView. Otherwise,
          // there will just be one list, which can be returned on its own.
          if (scheduleLists.length > 1) {
            return TabBarView(
              children: scheduleLists,
            );
          } else {
            return scheduleLists[0];
          }
        },
      ),
    );
  }
}

class ConferenceDetailScreenViewModel {
  final String name;
  final List<String> days;

  ConferenceDetailScreenViewModel(AppState state, int conferenceId)
      : name = state.conferences[conferenceId]?.name,
        days =
            state.schedules[conferenceId]?.map<String>((s) => s.day)?.toList();
}

class ConferenceDetailScreen extends StatefulWidget {
  final int conferenceId;

  const ConferenceDetailScreen(this.conferenceId);

  @override
  _ConferenceDetailScreenState createState() {
    return new _ConferenceDetailScreenState();
  }
}

class _ConferenceDetailScreenState extends State<ConferenceDetailScreen> {
  int _navBarSelection = 0;

  Widget _buildBody() {
    if (_navBarSelection == 0) {
      return ConferenceInfoPanel(widget.conferenceId);
    } else if (_navBarSelection == 1) {
      return SchedulePanel(widget.conferenceId);
    } else {
      return SpeakerPanel(widget.conferenceId);
    }
  }

  Widget _buildInvalidNavigationNotice() {
    return InvalidNavigationNotice(
      'Conference not found',
      'Conference record could not be found or is no longer valid.\n\n'
          'Use the menu to select another.',
      showDrawer: true,
    );
  }

  Widget _buildAppBarBottom(List<String> days) {
    if (days.length <= 1 || _navBarSelection != 1) {
      // Either the user isn't on the schedule tab or there aren't multiple
      // days in the schedule, so no TabBar is needed.
      return null;
    }

    return TabBar(
      tabs: days.map<Widget>((s) => Tab(text: strutils.capitalize(s))).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() => _navBarSelection = index);
      },
      currentIndex: _navBarSelection,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text('Info'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          title: Text('Schedule'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Speakers'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FirstBuildDispatcher<AppState>(
      action: RefreshConferenceAction(widget.conferenceId),
      child: ViewModelSubscriber<AppState, ConferenceDetailScreenViewModel>(
        converter: (state) =>
            ConferenceDetailScreenViewModel(state, widget.conferenceId),
        builder: (context, dispatcher, viewModel) {
          if (viewModel.name == null) {
            // No name means conferenceId doesn't match a real conference.
            return _buildInvalidNavigationNotice();
          }

          final scaffold = Scaffold(
            appBar: AppBar(
              title: Text(viewModel.name),
              bottom: _buildAppBarBottom(viewModel.days),
            ),
            drawer: MainDrawer(),
            body: _buildBody(),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );

          // If the schedule pane is being presented with more than one day, the
          // Scaffold needs to be wrapped in a DefaultTabController for the
          // TabView and TabBar to use.
          if (viewModel.days.length > 1 && _navBarSelection == 1) {
            return DefaultTabController(
              length: viewModel.days.length,
              child: scaffold,
            );
          }

          // Otherwise the Scaffold is good to go on its own.
          return scaffold;
        },
      ),
    );
  }
}
