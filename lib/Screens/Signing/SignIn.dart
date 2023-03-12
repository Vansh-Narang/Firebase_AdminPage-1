import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/Authenticate/new.dart';
import 'package:flutter_application_20/Screens/Signing/Auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');
String email = '';
String position = '';
String name = '';
String imageUrl = '';

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController posController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text(
          "Sign In",
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 45, 22, 13),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height - MediaQuery.of(context).padding.top,
          width: deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter Member Email"),
                  controller: emailController,
                  validator: (value) =>
                      value!.isEmpty ? "Enter the email" : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Event Title",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  controller: posController,
                  validator: (value) =>
                      value!.isEmpty ? "Enter the Position" : null,
                  onChanged: (value) {
                    setState(() {
                      position = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter Member Name"),
                  controller: nameController,
                  validator: (value) =>
                      value!.isEmpty ? "Enter the name" : null,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please upload members image')));
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      _auth.signIn(email, position, name);
                      await addUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPage(),
                        ),
                      );
                    }
                  },
                  child: Text("Add the member"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: deviceSize.width * 0.1),
                    textStyle: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                IconButton(
                    onPressed: () async {
                      String uniquefilename =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      //PICK THE IMAGE
                      //instance created
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('${file?.path}');

                      //Step 2 upload the image
                      //create the reference
                      //and then uplaod
                      //get a reference of file
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      //reference for the root
                      Reference referenceDirImage =
                          referenceRoot.child('images');
                      //create child to store images

                      Reference referenceImagetoupload =
                          referenceDirImage.child(uniquefilename);

                      //store the file
                      //using put file
                      try {
                        await referenceImagetoupload.putFile(File(file!.path));
                        imageUrl =
                            await referenceImagetoupload.getDownloadURL();
                        //got download url
                        //step 3 done
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: Icon(Icons.camera_alt)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> addUser() {
  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'email': email,
        'position': position,
        'name': name,
        'imageUrl': imageUrl
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
