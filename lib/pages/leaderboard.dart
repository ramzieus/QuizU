import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/pages/components/board_item.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/utils/constants.dart';

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
                    const Plasma(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: MediaQuery.of(context).size.height / 3,
                      child: Container(
                        width: double.maxFinite,
                        decoration: decoration,
                        padding: const EdgeInsets.only(top: 4),
                        child: ListView.builder(
                            itemCount: leaders.length,
                            itemBuilder: (context, index) {
                              return BoardItem(
                                index: index,
                                score: leaders[index]["score"].toString(),
                                name: leaders[index]["name"],
                              );
                            }),
                      ),
                    )
                  ],
                ),
    );
  }
}
