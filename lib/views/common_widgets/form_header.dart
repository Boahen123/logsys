import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The `FormHeaderWidget` class displays an image, and title in a
/// column layout representing a form header.
class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      this.imageColor,
      this.imageHeight = 2.0,
      required this.image,
      required this.title,
      this.heightBetween,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  final String image, title;
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          image,
          width: size.width * 0.4,
          height: size.height * 0.2,
        ),
        Text(title, style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
