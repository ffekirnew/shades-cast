import 'package:flutter/material.dart';

class PodcastPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Podcast Title',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Slider(
                //   // slider properties and logic here
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle back button press
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        size: 36,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle play button press
                      },
                      icon: Icon(
                        Icons.play_circle_filled,
                        size: 56,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle next button press
                      },
                      icon: Icon(
                        Icons.skip_next,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
