import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/pages/home.dart';
import 'package:quizu/pages/leaderboard.dart';
import 'package:quizu/pages/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Controller controller = Controller();
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    LeaderBoard(),
    Profile()
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: DiamondBottomNavigation(
        itemIcons: const [
          Icons.home,
          Icons.person,
        ],
        centerIcon: Icons.leaderboard,
        selectedIndex: _selectedIndex,
        onItemPressed: _onItemTapped,
      ),
    );
  }
}
