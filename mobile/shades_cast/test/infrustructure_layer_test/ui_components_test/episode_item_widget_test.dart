import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';

class MockPodcastDetailsAndPlayerBloc extends Mock
    implements PodcastDetailsAndPlayerBloc {}

void main() {
  late PodcastDetailsAndPlayerBloc mockBloc;

  setUp(() {
    mockBloc = MockPodcastDetailsAndPlayerBloc();
  });

  testWidgets('EpisodeItem triggers event on tap', (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockBloc,
          child: EpisodeItem(
            name: 'Episode 1',
            duration: Duration(minutes: 30),
            isSelected: false,
            myIndex: 0,
          ),
        ),
      ),
    );

    // Trigger a tap on the GestureDetector
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Verify that the event was triggered on the bloc
    verify(mockBloc.add(EpisodeItemClicked(selectedIndex: 0, podcastId: 1)))
        .called(1);
  });

  // Add more widget tests to cover different scenarios
}
