import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get/get.dart';
import 'package:logsys/models/session_model.dart';
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
    int? id,
    int? userId,
    String authToken,
    DateTime expiration,
  ) async {
    SessionModel sessionModel = SessionRepo.createNewSessionModel(
      id,
      userId,
      authToken,
      expiration,
    );
    Map<String, dynamic> session = sessionModel.toJson();

    await SessionController.instance.createSessioninDb(session);
  }

  String generateAuthToken(int? userId) {
    // / Generate a JSON Web Token
// You can provide the payload as a key-value map or a string
    final jwt = JWT(
      // Payload
      {
        'id': userId,
        'exp': DateTime.now()
                .add(const Duration(minutes: 5))
                .millisecondsSinceEpoch ~/
            1000,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
        }
      },
      issuer: '', // project github link
    );

// Sign it (default with HS256 algorithm)
    final token = jwt.sign(SecretKey('secret'));

    log('Signed token: $token\n');
    return token;
  }

  /// remove session document from firestore
  Future<void> removeSessionFromDb(int? userId) async {
    try {
      // Specify the collection
      CollectionReference sessions = db.collection('sessions');
      // Query Firestore for documents with 'phone' field equal to the given value
      QuerySnapshot querySnapshot =
          await sessions.where('user_id', isEqualTo: userId).get();
      log('Found a match: ${querySnapshot.docs.first.toString()}');
      for (var docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }

      log('sucessfully all deleted sessions');
    } catch (e) {
      log('Error(removeSessionFromDb): ${e.toString()}');
    }
  }
}
