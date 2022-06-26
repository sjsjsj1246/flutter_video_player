import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_Logo(), SizedBox(height: 30.0), _AppName()],
      ),
    ));
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      colors: [Color(0xFF2A3A77), Color(0xFF000118)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/image/logo.png');
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
