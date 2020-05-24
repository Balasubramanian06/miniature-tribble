import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  final String name;

  VideoScreen({this.id, this.name});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  // final String title =name;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          // onReady: () {
          //   print('Player is ready.');
          // },
        ),
      ),
    );
  }
}
