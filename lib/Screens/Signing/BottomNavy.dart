import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation"),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
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
              title: Text('Home Page'),
              icon: Icon(Icons.home),
              activeColor: Colors.blueGrey),
          BottomNavyBarItem(
              title: Text('Events'),
              icon: Icon(Icons.apps),
              activeColor: Colors.blueGrey),
          BottomNavyBarItem(
              title: Text('Members'),
              icon: Icon(Icons.chat_bubble),
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
