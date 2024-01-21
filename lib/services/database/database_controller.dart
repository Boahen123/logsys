import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logsys/models/user_model.dart';

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

        // log(currentCount.toString());
        // Update the counter in the document
        await counterRef.update({'count': currentCount + 1});

        // Use the updated counter as the document ID
        var documentId = currentCount + 1;
        // log(documentId.runtimeType.toString());
        user.update('id', (value) => documentId);
        // Add your document with the auto-incremented ID
        await db.collection('users').doc(documentId.toString()).set(user);
      }
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  /// check whether user exists in the database based on phone number
  Future<bool> checkIfPhoneExists(String phoneNumber) async {
    // Specify the collection
    CollectionReference users = db.collection('users');

    // Query Firestore for documents with 'phone' field equal to the given value
    QuerySnapshot querySnapshot =
        await users.where('phone', isEqualTo: phoneNumber).get();

    log('matching phone numbers: ${querySnapshot.toString()}');
    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      return true; // Phone number exists in at least one document
    } else {
      return false; // Phone number does not exist in any document
    }
  }

  /// retrieve user from firestore
  Future<UserModel?> retrieveUserData(String phoneNumber) async {
    // Specify the collection
    CollectionReference users = db.collection('users');

    UserModel? userModel =
        await users.where('phone', isEqualTo: phoneNumber).get().then(
      (querySnapshot) {
        log("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          var user = docSnapshot.data() as Map;

          log(user.toString());
          return UserModel.fromSnapshot(user);
        }
        return null;
      },
      onError: (e) {
        log("Error completing: $e");
        return null;
      },
    );

    return userModel;
  }

  /// check whether user exists in the database based on phone number and password
  Future<bool> validLoginCredentials(
      String password, String phoneNumber) async {
    // Specify the collection
    CollectionReference users = db.collection('users');

    // Query Firestore for documents with 'phone' field equal to the given value
    QuerySnapshot querySnapshot = await users
        .where('password', isEqualTo: password)
        .where("phone", isEqualTo: phoneNumber)
        .get();

    log('match found: ${querySnapshot.toString()}');
    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      return true; // Password is valid
    } else {
      return false; // phone and password do not match
    }
  }
}
