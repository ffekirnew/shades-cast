class Funfact {
  final String? id;
  final String title;
  final String body;

  Funfact({
    this.id = "",
    required this.title,
    required this.body,
  });

  Map<String, String> toMap() {
    return {
      "id": id!,
      "title": title,
      "body": body,
    };
  }

  factory Funfact.fromMap(Map<String, dynamic> map) {
    return Funfact(
      id: map["id"].toString(),
      title: map["title"],
      body: map["body"],
    );
  }
}
