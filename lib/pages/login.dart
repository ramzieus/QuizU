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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              newUser
                  ? Column(
                      children: [
                        const Text("What's your name?"),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Name",
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
                              name = val;
                            },
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
                                controller.setName(name: name);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(),
                                  ),
                                );
                              },
                              text: "Done"),
                        )
                      ],
                    )
                  : flip
                      ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(18.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white),
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
                            const SizedBox(
                              height: 60,
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
                                  text: "Send OTP confirmation",
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
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
                                    setState(() {
                                      newUser =
                                          response["user_status"] == "new";
                                    });
                                    if (!newUser) {
                                      _toHomePage();
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
                                text: "Edit Number",
                              ),
                            ),
                          ],
                        )
            ],
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
