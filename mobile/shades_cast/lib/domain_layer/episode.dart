//this class defines the domain of the Episode entity
class Episode {
  final String id;
  final String title;
  final String podcastId;
  final String description;
  final String audioUrl;
  final DateTime publishedDate;
  final int durationInSeconds;

  Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.publishedDate,
    required this.durationInSeconds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'podcastId': podcastId,
      'title': title,
      'description': description,
      'audioUrl': audioUrl,
      'publishedDate': publishedDate,
      'durationInSeconds': durationInSeconds,
    };
  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      id: map['id'],
      podcastId: map['podcastId'],
      title: map['title'],
      description: map['description'],
      audioUrl: map['audioUrl'],
      publishedDate: map['publishedDate'],
      durationInSeconds: map['durationInSeconds'],
    );
  }
}



// [
//   {
//     "id": 0,
//     "title": "string",
//     "audio_file": "string",
//     "audio_duration": 0,
//     "audio_size": 0,
//     "podcast": 0,
//     "tags": [
//       "string"
//     ],
//     "publish": "2023-05-11T18:59:26.758Z",
//     "description": "string",
//     "status": "draft"
//   }
// ]