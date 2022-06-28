import 'package:flutter/material.dart';
import 'package:flutter_video_player/components/custon_video_player.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: video == null ? renderEmpty() : renderVideo());
  }

  Widget renderVideo() {
    return Center(
        child: CustomVideoPlayer(
            video: video!, onNewVideoPressed: onNewVideoPressed));
  }

  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onTap: onNewVideoPressed),
          SizedBox(height: 30.0),
          _AppName()
        ],
      ),
    );
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      colors: [Color(0xFF2A3A77), Color(0xFF000118)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ));
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, child: Image.asset('asset/image/logo.png'));
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w300);

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Video', style: textStyle),
      Text('Player', style: textStyle.copyWith(fontWeight: FontWeight.w700))
    ]);
  }
}
