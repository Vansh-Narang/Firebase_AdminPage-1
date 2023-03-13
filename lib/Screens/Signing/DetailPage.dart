import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final String eventId;

  EventDetails({required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: FutureBuilder(
        future: Future.wait([getEventData(), getEventImage()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else {
            final eventData = snapshot.data![0] as Map<String, dynamic>;
            final imageUrl = snapshot.data![1] as String;

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      height: 300,
                    ),
                  SizedBox(height: 16),
                  Text(
                    eventData['title'] ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Date: ${eventData['date']?.toDate() ?? ''}'),
                  SizedBox(height: 8),
                  Text('Start Time: ${eventData['startTime'] ?? ''}'),
                  SizedBox(height: 8),
                  Text('End Time: ${eventData['finishTime'] ?? ''}'),
                  SizedBox(height: 8),
                  Text('Venue: ${eventData['venue'] ?? ''}'),
                  SizedBox(height: 8),
                  Text('Status: ${eventData['status'] ?? ''}'),
                  SizedBox(height: 8),
                  Text('Type: ${eventData['type'] ?? ''}'),
                  SizedBox(height: 8),
                  Text('Description: ${eventData['description'] ?? ''}'),
                  SizedBox(height: 16),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getEventData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('events')
            .doc(eventId)
            .get();
    return snapshot.data() ?? {};
  }

  Future<String> getEventImage() async {
    final snapshot = await FirebaseStorage.instance
        .ref('eventImages/$eventId.jpg')
        .getDownloadURL();
    return snapshot;
  }
}
