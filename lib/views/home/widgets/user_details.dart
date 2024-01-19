import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text('Name: '),
            Text("{User's Name}"),
          ],
        ),
        Row(
          children: [
            Text('Phone Number: '),
            Text("{User's Phone Number}"),
          ],
        ),
      ],
    );
  }
}
