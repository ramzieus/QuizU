import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/db/database.dart';
import 'package:quizu/models/score.dart';
import 'package:quizu/pages/components/alert.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/components/score_item.dart';
import 'package:quizu/pages/login.dart';
import 'package:quizu/pages/utils/constants.dart';
import 'package:random_avatar/random_avatar.dart';

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
          : Stack(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                ),
                const Plasma(),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(80),
                              ),
                              color: Colors.blue.withOpacity(0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return QAlert(
                                        message: 'Do you want to logout?',
                                        onPressed: () {
                                          controller.logout().then((e) {
                                            pushReplacement(
                                                context, const Login());
                                          });
                                        });
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                              color: Colors.black12.withOpacity(0.15),
                            )
                          ],
                        ),
                        width: 100,
                        height: 100,
                        child: randomAvatar(info["name"] ?? 'AAA',
                            fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 12),
                      child: Text(
                        info["name"] ?? '',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(80),
                          ),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        padding: const EdgeInsets.only(
                            right: 28.0, left: 28.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          info["mobile"] ?? '',
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: scores.length,
                            itemBuilder: (context, index) {
                              return ScoreItem(
                                  index: index,
                                  date: scores[index].date.split('.')[0],
                                  score: scores[index].score);
                            }),
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
