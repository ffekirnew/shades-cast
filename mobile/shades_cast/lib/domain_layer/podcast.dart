class Podcast {
  final String id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String categories;

  Podcast(
      {required this.id,
      required this.title,
      required this.author,
      required this.description,
      required this.imageUrl,
      required this.categories});
}

// Podcast({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.description,
//     required this.imageUrl,
//     required this.categories,
//   });