import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';

class Toolbar extends StatelessWidget {
  final String? title;
  final bool showCount;
  final bool showBack;
   final dynamic notificationcount;
  final Function()? onTap;

  const Toolbar({super.key, this.title, this.showBack = true, this.showCount = false, this.onTap,this.notificationcount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showBack
            ? GestureDetector(
                onTap: onTap ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: AppColors.greyHint)),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.greyHint,
                    size: 24,
                  ),
                ),
              )
            : const SizedBox(),
        //widthGap(deviceWidth(context) * 0.20),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showCount) widthGap(36),
              TextWidget(
                text: title ?? '',
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
              if (!showCount) widthGap(36),
            ],
          ),
        ),
        if (showCount)
          Container(
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextWidget(
                text: notificationcount ?? 'New',
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
