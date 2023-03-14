import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
            SizedBox(height: 30.0),
            Text(
              'User',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
