import 'package:cloud_firestore/cloud_firestore.dart';

/// The `UserModel` class represents a user with properties such as id, fullname, email, hashed password, and
/// phone, and provides a method to convert the object to a JSON format and vice versa.
class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String? phone;
  final String? password;

  const UserModel({
    this.id,
    required this.fullname,
    required this.email,
    this.password,
    this.phone,
  });

  /// Converts a UserModel object's properties into a JSON format.
  ///
  /// Returns:
  ///   A Map object is being returned. The keys of the map are 'fullname', 'email', 'password', and
  /// 'phone', and the corresponding values are the values of the variables fullname, email, password, and
  /// phone.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  /// Map User object fetched from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final Map<String, dynamic>? data = document.data();

    return UserModel(
        id: data?['id'],
        fullname: data!['fullname'],
        email: data['email'],
        password: data['password'],
        phone: data['phone']);
  }
}
