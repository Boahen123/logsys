import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key, required this.fullname, required this.phone});

  final String fullname, phone;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Name: ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              widget.fullname,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Phone Number: ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              widget.phone,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
