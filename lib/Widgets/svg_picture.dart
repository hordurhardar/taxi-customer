import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPic extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;

  const SvgPic(
      {super.key,
      required this.image,
      this.fit = BoxFit.none,
      this.width,
      this.height,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fit: fit,
      color: color,
      height: height,
      width: width,
      image,
    );
  }
}
