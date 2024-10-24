import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';

class RawItemWidget extends StatelessWidget {
  final String title;
  final String value;
  const RawItemWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextWidget(
          text: title,
          fontWeight: FontWeight.w500,
          color: AppColors.greyHint,
        )),
        TextWidget(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
      ],
    );
  }
}
