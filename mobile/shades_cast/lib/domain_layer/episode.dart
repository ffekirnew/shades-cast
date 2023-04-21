class Episode {
  final String id;
  final String title;
  final String description;
  final String audioUrl;
  final DateTime publishedDate;
  final int durationInSeconds;
  bool isLiked;

  Episode({
    required this.id,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.publishedDate,
    required this.durationInSeconds,
    this.isLiked = false,
  });
}
