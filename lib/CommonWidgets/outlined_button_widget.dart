import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';

class OutLinedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? borderRadius;
  final double? fontSize;
  final String? fontFamily;
  final Color? textColor;
  final Color? primary;
  final Color borderColor;
  final double height;
  final FontWeight fontWeight;

  const OutLinedButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.fontSize = 15,
    this.fontFamily = AppFonts.inter,
    this.textColor = AppColors.white,
    this.height = 41,
    this.fontWeight = FontWeight.w500,
    this.primary = AppColors.primary,
    this.borderColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        side: const BorderSide(width: 1.0, color: AppColors.primary),
      ),
      child: TextWidget(
        text: text?.toUpperCase() ?? '',
        textAlign: TextAlign.center,
        color: textColor,
        fontFamily: fontFamily,
        letterSpacing: 2.25,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
