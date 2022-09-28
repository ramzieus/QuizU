import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/home_page.dart';
import 'package:quizu/pages/intro_screen.dart';
import 'package:quizu/pages/utils/constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Controller controller = Controller();

  _checkToken() async {
    bool check = await controller.checkToken();
    if (!check) {
      _completeLogin();
    } else {
      _toHome();
    }
  }

  _completeLogin() {
    pushReplacement(context, const IntroScreen());
  }

  _toHome() {
    pushReplacement(context, const MyHomePage());
  }

  @override
  void initState() {
    _checkToken();
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
          const Plasma(),
          Center(
            child: SpinPerfect(
              infinite: true,
              child: const Text(
                '⏳',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
