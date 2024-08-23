import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/choose_location_card_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';

import '../../Home/Driver/driver_details_screen.dart';

class CardWidget extends StatelessWidget {
  final String driverImage;
  final String name;
  final String rating;
  final dynamic mile;
  final String min;
  final dynamic rate;
  final String date;
  final String carNumber;
  final String carType;
  final String startLocation;
  final String endLocation;
  final String? driverId;

  const CardWidget({
    super.key,
    required this.driverImage,
    required this.carType,
    required this.name,
    required this.rating,
    required this.mile,
    required this.min,
    required this.rate,
    required this.date,
    required this.carNumber,
    required this.startLocation,
    required this.endLocation,
    this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  DriverDetailsScreen.routeName,
                  arguments: {'driver_id': driverId},
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.greyBorder),
                  child: driverImage != ''
                      ? Image.network(
                          "$IMAGE_URL$driverImage",
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppImages.user,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            widthGap(10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: name,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColors.logoblackthree,
                ),
                TextWidget(
                  text: carType,
                  fontSize: 15.56,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyText,
                ),
              ],
            )),
            Row(
              children: [
                SvgPicture.asset(AppImages.ratingStar),
                widthGap(5),
                TextWidget(
                  text: rating,
                  fontSize: 14.52,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ],
            ),
          ],
        ),
        const Divider(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            rowItem(
                value: '$mile ${AppLocalizations.of(context)!.mile}',
                image: AppImages.locationYellow),
            rowItem(
                value: '$min ${AppLocalizations.of(context)!.min}',
                image: AppImages.watchYellow),
            rowItem(
                value: '$rate /${AppLocalizations.of(context)!.mile}',
                image: AppImages.walletYellow),
          ],
        ),
        heightGap(10),
        Row(
          children: [
            Expanded(
              child: TextWidget(
                text: AppLocalizations.of(context)!.dateTime,
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: AppColors.greyHint,
              ),
            ),
            TextWidget(
              text: date,
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ],
        ),
        heightGap(20),
        const Divider(
          height: 0,
        ),
        ChooseLocationCardWidget(
          elevation: 0,
          yourLocationController: TextEditingController(
            text: startLocation,
          ),
          onTapPickUpLocationField: () {},
          dropLocationController: TextEditingController(text: endLocation),
          onChangedDropLocation: (p0) {},
          dropEnabled: false,
          showFlag: false,
        ),
        const Divider(
          height: 0,
        ),
        heightGap(20),
        Row(
          children: [
            Expanded(
              child: TextWidget(
                text: AppLocalizations.of(context)!.carNumber,
                fontSize: 12.45,
                fontWeight: FontWeight.w500,
                color: AppColors.greyText,
              ),
            ),
            TextWidget(
              text: carNumber,
              fontSize: 12.45,
              fontWeight: FontWeight.w500,
              color: AppColors.blackLightColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget rowItem({required String image, required String value}) {
    return Row(
      children: [
        SvgPic(image: image),
        const SizedBox(
          width: 5,
        ),
        TextWidget(
          text: value,
          color: AppColors.black,
        ),
      ],
    );
  }
}
