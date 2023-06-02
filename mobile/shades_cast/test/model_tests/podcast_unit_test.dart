import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:test/test.dart';

void main() {
  group('Podcast', () {
    test('fromJson() should create a Podcast instance from JSON', () {
      final jsonData = {
        'id': 123,
        'title': 'My Podcast',
        'creator': 'John Doe',
        'description': 'Podcast description',
        'cover_image': 'https://example.com/cover.jpg',
        'categories': ['Technology', 'Science']
      };

      final podcast = Podcast.fromJson(jsonData);

      expect(podcast.id, equals(123));
      expect(podcast.title, equals('My Podcast'));
      expect(podcast.author, equals('John Doe'));
      expect(podcast.description, equals('Podcast description'));
      expect(podcast.imageUrl, equals('https://example.com/cover.jpg'));
      expect(podcast.categories, equals(['Technology', 'Science']));
    });

    test('toMap() should return the podcast data as a map', () {
      final podcast = Podcast(
        id: 123,
        title: 'My Podcast',
        author: 'John Doe',
        description: 'Podcast description',
        imageUrl: 'https://example.com/cover.jpg',
        categories: ['Technology', 'Science'],
      );

      final result = podcast.toMap();

      expect(
          result,
          equals({
            'id': 123,
            'title': 'My Podcast',
            'author': 'John Doe',
            'description': 'Podcast description',
            'imageUrl': 'https://example.com/cover.jpg',
            'categories': ['Technology', 'Science'],
          }));
    });

    test('fromMap() should create a Podcast instance from a map', () {
      final podcastData = {
        'id': 123,
        'title': 'My Podcast',
        'author': 'John Doe',
        'description': 'Podcast description',
        'imageUrl': 'https://example.com/cover.jpg',
        'categories': ['Technology', 'Science']
      };

      final podcast = Podcast.fromMap(podcastData);

      expect(podcast.id, equals(123));
      expect(podcast.title, equals('My Podcast'));
      expect(podcast.author, equals('John Doe'));
      expect(podcast.description, equals('Podcast description'));
      expect(podcast.imageUrl, equals('https://example.com/cover.jpg'));
      expect(podcast.categories, equals(['Technology', 'Science']));
    });
  });
}
