import 'package:shades_cast/domain_layer/episode.dart';
import 'package:test/test.dart';

void main() {
  group('Episode', () {
    final episodeData = {
      'id': '1',
      'podcastId': 'abc123',
      'title': 'Episode Title',
      'description': 'Episode Description',
      'audioUrl': 'https://example.com/audio.mp3',
      'publishedDate': '2023-05-24T12:00:00Z',
      'durationInSeconds': 1800,
    };

    test('toMap() should return the episode data as a map', () {
      final episode = Episode(
        id: '1',
        podcastId: 'abc123',
        title: 'Episode Title',
        description: 'Episode Description',
        audioUrl: 'https://example.com/audio.mp3',
        publishedDate: DateTime.parse('2023-05-24T12:00:00Z'),
        durationInSeconds: 1800,
      );

      final result = episode.toMap();

      expect(result, equals(episodeData));
    });

    test('fromMap() should create an Episode instance from a map', () {
      final episode = Episode.fromMap(episodeData);

      expect(episode.id, equals('1'));
      expect(episode.podcastId, equals(null));
      expect(episode.title, equals('Episode Title'));
      expect(episode.description, equals('Episode Description'));
      expect(episode.audioUrl, equals('https://example.com/audio.mp3'));
      expect(episode.publishedDate,
          equals(DateTime.parse('2023-05-24T12:00:00Z')));
      expect(episode.durationInSeconds, equals(1800));
    });
  });
}
