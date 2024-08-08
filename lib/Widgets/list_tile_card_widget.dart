import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';

import 'svg_picture.dart';

class ListTileCardWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color arrowColor;
  final double elevation;
  final double height;
  const ListTileCardWidget({super.key, required this.title,this.height = 58,this.icon = AppImages.bookmark,this.arrowColor = AppColors.black,  this.elevation = 2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        elevation: elevation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
               SvgPic(image:icon),
              widthGap(10),
              Expanded(child: TextWidget(text: title,)),
               Icon(Icons.arrow_forward_ios_rounded,color: arrowColor,),
            ],
          ),
        ),
      ),
    );
  }
}
