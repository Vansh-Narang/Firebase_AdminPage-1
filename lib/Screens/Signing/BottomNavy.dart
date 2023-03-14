import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_application_20/Screens/Authenticate/new.dart';
import 'package:flutter_application_20/Screens/Signing/EventPage.dart';
import 'package:flutter_application_20/Screens/Signing/Logout.dart';
import 'package:flutter_application_20/Screens/Signing/SignIn.dart';
import 'package:flutter_application_20/Screens/Signing/EventScheduler.dart';
import 'EventPage.dart';

class BottomNavy extends StatefulWidget {
  const BottomNavy({Key? key}) : super(key: key);

  @override
  State<BottomNavy> createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      SavedDataPage(),
      EventScheduler(),
      SignIn(),
      LogoutPage(),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Bottom Navigation"),
      //   centerTitle: true,
      // ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: pages, // Use the pages list instead of containers
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Events'),
              icon: Icon(Icons.pages),
              activeColor: Colors.blueGrey),
          BottomNavyBarItem(
              title: Text('Events Add'),
              icon: Icon(Icons.post_add),
              activeColor: Colors.blueGrey),
          BottomNavyBarItem(
              title: Text('Members'),
              icon: Icon(Icons.people),
              activeColor: Colors.blueGrey),
          BottomNavyBarItem(
              title: Text('Log out'),
              icon: Icon(Icons.login),
              activeColor: Colors.blueGrey),
        ],
      ),
    );
  }
}
