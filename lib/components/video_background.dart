import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("web/assets/video/v1.mp4")
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // exécute ceci seulement une fois le player chargé et prêt:
          _controller.play();
          // print(_controller.value);
        });
      
      });
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/9,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}