import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/video_background.dart';

class VideoHero extends StatelessWidget {
  const VideoHero({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context) {
    // print(config.get('hero-main-caption.title'));
    return  Center(
      child: Stack(
        children: [
          const VideoApp(),
          Positioned.fill( // cadre positionné occupant toute la place dispo
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text>[
                  Text(
                    config.get('hero-main-caption.title'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.5,
                    ),
                  ),
                  Text(
                    config.get('hero-main-caption.subtitle'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

