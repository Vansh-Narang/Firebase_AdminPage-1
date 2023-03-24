import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_application_20/Screens/Authentication/Logout.dart';
import 'package:flutter_application_20/Screens/EventPage/EventPage.dart';
import 'package:flutter_application_20/Screens/EventPage/EventScheduler.dart';
import 'package:flutter_application_20/Screens/MemberPage/MemberDetail.dart';
import 'package:flutter_application_20/Screens/MemberPage/MemberSaved.dart';

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
      NewPage(),
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
              icon: Icon(Icons.add),
              activeColor: Colors.blueGrey),
          BottomNavyBarItem(
              title: Text('Team'),
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
