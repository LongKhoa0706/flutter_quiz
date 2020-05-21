import 'package:flutter/material.dart';
import 'package:flutterquiz/screen/homes_creen.dart';
import 'package:flutterquiz/screen/scorescreen.dart';
import 'package:flutterquiz/util/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0 ;
  
  List<Widget> listScreen = [
    HomeScreen(),
    ScoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: listScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kItemSelectBottomNav,

        unselectedItemColor: kItemUnSelectBottomNav,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          _buildItemBottomNav(FontAwesomeIcons.home, "Home"),
          _buildItemBottomNav(FontAwesomeIcons.history,"Score" )
        ],
        
      ),
    );
  }
  _buildItemBottomNav(IconData icon, String title){
      return BottomNavigationBarItem(
        icon: Icon(icon),
        title: Text(title),
      )    ;
  }
}

