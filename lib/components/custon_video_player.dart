import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  CustomVideoPlayer(
      {required this.video, required this.onNewVideoPressed, Key? key})
      : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  Duration currentPosition = Duration();

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  initializeController() async {
    currentPosition = Duration();
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));
    await videoPlayerController!.initialize();

    videoPlayerController!.addListener(() {
      setState(() {
        currentPosition = videoPlayerController!.value.position;
      });
    });
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return CircularProgressIndicator();
    }

    return AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: GestureDetector(
          onTap: () {
            if (videoPlayerController!.value.isPlaying) {
              videoPlayerController!.pause();
            }
          },
          child: Stack(children: [
            VideoPlayer(videoPlayerController!),
            if (!videoPlayerController!.value.isPlaying)
              _Controlls(
                onReversePressed: onReversePressed,
                onForwardPressed: onForwardPressed,
                onPlayPressed: onPlayPressed,
                isPlaying: videoPlayerController!.value.isPlaying,
              ),
            if (!videoPlayerController!.value.isPlaying)
              _NewVideo(onPressed: widget.onNewVideoPressed),
            _Slider(
              currentPosition: videoPlayerController!.value.position,
              maxPosition: videoPlayerController!.value.duration,
              onSliderChanged: onSliderChanged,
            )
          ]),
        ));
  }

  void onReversePressed() {
    final currentPosition = videoPlayerController!.value.position;
    if (currentPosition > Duration(seconds: 3)) {
      videoPlayerController!.seekTo(currentPosition - Duration(seconds: 3));
    } else {
      videoPlayerController!.seekTo(Duration(seconds: 0));
    }
  }

  void onForwardPressed() {
    final maxPosition = videoPlayerController!.value.duration;
    final currentPosition = videoPlayerController!.value.position;
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      videoPlayerController!.seekTo(currentPosition + Duration(seconds: 3));
    } else {
      videoPlayerController!.seekTo(maxPosition);
    }
  }

  void onPlayPressed() {
    setState(() {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
      } else {
        videoPlayerController!.play();
      }
    });
  }

  void onSliderChanged(double val) {
    videoPlayerController!.seekTo(Duration(seconds: val.toInt()));
  }
}

class _Controlls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controlls(
      {required this.onPlayPressed,
      required this.onReversePressed,
      required this.onForwardPressed,
      required this.isPlaying,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        renderIconButton(
            onPressed: onReversePressed, iconData: Icons.rotate_left),
        renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow),
        renderIconButton(
            onPressed: onForwardPressed, iconData: Icons.rotate_right),
      ]),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(iconData, size: 30.0, color: Colors.white));
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;
  const _NewVideo({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.photo_camera_back, size: 30.0),
        color: Colors.white,
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _Slider(
      {required this.currentPosition,
      required this.maxPosition,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Slider(
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
              ),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
