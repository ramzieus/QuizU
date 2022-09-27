import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizu/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff46BDFA),
        secondaryHeaderColor: const Color(0xff77E2FE),
        fontFamily:
            GoogleFonts.quicksand(fontWeight: FontWeight.w800).fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
