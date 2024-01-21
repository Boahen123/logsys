class SessionModel {
  final int? id;
  final int? userId;
  final String? authToken;
  final DateTime expiryTime;

  const SessionModel({
    this.id,
    this.userId,
    this.authToken,
    required this.expiryTime,
  });

  /// Converts a SessionModel object's properties into a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'auth_token': authToken,
      'expiry_time': expiryTime,
    };
  }

  /// Map `SessionModel` object fetched from Firebase to UserModel
  factory SessionModel.fromSnapshot(Map<dynamic, dynamic> document) {
    return SessionModel(
      id: document['id'],
      userId: document['user_id'],
      authToken: document['auth_token'],
      expiryTime: document['expiry_time'],
    );
  }
}
