import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizu/pages/home_page.dart';
import 'package:share_plus/share_plus.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.score});
  final int score;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final GlobalKey genKey = GlobalKey();

  takePicture() async {
    RenderRepaintBoundary boundary =
        genKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File('$directory/sharable.png');
    imgFile.writeAsBytes(pngBytes);
    Share.shareFiles([imgFile.path],
        text:
            'I have completed ${widget.score} correct answers at QuizU try the app now https://example.com');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
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
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: genKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                        child: Text(
                          "🏁",
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "You have completed",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.score.toString(),
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "correct answers!",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.only(top: 18),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                  takePicture();
                },
                child: const Text("Share 🔥"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
