import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Utils/app_images.dart';

class VehicleDetailCardWidget extends StatelessWidget {
  final String seatCapacity;
  final String min;
  final String miles;
  final String image;
  final String carType;
  final bool isSelect;
  final Function() onTap;

  const VehicleDetailCardWidget(
      {super.key,
      required this.seatCapacity,
      required this.min,
      required this.isSelect,
      required this.miles,
      required this.carType,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    print(isSelect);
    return InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            SizedBox(
              width: 190,
              child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelect ? AppColors.primary : AppColors.white,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPic(image: image),
                      ),
                      // child: Image(
                      //     width: 130,
                      //     height: 60,
                      //     fit: BoxFit.cover,
                      //     image: NetworkImage(
                      //       image,
                      //     ))),
                      // Center(
                      //     child: TextWidget(
                      //       text: '$min ${AppLocalizations.of(context)!.min}',
                      //       color: AppColors.greyHint,
                      //     )),
                      const Divider(),
                      Row(
                        children: [
                          TextWidget(
                            text: carType,
                            fontSize: 16,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'kr$miles',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              TextWidget(
                                text: '/${AppLocalizations.of(context)!.mile}',
                                color: AppColors.greyHint,
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextWidget(
                        text:
                            '$seatCapacity ${AppLocalizations.of(context)!.seatsCapacity}',
                        color: AppColors.greyHint,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: isSelect
                    ? const SvgPic(image: AppImages.checkYellow)
                    : const SizedBox()),
          ],
        ));
  }
}
