import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:shades_cast/domain_layer/episode.dart';

class EpisodeItem extends StatefulWidget {
  late String name;
  late Duration duration;
  int myIndex;
  bool isSelected;
  int episodeId;
  bool dispayDelete;

  EpisodeItem(Episode episode, this.isSelected, this.myIndex,
      {required this.episodeId, this.dispayDelete = false}) {
    this.name = episode.title;
    this.duration = (episode.durationInSeconds != null)
        ? Duration(seconds: episode.durationInSeconds)
        : Duration(seconds: 0);
  }

  @override
  State<EpisodeItem> createState() => _EpisodeItemState();
}

class _EpisodeItemState extends State<EpisodeItem> {
  @override
  Widget build(BuildContext context) {
    print('here in podcastitem');
    return BlocBuilder<PodcastDetailsAndPlayerBloc,
        PodcastDetailsAndPlayerState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          BlocProvider.of<PodcastDetailsAndPlayerBloc>(context)
              .add(EpisodeItemClicked(selectedIndex: widget.myIndex));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          color: Color.fromARGB(25, 255, 255, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  widget.isSelected ? Icons.bar_chart : Icons.play_arrow,
                  size: 35,
                  color: widget.isSelected
                      ? Color.fromARGB(255, 30, 255, 38)
                      : Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Expanded(
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Text(
                durationToString(widget.duration),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: 10),
              widget.dispayDelete
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteConfirmationDialog(
                              onConfirm: () {
                                BlocProvider.of<PodcastDetailsAndPlayerBloc>(
                                        context)
                                    .add(EpisodeDeleted(
                                        episodeId: widget.episodeId));
                              },
                            );
                          },
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  String durationToString(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    int hours = duration.inHours.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteConfirmationDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure you want to delete?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
