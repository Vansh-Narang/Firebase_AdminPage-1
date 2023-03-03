import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    signIn(email, password);
                  },
                  child: Text("Sign In"))
            ],
          ),
        ));
  }
}

signIn(String emailAddress, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    print(emailAddress);
    print(password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
