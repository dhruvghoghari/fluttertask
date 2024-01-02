import 'package:flutter/material.dart';
import 'package:fluttertask/screens/Home.dart';
import 'package:fluttertask/screens/Productcategory.dart';
import 'package:fluttertask/screens/Userprofile.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {

  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Home(),
    Productcategory(),
    Userprofile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('D Factory'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  child: Text("Hello"),
                  value: 'hello',
                ),
                PopupMenuItem(
                  child: Text("About"),
                  value: 'about',
                ),
                PopupMenuItem(
                  child: Text("Contact"),
                  value: 'contact',
                )
              ];
            },
          )
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
