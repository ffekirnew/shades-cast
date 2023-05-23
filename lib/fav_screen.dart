import 'dart:convert';
import 'package:flutter/material.dart';
import 'podcast.dart';
import 'infrastructure.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final db = DataBase();
  late List<Podcast> favoritePodcasts = db.podcasts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Favorites")),
        body: ListView.builder(
            itemCount: favoritePodcasts.length,
            itemBuilder: (BuildContext context, int index) {
              Podcast? podcast = favoritePodcasts[index];

              return ListTile(
                leading: Stack(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.istockphoto.com/es/foto/micr%C3%B3fono-de-estudio-en-luces-de-ne%C3%B3n-equipo-de-grabaci%C3%B3n-de-sonido-gm1400623377-454141206?phrase=podcast'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        onPressed: () {
                          // Handle play button press
                        },
                        icon: Icon(
                          Icons.play_circle_filled,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(podcast.title),
                subtitle: Text(podcast.creator),
                onTap: () {
                  // Handle the podcast selection here, e.g., play the podcast
                },
              );
            }));
  }
}
