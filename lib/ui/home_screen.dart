import 'package:finall_resto_app/ui/fav_screen.dart';
import 'package:finall_resto_app/ui/list_resto_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> body = <Widget>[
    ListRestoScreen(),
    ResFavoritePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RestoApp"),
      ),
      body: body[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.green,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home_outlined,
                color: Colors.greenAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
              ),
              label: 'favorit',
              activeIcon: Icon(
                Icons.favorite_outlined,
                color: Colors.pink,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.white30,
              ),
              label: 'settings',
              activeIcon: Icon(
                Icons.settings_outlined,
                color: Colors.white38,
              )),

        ],
      ),
    );
  }
}
