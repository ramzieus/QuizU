import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quizu/pages/quiz.dart';
import 'package:simple_animations/simple_animations.dart';

import 'components/button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                """Ready to test your\nknoweldge and challenge\nothers?""",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
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
          bottom: 0,
          right: 0,
          top: MediaQuery.of(context).size.height / 3,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          "Ready?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(8.0),
                      child: Pulse(
                        infinite: true,
                        child: QButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Quiz(),
                              ),
                            );
                          },
                          text: "Quiz Me!",
                          enabled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        """Answer as much questions\ncorrectly within""",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Center(
                      child: Text(
                        "2 minutes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
