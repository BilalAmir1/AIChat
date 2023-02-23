import 'package:chatgpt/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  final String url =
      "https://assets2.lottiefiles.com/packages/lf20_sqkyqhra.json";
  final String url1 = "https://assets10.lottiefiles.com/temp/lf20_CP7ooz.json";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(url, controller: _controller, onLoaded: (compos) {
            _controller
              ..duration = compos.duration
              ..forward().then(
                  (value) => Navigator.pushReplacementNamed(context, 'home'));
          }),
          Center(
              child: Text("Loading...",
                  style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
        ],
      ),
    );
  }
}
