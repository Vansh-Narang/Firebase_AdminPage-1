import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/Authentication/Auth.dart';
import 'package:flutter_application_20/Screens/EventPage/EventPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../MemberPage/MemberDetail.dart';

class TimestampExample extends StatefulWidget {
  @override
  _TimestampExampleState createState() => _TimestampExampleState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');
String email = '';
String position = '';
String name = '';
String imageUrl = '';
String title = '';
String completeTitle = '';
DateTime? date;
TimeOfDay? time;
TimeOfDay? startTime;
TimeOfDay? finishTime;
DateTime? pickDate;
Timestamp? timestamp;
// String venue = '';
String status = '';
String type = '';
String description = '';
String speakerName = '';
String speakerType = '';
String speakerImageurl = '';
String eventImage1 = '';
String eventImage2 = '';
String eventImage3 = '';
String eventImage4 = '';

class _TimestampExampleState extends State<TimestampExample> {
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
  // final TextEditingController venueController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController speakerController = TextEditingController();
  final TextEditingController speakerTypeController = TextEditingController();
  // final TextEditingController dateController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  DateTime? pickDate;
  Timestamp? timestamp;

  @override
  Widget build(BuildContext context) {
    var deviceSize;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timestamp Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                keyboardType: TextInputType.none,
                controller: dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "Select Date",
                ),
                onTap: () async {
                  pickDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd-MM-yyyy').format(pickDate!);
                    });
                  }
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: " Event Title"),
              controller: titleController,
              validator: (value) => value!.isEmpty ? " Event Title" : null,
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: " Event Complete title"),
              controller: completeTitleController,
              validator: (value) =>
                  value!.isEmpty ? " Event Complete title" : null,
              onChanged: (value) {
                setState(() {
                  completeTitle = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: " Date",
                // hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              controller: dateController,
              validator: (value) => value!.isEmpty ? " date" : null,
              onChanged: (value) {
                setState(() {
                  date = value as DateTime?;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: " Start Time",
                // hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              controller: startTimeController,
              validator: (value) => value!.isEmpty ? " Start Time" : null,
              onChanged: (value) {
                setState(() {
                  startTime = value as TimeOfDay?;
                });
              },
            ),
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

            // date and time picker

            // TextFormField(
            //   decoration: InputDecoration(
            //     hintText: "End Time",
            //   ),
            //   controller: finishTimeController,
            //   validator: (value) => value!.isEmpty ? "End Time" : null,
            //   onTap: () async {
            //     final TimeOfDay? newTime = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.now(),
            //     );
            //     if (newTime != null) {
            //       finishTimeController.text = newTime.format(context);
            //       setState(() {
            //         finishTime = newTime;
            //       });
            //     }
            //   },
            // ),

// date picker

            // TextFormField(
            //   decoration: InputDecoration(hintText: " Venue"),
            //   controller: venueController,
            //   validator: (value) => value!.isEmpty ? " Venue" : null,
            //   onChanged: (value) {
            //     setState(() {
            //       venue = value;
            //     });
            //   },
            // ),
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
                    vertical: 8.0, horizontal: deviceSize.width * 0.1),
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
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  //Step 2 upload the image
                  //create the reference
                  //and then uplaod
                  //get a reference of file
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  //reference for the root
                  Reference referenceDirImage = referenceRoot.child('images');
                  //create child to store images

                  Reference referenceImagetoupload =
                      referenceDirImage.child(uniquefilename);

                  //store the file
                  //using put file
                  try {
                    await referenceImagetoupload.putFile(File(file!.path));
                    imageUrl = await referenceImagetoupload.getDownloadURL();
                    //got download url
                    //step 3 done
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icon(Icons.camera_alt)),

            IconButton(
                onPressed: () async {
                  String uniquefilename =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  //PICK THE IMAGE
                  //instance created
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  //Step 2 upload the image
                  //create the reference
                  //and then uplaod
                  //get a reference of file
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  //reference for the root
                  Reference referenceDirImage =
                      referenceRoot.child('SpeakerImage');
                  //create child to store images

                  Reference referenceImagetoupload =
                      referenceDirImage.child(uniquefilename);

                  //store the file
                  //using put file
                  try {
                    await referenceImagetoupload.putFile(File(file!.path));
                    speakerImageurl =
                        await referenceImagetoupload.getDownloadURL();
                    //got download url
                    //step 3 done
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icon(Icons.camera_alt)),

            ElevatedButton(
              onPressed: () async {
                if (pickDate != null) {
                  // Convert the DateTime value to a Timestamp object
                  timestamp = Timestamp.fromDate(pickDate!);

                  // Save the Timestamp to Firebase
                  await firestoreInstance.collection('myCollection').add({
                    'timestampField': timestamp,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Timestamp saved to Firebase')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a date')));
                }
              },
              child: Text('Save Timestamp to Firebase'),
            ),
            SizedBox(height: 32.0),
            // StreamBuilder<QuerySnapshot>(
            //   stream: firestoreInstance.collection('myCollection').snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return CircularProgressIndicator();
            //     }

            //     // Retrieve the Timestamp data from Firebase
            //     Timestamp timestampData =
            //         snapshot.data!.docs.first['timestampField'];

            //     // Convert the Timestamp to a DateTime object
            //     DateTime dateTime = timestampData.toDate();

            //     return Text(
            //       'Timestamp from Firebase: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime)}',
            //       style: TextStyle(fontSize: 16.0),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
