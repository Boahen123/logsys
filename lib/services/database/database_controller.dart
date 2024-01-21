import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  static DatabaseController get instance => Get.find();

  // initialize database
  FirebaseFirestore db = FirebaseFirestore.instance;

  // create a new user in db
  Future<void> createUserInDb(Map<String, dynamic> user) async {
    try {
      var counterRef = db.collection('counter').doc('documentCounter');
      var counterDoc = await counterRef.get();

      if (counterDoc.exists) {
        var currentCount = counterDoc.data()!['count'];

        // Update the counter in the document
        await counterRef.update({count: currentCount + 1});

        // Use the updated counter as the document ID
        var documentId = currentCount + 1;
        // Add your document with the auto-incremented ID
        await db
            .collection('yourCollection')
            .doc(documentId.toString())
            .set(user);

        await db
            .collection('users')
            .add(user.update('id', (value) => documentId))
            .then((DocumentReference doc) =>
                log('DocumentSnapshot added with ID: ${doc.id}'));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
