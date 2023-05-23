class Podcast {
  int id;
  String creator;
  String title;
  String status;

  Podcast({
    required this.id,
    required this.creator,
    required this.title,
    required this.status,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'],
      creator: json['creator'],
      title: json['title'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator,
      'title': title,
      'status': status,
    };
  }
}
