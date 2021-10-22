import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final String playUrl;
  final String? subtitlesUrl;
  Player({required this.playUrl,this.subtitlesUrl});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController? videoPlayerController;
  ChewieController? _chewieController;

  SubtitleController? subtitleController;

  @override
  void dispose() {
    videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subtitleController = SubtitleController(
      subtitleUrl: widget.subtitlesUrl,
      subtitleType: SubtitleType.srt,
    );
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.playUrl);
    await videoPlayerController?.initialize();

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.landscapeRight,
      //   DeviceOrientation.landscapeLeft,
      // ],
      // deviceOrientationsOnEnterFullScreen: [
      //   DeviceOrientation.landscapeRight,
      //   DeviceOrientation.landscapeLeft,
      // ],
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
      overlay: SubTitleWrapper(
        videoPlayerController: videoPlayerController!,
        subtitleController: subtitleController!,
        subtitleStyle: SubtitleStyle(
          textColor: Colors.white,
          hasBorder: true,
        ),
        videoChild: Container(),
      )
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final playerWidget = GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
        }
      },
      child: Chewie(
        controller: _chewieController!,
      ),
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
        body: ((_chewieController?.videoPlayerController.value.isInitialized) ?? false)
            ? playView
            : loadingView);
  }
}
