class Funfact {
  final String title;
  final String body;
  String id;

  Funfact({
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, String> toMap() {
    return {
      "id": this.id.toString(),
      "title": title,
      "body": body,
    };
  }

  factory Funfact.fromMap(Map<String, dynamic> map) {
    return Funfact(
      id: map['id'].toString(),
      title: map["title"],
      body: map["body"],
    );
  }
}
