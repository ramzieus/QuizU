import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/login.dart';
import 'package:quizu/pages/utils/constants.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  late Function goToTab;

  Color white = Colors.white;

  void onDonePress() {
    pushReplacement(context, const Login());
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: white,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: white,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: white,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
      overlayColor: MaterialStateProperty.all<Color>(Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),
      renderNextBtn: renderNextBtn(),
      nextButtonStyle: myButtonStyle(),
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),
      indicatorConfig: const IndicatorConfig(
        colorIndicator: Colors.white,
        sizeIndicator: 13.0,
        typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,
      ),
      listCustomTabs: [
        Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
            ),
            const Plasma(),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Text(
                      "QuizU\n???",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Text(
                      "A Flutter mobile app where users answer the maximum number of questions within 2 minutes ????",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
            ),
            const Plasma(),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/images/OkoulLogo.svg",
                    width: 200,
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Text(
                      "Development and design challenges that get you hired ????",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      backgroundColorAllTabs: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },
      scrollPhysics: const BouncingScrollPhysics(),
      hideStatusBar: false,
    );
  }
}
