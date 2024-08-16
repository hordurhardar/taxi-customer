import 'package:flutter/cupertino.dart';

import '../../../Utils/app_colors.dart';

class HalfCircleWidget extends StatelessWidget {
  const HalfCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: 20,
      height: 10,
      decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
    );
  }
}
