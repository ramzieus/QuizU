import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/db/database.dart';
import 'package:quizu/models/score.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Controller controller = Controller();
  bool loading = false;
  bool networkError = false;
  Map info = {};
  List<Score> scores = [];

  _getProfile() async {
    setState(() {
      loading = true;
    });
    await controller.getProfile().then((response) {
      if (response is Response) {
        info = response.data;
      } else {
        setState(() {
          networkError = true;
        });
      }
    });
    scores = await getAllScores();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Name: ${info["name"]}",
                              style: const TextStyle(fontSize: 22),
                            ),
                            Text(
                              "Mobile: ${info["mobile"]}",
                              style: const TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  color: Colors.blueGrey,
                                ),
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    scores[index].score,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              title: Text(scores[index].date.split('.')[0]),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
