import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

BoxDecoration decoration = const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(19),
    border: Border.all(color: Colors.black12),
  ),
);

pushReplacement(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => destination,
    ),
  );
}
