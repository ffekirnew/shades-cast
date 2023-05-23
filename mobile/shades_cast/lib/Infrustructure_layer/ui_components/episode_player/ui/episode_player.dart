import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodePlayer extends StatefulWidget {
  final List<String> audioUrls;
  int currentEpisodeIndex;

  EpisodePlayer({required this.audioUrls, required this.currentEpisodeIndex}) {}

  @override
  _EpisodePlayerState createState() => _EpisodePlayerState();
}

class _EpisodePlayerState extends State<EpisodePlayer> {
  late AudioPlayer audioPlayer;
  late int currentAudioIndex;
  bool isPlaying = false;
  bool isSet = false;
  Duration currentDuration = Duration(seconds: 0);
  Duration? totalDuration;

  @override
  void initState() {
    print('initialized');
    audioPlayer = AudioPlayer();
    currentAudioIndex = widget.currentEpisodeIndex;
    setAudio();
    audioPlayer.positionStream.listen((position) {
      setState(() {
        currentDuration = position;
      });
      super.initState();
    });
  }

  void setAudio() async {
    currentAudioIndex = widget.currentEpisodeIndex;
    if (currentAudioIndex >= widget.audioUrls.length) {
      currentAudioIndex = 0;
    }
    if (currentAudioIndex < 0) {
      currentAudioIndex = widget.audioUrls.length - 1;
    }
    if ((widget.audioUrls.length > 0) & (widget.audioUrls[0] != '')) {
      print('here hiiiiiiiiiiiiiiiii');
      await audioPlayer.setUrl(widget.audioUrls[currentAudioIndex]);
    }
    setState(() {
      totalDuration = audioPlayer.duration;
    });
  }

  void playAudio() async {
    setState(() {
      isPlaying = true;
    });
    await audioPlayer.play();
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
      currentDuration = audioPlayer.position;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentEpisodeIndex != -1) {
      setAudio();
      widget.currentEpisodeIndex = -1;
    }
    return Container(
      padding: EdgeInsets.only(top: 20),
      color: Color.fromARGB(5, 130, 130, 130),
      child: Column(
        children: [
          // Seek bar
          Container(
            child: Slider(
              activeColor: Color.fromARGB(205, 246, 246, 246),
              thumbColor: Colors.white,
              max: totalDuration?.inMilliseconds.toDouble() ?? 1,
              value: currentDuration.inMilliseconds.toDouble(),
              onChanged: (value) {
                audioPlayer.seek(Duration(milliseconds: value.toInt()));
                setState(() {
                  currentDuration = Duration(milliseconds: value.toInt());
                });
              },
            ),
          ),

          // Song controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text((currentDuration.toString().length > 7)
                    ? currentDuration.toString().substring(0, 7)
                    : '0:00:00'),
              ),
              SizedBox(width: 26),
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  BlocProvider.of<PodcastDetailsAndPlayerBloc>(context).add(
                      SkipToPreviousButtonClicked(
                          selectedIndex: currentAudioIndex));
                },
                color: Colors.white,
              ),
              SizedBox(width: 16),
              IconButton(
                icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                onPressed: () {
                  isPlaying ? pauseAudio() : playAudio();
                },
                color: Colors.white,
                iconSize: 48,
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  BlocProvider.of<PodcastDetailsAndPlayerBloc>(context).add(
                      SkipToNextButtonClicked(
                          selectedIndex: currentAudioIndex));
                },
                color: Colors.white,
              ),
              SizedBox(width: 26),
              Container(
                child: Text((totalDuration.toString().length > 7)
                    ? totalDuration.toString().substring(0, 7)
                    : '0:00:00'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
