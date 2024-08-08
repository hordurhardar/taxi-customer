import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';

class HeadingValueWidget extends StatelessWidget {
  final String heading;
  final String value;
  const HeadingValueWidget({super.key, required this.heading, required this.value});

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: heading,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.greyHint,
        ),
        TextWidget(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ],
    );
  }
}
