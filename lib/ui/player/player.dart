import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../api/cc.dart';
import '../../api/client.dart';
import '../../api/file.dart';
class PlayerView extends StatefulWidget {
  final File file;
  const PlayerView({Key? key,required this.file}) : super(key: key);

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
  Future<void> initializePlayer() async {
    print(widget.file.videoPlayLink);
    _videoPlayerController1 =
        VideoPlayerController.network(widget.file.videoPlayLink);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    var cc = await ApiClient().fetchCC(widget.file.id!);
    _createChewieController(subs: cc);
    setState(() {});
  }

  void _createChewieController({List<CC> subs = const []}) {
    final subtitles = [
      ...subs.map((sub) => Subtitle(
            index: sub.index!,
            start: Duration(milliseconds: sub.start!),
            end: Duration(milliseconds: sub.end!),
            text: sub.text!,
          )),
    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      fullScreenByDefault: false,
      looping: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],


      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      hideControlsTimer: const Duration(seconds: 1),

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
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false
      ),
      child: Scaffold(
        body: Container(

          color: Colors.black,
          child: Center(
            child: _chewieController != null &&
                _chewieController!
                    .videoPlayerController.value.isInitialized
                ? Chewie(
              controller: _chewieController!,

            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
