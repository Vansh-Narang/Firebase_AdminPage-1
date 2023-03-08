import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Login_Admin/Login_Page.dart';
import 'package:flutter_application_20/Screens/Authenticate/new.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Screens/Signing/Auth.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

String email = '';
String password = '';
final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Admin")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Enter the Email"),
              controller: emailController,
              validator: (value) => value!.isEmpty ? "Enter the Email" : null,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Enter the password"),
              validator: (value) =>
                  value!.isEmpty ? "Enter the password" : null,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //Login Page
                    User? user = await _auth.loginin(email, password);
                    print("no user found");
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                          ));
                    }
                  }
                },
                child: Text("Login Admin"))
          ],
        ),
      ),
    );
  }
}
