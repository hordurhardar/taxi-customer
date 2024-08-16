import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? elevation;
  final Color? shadowColor;
  final double? borderRadius;
  final double? fontSize;
  final String? fontFamily;
  final Color? textColor;
  final double offset;
  final bool showArrow;
  final Color? primary;
  final Color? forGroundColor;
  final Color borderColor;
  final double height;
  final double? width;
  final FontWeight fontWeight;
  final bool showBorder;
  final double? wordSpacing;

  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.elevation,
    this.shadowColor,
    this.borderRadius,
    this.fontSize = 16,
    this.fontFamily = AppFonts.inter,
    this.textColor = AppColors.blackColor,
    this.offset = 5.5,
    this.showArrow = false,
    this.height = 48,
    this.width,
    this.wordSpacing,
    this.fontWeight = FontWeight.w500,
    this.primary = AppColors.primary,
    this.showBorder = false,
    this.borderColor = AppColors.white,
    this.forGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          border: showBorder ? Border.all(width: 1, color: borderColor) : null,
        /*boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],*/
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: primary,
            shadowColor: shadowColor,
            foregroundColor: forGroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                
                borderRadius ?? 30),
            )),
        child: FittedBox(
          child: TextWidget(
            text: text ?? "",
            textAlign: TextAlign.center,
            color: textColor,
            fontFamily: fontFamily,
            wordSpacing: wordSpacing,
           // letterSpacing: 2.25,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
