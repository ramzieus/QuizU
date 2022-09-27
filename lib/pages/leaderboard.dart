import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:simple_animations/simple_animations.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Controller controller = Controller();
  bool loading = false;
  List leaders = [];
  bool networkError = false;

  _getLeaderList() async {
    setState(() {
      loading = true;
      networkError = false;
    });
    await controller.getLeaderboard().then((response) {
      if (response is Response) {
        leaders = response.data;
      } else {
        setState(() {
          networkError = true;
        });
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _getLeaderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: networkError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Network issue!"),
                  ElevatedButton(
                    onPressed: () {
                      _getLeaderList();
                    },
                    child: const Text("retry!"),
                  ),
                ],
              ),
            )
          : loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.lightBlue,
                      padding: const EdgeInsets.only(top: 140.0),
                      child: const Text(
                        "Leaderboard",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    PlasmaRenderer(
                      type: PlasmaType.bubbles,
                      particles: 100,
                      color: Theme.of(context).secondaryHeaderColor,
                      blur: 0.40,
                      size: 0.50,
                      speed: 2,
                      offset: 0,
                      blendMode: BlendMode.lighten,
                      particleType: ParticleType.circle,
                      variation1: 0,
                      variation2: 0,
                      variation3: 0,
                      rotation: 0,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: MediaQuery.of(context).size.height / 3,
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 4),
                        child: ListView.builder(
                            itemCount: leaders.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: -8,
                                      offset: const Offset(0, 8),
                                      color: Colors.black12.withOpacity(0.15),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: randomAvatar(
                                          leaders[index]["name"],
                                          width: 50,
                                          height: 50),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        leaders[index]["name"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        leaders[index]["score"].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(252, 171, 33, 0.6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
    );
  }
}
