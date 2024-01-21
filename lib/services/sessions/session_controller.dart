import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logsys/models/session_model.dart';
import 'package:logsys/models/signup_controller.dart';
import 'package:logsys/services/login/session_repo.dart';

class SessionController extends GetxController {
  static SessionController get instance => Get.find();

  // initialize database
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Example code to create a new session document in Firestore
  Future<void> createSessioninDb(Map<String, dynamic> session) async {
    try {
      var counterRef = db.collection('session_counter').doc('sessionCounter');
      var counterDoc = await counterRef.get();

      if (counterDoc.exists) {
        var currentCount = counterDoc.data()!['count'];

        // log(currentCount.toString());
        // Update the counter in the document
        await counterRef.update({'count': currentCount + 1});

        // Use the updated counter as the document ID
        var documentId = currentCount + 1;

        session.update('id', (value) => documentId);
        await db.collection('sessions').doc(documentId.toString()).set(session);
      }
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  ///  `createSession` creates a session.
  void createSession(
      int? userId, String authToken, DateTime expiration, int? id) async {
    SessionModel sessionModel =
        SessionRepo.createNewSessionModel(userId, authToken, expiration, id);
    Map<String, dynamic> session = sessionModel.toJson();

    await SessionController.instance.createSessioninDb(session);
  }
}
