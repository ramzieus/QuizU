import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/pages/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Controller controller = Controller();
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

  String initialCountry = 'SA';
  PhoneNumber number = PhoneNumber(isoCode: 'SA');
  bool flip = true;
  bool validPhone = false;
  bool newUser = false;
  String title = 'QuizU ⏳';
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 64),
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
                      child: TextField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                        onChanged: (val) {
                          name = val;
                          print(val);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.setName(name: name);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(),
                            ),
                          );
                        },
                        child: const Text("Done"))
                  ],
                )
              : flip
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                              this.number = number;
                            },
                            onInputValidated: (bool value) {
                              print(value);
                              validPhone = value;
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: phoneController,
                            formatInput: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: false),
                            inputBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                color: Colors.transparent,
                              ),
                            ),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (validPhone) {
                              setState(() {
                                flip = !flip;
                              });
                            }
                          },
                          child: const Text("Send OTP confirmation"),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Center(
                          child: Pinput(
                            controller: pinController,
                            validator: (value) {
                              return value == '0000' ? null : 'incorrect OTP';
                            },
                            onCompleted: (pin) async {
                              debugPrint('onCompleted: $pin');
                              Map response = await controller.login(
                                otp: pin,
                                mobile: number.phoneNumber.toString(),
                              );
                              setState(() {
                                newUser = response["user_status"] == "new";
                              });
                              if (!newUser) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              flip = !flip;
                            });
                          },
                          child: const Text("Edit Number"),
                        ),
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
