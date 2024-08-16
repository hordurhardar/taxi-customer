import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi/Utils/app_images.dart';


class NoDataWidget extends StatelessWidget {
  final title;
  const NoDataWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.noDataJson),
            Text(title,
                style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
      ),
    );
  }
}