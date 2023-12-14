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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Home"),
              ),
              Tab(
                child: Text("Category"),
              ),
              Tab(
                child: Text("User Profile"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Home(),
            Productcategory(),
            Userprofile()
          ],
        ),
      ),
    );
  }
}
