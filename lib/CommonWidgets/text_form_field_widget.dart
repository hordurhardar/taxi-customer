import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final Color? cursorColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? hintColor;
  final bool showBorder;
  final bool? filled;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputBorder? border;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? prefixText;
  final String? hintText;
  final AutovalidateMode? autoValidateMode;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final bool? enabled;
  final int? maxLines;
  final Key? textFieldKey;
  final Function()? onVisibilityIconTap;
  final TextAlign textAlign;
  final double? borderRadius;
  final Widget? label;
  final VoidCallback? onTap;
  final FocusNode? focusNode; // Add focusNode parameter
  const TextFormFieldWidget({
    super.key,
    this.cursorColor = AppColors.primary,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.keyboardType,
    this.obscureText = false,
    this.showBorder = true,
    this.border,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.label,
    this.maxLength,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.prefixText,
    this.isPassword = false,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
    this.enabled,
    this.maxLines = 1,
    this.hintText,
    this.textFieldKey,
    this.onVisibilityIconTap,
    this.fillColor = Colors.transparent,
    this.filled = true,
    this.hintColor = AppColors.greyHint,
    this.textAlign = TextAlign.start,
    this.borderRadius,
    this.onTap,
    this.focusNode, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null) label!,
        TextFormField(
          key: textFieldKey,
          onTap: onTap,
          textAlign: textAlign,
          controller: controller,
          cursorColor: cursorColor,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          enabled: enabled,
          maxLines: maxLines,
          onChanged: onChanged,
          autovalidateMode: autoValidateMode,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          textAlignVertical: TextAlignVertical.center,
          maxLength: maxLength,
          expands: false, focusNode: focusNode, // Use focusNode here
          decoration: InputDecoration(
            border: border,
            filled: filled,
            fillColor: fillColor,
            errorMaxLines: 2,
            hintText: hintText,
            counterText: "",
            hintStyle: TextStyle(
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w400,
              color: hintColor,
              fontSize: 14,
            ),
            suffixIcon: isPassword
                ? InkWell(
                    onTap: onVisibilityIconTap,
                    child: obscureText
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined))
                : suffixIcon,
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            prefixStyle: const TextStyle(fontSize: 18),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            isCollapsed: false,
            errorStyle: const TextStyle(
              fontFamily: AppFonts.inter,
              letterSpacing: 0.6,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: showBorder ? AppColors.greyBorder : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: showBorder ? AppColors.greyBorder : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: showBorder ? AppColors.greyBorder : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: showBorder ? AppColors.greyBorder : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: showBorder ? AppColors.greyBorder : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        ),
      ],
    );
  }
}
