import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/Authentication/Auth.dart';
import 'package:flutter_application_20/Screens/MemberPage/MemberSaved.dart';
import 'package:image_picker/image_picker.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

CollectionReference gdscTeam =
    FirebaseFirestore.instance.collection('gdscTeam');
String email = '';
String position = '';
String name = '';
String imageUrl = '';
String session = '';

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController posController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController SessionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Member Detail",
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Member Email"),
                  controller: emailController,
                  validator: (value) => value!.isEmpty ? "the email" : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Member Position"),
                  controller: posController,
                  validator: (value) => value!.isEmpty ? "the Position" : null,
                  onChanged: (value) {
                    setState(() {
                      position = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Member Name"),
                  controller: nameController,
                  validator: (value) => value!.isEmpty ? "the name" : null,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Session"),
                  controller: SessionController,
                  validator: (value) => value!.isEmpty ? "the Session" : null,
                  onChanged: (value) {
                    setState(() {
                      session = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (imageUrl.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Upload members image')));
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        _auth.signIn(email, position, name);
                        await addUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewPage(),
                            ));
                      }
                    },
                    child: Text("Add the member")),
                SizedBox(
                  height: 10,
                ),
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
        ));
  }
}

Future<void> addUser() async {
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  gdscTeam
      .doc(id)
      .set({
        'id': id,
        'email': email,
        'position': position,
        'name': name,
        'imageUrl': imageUrl
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
