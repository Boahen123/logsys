# _LogSys - Login System_

`LogSys` is a simple login system with session management.

## Application UI

## Firebase Integration (Firestore)

### Database schema

```
Collection: users
  Document: {user_id}
    - full_name: "John Doe"
    - phone_number: "+123456789"
    - email: "john.doe@example.com"
    - hashed_password: "hashed_password_string"

Collection: sessions
  Document: {session_id}
    - user_id: "user_id_of_associated_user"
    - auth_token: "auth_token_string"
    - expiry_time: Timestamp
```

## Folder/File Structure
