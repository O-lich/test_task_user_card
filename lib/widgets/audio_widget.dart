import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../const/app_images.dart';

class AudioWidget extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const AudioWidget({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final String audioPath =
      'https://cdn.pixabay.com/download/audio/2020/08/11/audio_89226f4f50.mp3?filename=car-drive-561.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  List<String> icons = [AppLogos.playerLogo, AppLogos.playerPauseLogo];

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.setSourceUrl(audioPath);
    widget.audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isPlaying == false) {
          widget.audioPlayer.play(UrlSource(audioPath));
          setState(() {
            isPlaying = !isPlaying;
          });
        } else if (isPlaying == true) {
          setState(() {
            widget.audioPlayer.pause();
            setState(() {
              isPlaying = !isPlaying;
            });
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            isPlaying == false ? icons[0] : icons[1],
            scale: 3,
          ),
        ),
      ),
    );
  }
}