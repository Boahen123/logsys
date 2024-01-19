import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The `FormFooterWidget` class displays a form footer with options for
/// alternative authentication methods.
class FormFooterWidget extends StatelessWidget {
  const FormFooterWidget({
    required this.alt,
    required this.auth,
    required this.to,
    super.key,
  });

  final String alt, auth, to;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.001),
        TextButton(
          onPressed: () => Get.toNamed('/$to'),
          child: Text.rich(
            TextSpan(
              text: alt,
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: auth,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
