import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/Authenticate/new.dart';
import 'package:flutter_application_20/Screens/Signing/Auth.dart';
import 'package:flutter_application_20/Screens/Signing/EventPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EventScheduler extends StatefulWidget {
  const EventScheduler({super.key});

  @override
  State<EventScheduler> createState() => _EventSchedulerState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');
String email = '';
String position = '';
String name = '';
String imageUrl = '';
String title = '';
String completeTitle = '';
// DateTime? date;
// TimeOfDay? time;
// TimeOfDay? startTime;
// TimeOfDay? finishTime;
String venue = '';
String status = '';
String type = '';
String description = '';
String speakerName = '';
String speakerType = '';
String speakerImage = '';
String eventImage1 = '';
String eventImage2 = '';
String eventImage3 = '';
String eventImage4 = '';

class _EventSchedulerState extends State<EventScheduler> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController posController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController completeTitleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController finishTimeController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController speakerController = TextEditingController();
  final TextEditingController speakerTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Schedule",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
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
                Text(
                  "Enter Detail Of Event",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  decoration: InputDecoration(hintText: " Event Title"),
                  controller: titleController,
                  validator: (value) => value!.isEmpty ? " Event Title" : null,
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: " Event Complete title"),
                  controller: completeTitleController,
                  validator: (value) =>
                      value!.isEmpty ? " Event Complete title" : null,
                  onChanged: (value) {
                    setState(() {
                      completeTitle = value;
                    });
                  },
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     hintText: " Date",
                //     // hintStyle: TextStyle(color: Colors.grey[500]),
                //   ),
                //   controller: dateController,
                //   validator: (value) => value!.isEmpty ? " date" : null,
                //   onChanged: (value) {
                //     setState(() {
                //       date = value as DateTime?;
                //     });
                //   },
                // ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     hintText: " Start Time",
                //     // hintStyle: TextStyle(color: Colors.grey[500]),
                //   ),
                //   controller: startTimeController,
                //   validator: (value) => value!.isEmpty ? " Start Time" : null,
                //   onChanged: (value) {
                //     setState(() {
                //       startTime = value as TimeOfDay?;
                //     });
                //   },
                // ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     hintText: " End Time",
                //     // hintStyle: TextStyle(color: Colors.grey[500]),
                //   ),
                //   controller: finishTimeController,
                //   validator: (value) => value!.isEmpty ? " End Time" : null,
                //   onChanged: (value) {
                //     setState(() {
                //       finishTime = value as TimeOfDay?;
                //     });
                //   },
                // ),
                TextFormField(
                  decoration: InputDecoration(hintText: " Venue"),
                  controller: venueController,
                  validator: (value) => value!.isEmpty ? " Venue" : null,
                  onChanged: (value) {
                    setState(() {
                      venue = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: " Status"),
                  controller: statusController,
                  validator: (value) => value!.isEmpty ? " Status" : null,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: " Event Type"),
                  controller: typeController,
                  validator: (value) => value!.isEmpty ? " Event Type" : null,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: " Event Description"),
                  controller: descriptionController,
                  validator: (value) =>
                      value!.isEmpty ? " Event Description" : null,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: " Speaker Name"),
                  controller: speakerController,
                  validator: (value) => value!.isEmpty ? " Speaker Name" : null,
                  onChanged: (value) {
                    setState(() {
                      speakerName = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: " Speaker Type"),
                  controller: speakerTypeController,
                  validator: (value) => value!.isEmpty ? " Event Type" : null,
                  onChanged: (value) {
                    setState(() {
                      speakerType = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please upload Event image')));
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      _auth.signIn(email, position, name);
                      await addUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedDataPage(),
                        ),
                      );
                    }
                  },
                  child: Text("Post Event"),
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
        'imageUrl': imageUrl,
        'title': title,
        'completeTitle': completeTitle,
        'venue': venue,
        'status': status,
        'type': type,
        'description': description,
        'speakerName': speakerName,
        'speakerType': speakerType
      })
      .then((value) => print("Event Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
