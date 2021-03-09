import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final String playUrl;

  Player({this.playUrl});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController videoPlayerController;
  ChewieController _chewieController;

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.playUrl);
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final playerWidget = Chewie(
      controller: _chewieController,
    );
    Widget loadingView = Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(72.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Loading",
                ),
              ),
              LinearProgressIndicator()
            ],
          ),
        ),
      ),
    );
    Widget playView =
        Container(padding: EdgeInsets.only(bottom: 32), child: playerWidget);
    return Scaffold(
        body: _chewieController != null &&
                _chewieController.videoPlayerController.value.isInitialized
            ? playView
            : loadingView);
  }
}
