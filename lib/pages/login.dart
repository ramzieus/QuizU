import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/pages/components/button.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  Controller controller = Controller();
  AnimationController? animationController;
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: Colors.black12),
    ),
  );

  PhoneNumber number = PhoneNumber(isoCode: 'SA');
  bool flip = true;
  bool validPhone = false;
  bool newUser = false;
  String title = 'QuizU ⏳';
  String name = "";
  bool animateButton = false;

  _toHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
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
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: newUser
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: -2,
                                offset: const Offset(0, 0),
                                color: Colors.black12.withOpacity(0.15),
                              )
                            ],
                          ),
                          child: TextField(
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Type your Name",
                              hintStyle: TextStyle(color: Colors.black12),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white),
                          child: QButton(
                            onPressed: name == ''
                                ? null
                                : () {
                                    controller.setName(name: name);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage(),
                                      ),
                                    );
                                  },
                            text: "Done",
                            enabled: name != '',
                          ),
                        )
                      ],
                    )
                  : flip
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(12.0),
                              padding: const EdgeInsets.all(18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: -2,
                                    offset: const Offset(0, 0),
                                    color: Colors.black12.withOpacity(0.15),
                                  )
                                ],
                              ),
                              child: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  this.number = number;
                                },
                                onInputValidated: (bool value) {
                                  validPhone = value;
                                },
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                initialValue: number,
                                textFieldController: phoneController,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                formatInput: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: false),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white),
                              child: Flash(
                                controller: (controller) =>
                                    animationController = controller,
                                manualTrigger: true,
                                animate: false,
                                child: QButton(
                                  onPressed: () {
                                    if (validPhone) {
                                      setState(() {
                                        flip = !flip;
                                      });
                                    } else {
                                      setState(() {
                                        animationController!.forward().then(
                                              (value) =>
                                                  animationController!.reset(),
                                            );
                                      });
                                    }
                                  },
                                  text: "Send confirmation",
                                  enabled: true,
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Pinput(
                                  controller: pinController,
                                  validator: (value) {
                                    return value == '0000'
                                        ? null
                                        : 'incorrect OTP';
                                  },
                                  onCompleted: (pin) async {
                                    Map response = await controller.login(
                                      otp: pin,
                                      mobile: number.phoneNumber.toString(),
                                    );
                                    if (response["success"]) {
                                      setState(() {
                                        newUser =
                                            response["user_status"] == "new";
                                      });
                                      if (!newUser) {
                                        _toHomePage();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white),
                              child: QButton(
                                onPressed: () {
                                  setState(() {
                                    flip = !flip;
                                  });
                                },
                                text: "<< Back",
                                enabled: true,
                              ),
                            ),
                          ],
                        ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
