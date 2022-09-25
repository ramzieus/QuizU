import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:random_avatar/random_avatar.dart';

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
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Text(
                        "Leaderboard",
                        style: TextStyle(fontSize: 28),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: leaders.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: randomAvatar(leaders[index]["name"],
                                    width: 50, height: 50),
                                title: Text(leaders[index]["name"]),
                                subtitle:
                                    Text(leaders[index]["score"].toString()),
                              ),
                            );
                          }),
                    )
                  ],
                ),
    );
  }
}
