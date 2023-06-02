//this class defines the domain of the Episode entity
class Episode {
  final id;
  final title;
  final podcastId;
  final description;
  final audioUrl;
  final publishedDate;
  final durationInSeconds;

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
    };
  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      id: int.parse(map['id']),
      podcastId: map['podcast'],
      title: map['title'],
      description: map['description'],
      publishedDate: map['publish'],
      durationInSeconds: map['audio_duration'],
      audioUrl: map['audio_file'],
    );
  }
}
