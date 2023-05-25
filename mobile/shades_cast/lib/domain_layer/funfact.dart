class Funfact {
  final String title;
  final String body;

  Funfact({
    required this.title,
    required this.body,
  });

  Map<String, String> toMap() {
    return {
      "title": title,
      "body": body,
    };
  }

  factory Funfact.fromMap(Map<String, dynamic> map) {
    return Funfact(
      title: map["title"],
      body: map["body"],
    );
  }
}
