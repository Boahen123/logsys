// APIs for registering a user account

import '../../models/session_model.dart';

class SessionRepo {
  /// Instantiate a new session model
  static SessionModel createNewSessionModel(
      int? userId, String authToken, DateTime expiration, int? id) {
    return SessionModel(
        id: id, userId: userId, authToken: authToken, expiryTime: expiration);
  }
}
