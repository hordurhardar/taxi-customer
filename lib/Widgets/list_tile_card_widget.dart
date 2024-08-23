import 'package:flutter/material.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';

import 'svg_picture.dart';

class ListTileCardWidget extends StatelessWidget {
  final String titleText;
  final String leadingIconPath;
  final Color arrowColor;
  final double elevation;
  final double height;
  final VoidCallback? onTap;
  final ShapeBorder? shape;
  final bool isTrailingVisible;
  final String? subtitleText;
  final Widget? tittleWidget;
  final Widget? leadingWidget;
  final Widget? trailinhWidget;
  final Widget? subtitleWidget;

  const ListTileCardWidget({
    super.key,
    required this.titleText,
    this.height = 58,
    this.leadingIconPath = AppImages.bookmark,
    this.arrowColor = AppColors.black,
    this.elevation = 2,
    this.onTap,
    this.shape,
    this.isTrailingVisible = true,
    this.subtitleText,
    this.tittleWidget,
    this.leadingWidget,
    this.trailinhWidget,
    this.subtitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: height,
      onTap: onTap,
      shape: shape,
      leading: leadingWidget ?? SvgPic(image: leadingIconPath),
      title: Text(
        titleText,
      ),
      subtitle: subtitleText != null ? Text(subtitleText!) : null,
      trailing: isTrailingVisible
          ? trailinhWidget ??
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: arrowColor,
              )
          : null,
    );
  }
}
