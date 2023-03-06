import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/Authenticate/new.dart';
import 'package:flutter_application_20/Screens/Signing/Auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');
String email = '';
String password = '';
String name = '';

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text(
            "Sign In",
          ),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 45, 22, 13),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? "Eneter the email" : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passController,
                validator: (value) =>
                    value!.isEmpty ? "Eneter the password" : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              TextFormField(
                controller: nameController,
                validator: (value) => value!.isEmpty ? "Eneter the name" : null,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _auth.signIn(email, password, name);
                      await addUser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewPage(),
                          ));
                    }
                  },
                  child: Text("Sign In"))
            ],
          ),
        ));
  }
}

Future<void> addUser() {
  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'email': email, // John Doe
        'password': password, // Stokes and Sons
        'name': name // 42
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
