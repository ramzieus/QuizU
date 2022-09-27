import 'package:flutter/material.dart';
import 'package:quizu/pages/components/button.dart';
import 'package:quizu/pages/components/result.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_animations/simple_animations.dart';

import 'home_page.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.score});
  final int score;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final GlobalKey genKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
          ),
          PlasmaRenderer(
            type: PlasmaType.bubbles,
            particles: 100,
            color: Theme.of(context).secondaryHeaderColor,
            blur: 0.40,
            size: 0.50,
            speed: 2,
            offset: 0,
            blendMode: BlendMode.lighten,
            particleType: ParticleType.circle,
            variation1: 0,
            variation2: 0,
            variation3: 0,
            rotation: 0,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 40,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80),
                        ),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomPaint(
                  painter: ResultShape(),
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                        child: Text(
                      '🏁',
                      style: TextStyle(fontSize: 42),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 18.0, top: 4.0, bottom: 4.0),
                    child: Text(
                      "⭐ ${widget.score.toString()}",
                      style: TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 3,
            child: SizedBox(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 18, bottom: 8.0),
                      child: Text(
                        "Congratulations",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        """You have completed ${widget.score.toString()} correct\nanswers!""",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.only(top: 18),
                      child: QButton(
                        onPressed: () {
                          Share.share(
                              'I answered ${widget.score} correct answers in QuizU!');
                        },
                        text: "Share 🔥",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
