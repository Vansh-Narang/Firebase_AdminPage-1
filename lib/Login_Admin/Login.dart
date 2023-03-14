import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Login_Admin/Login_Page.dart';
import 'package:flutter_application_20/Screens/Authenticate/new.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_20/Screens/Signing/BottomNavy.dart';
import 'package:flutter_application_20/Screens/Signing/SignIn.dart';
import 'package:flutter_application_20/Screens/Signing/EventScheduler.dart';

import '../Screens/Signing/Auth.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

String email = '';
String password = '';
bool _passwordVisible = false;

final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonHeight = size.height * 0.06;
    final buttonWidth = size.width * 0.9;
    final textFieldHeight = size.height * 0.08;
    final textFieldWidth = size.width * 0.9;
    final hintTextStyle = TextStyle(color: Colors.grey[500]);
    final labelStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final textStyle = TextStyle(fontSize: 16, color: Colors.black);
    final buttonStyle = ElevatedButton.styleFrom(
      primary: Colors.blue,
      onPrimary: Colors.white,
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      minimumSize: Size(buttonWidth, buttonHeight),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Login Admin"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Stack(children: [
                    Positioned(
                      top: 5,
                      left: 0,
                      right: 0,

                      child: Image.network(
                        "https://i.ibb.co/WVktdzW/Picsart-23-03-12-23-12-53-611.png", // Replace with your logo image URL
                        height: 200, // Adjust the height as needed
                      ),
                      // Replace with your logo image
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.05),
                        Text(
                          "Welcome Back!",
                          style: labelStyle,
                        ),
                        SizedBox(height: size.height * 0.08),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter the Email",
                            hintStyle: hintTextStyle,
                          ),
                          controller: emailController,
                          validator: (value) =>
                              value!.isEmpty ? "Enter the Email" : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          style: textStyle,
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Enter the password",
                            hintStyle: hintTextStyle,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Enter the password" : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          style: textStyle,
                          obscureText: !_passwordVisible,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                //Login Page
                                User? user =
                                    await _auth.loginin(email, password);
                                if (user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavy(),
                                    ),
                                  );
                                } else {
                                  print("no user found");
                                }
                              }
                            },
                            child: Text("Login Admin"))
                      ],
                    ),
                  ]),
                ))));
  }
}
