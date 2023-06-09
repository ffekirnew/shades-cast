import 'package:shades_cast/Infrustructure_layer/api_clients/constants.dart';

class Podcast {
  int id;
  String title;
  String? author;
  String? description;
  String? imageUrl;
  List? categories;

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
      'id': id.toString(),
      'title': title,
      'description': description,
      'author': author ?? "",
      'imageUrl': imageUrl ?? "",
      'categories': categories![0][0]
    };
  }

  static Podcast fromMap(Map<String, dynamic> map) {
    return Podcast(
      id: 'fa'.runtimeType == map['id'].runtimeType
          ? int.parse(map['id'])
          : map['id'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      imageUrl: map['cover_image'],
      categories: [map['categories']],
    );
  }
}
