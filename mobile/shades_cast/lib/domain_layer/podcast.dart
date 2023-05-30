import 'package:shades_cast/Infrustructure_layer/api_clients/constants.dart';

class Podcast {
  final int id;
  final String title;
  final String? author;
  final String? description;
  final String? imageUrl;
  final List? categories;

  Podcast(
      {required this.id,
      required this.title,
      this.author,
      this.description,
      this.imageUrl,
      this.categories});

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'],
      title: json['title'],
      author: json['creator'],
      description: json['description'],
      imageUrl: json['cover_image'],
      categories: json['categories'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author ?? "",
      'imageUrl': imageUrl ?? "",
      'categories': categories![0]
    };
  }

  static Podcast fromMap(Map<String, dynamic> map) {
    return Podcast(
// <<<<<<< funfact
      id: map['id'] != null ? int.parse(map['id']) : 1,
// =======
//       id: map['id'],
// >>>>>>> master
      title: map['title'],
      author: map['author'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      categories: [map['categories']],
    );
  }
}
