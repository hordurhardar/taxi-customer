import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Utils/helper_methods.dart';

class DriverReviewWidget extends StatelessWidget {
  const DriverReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<DriverProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      text: AppLocalizations.of(context)!.reviews,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.addReview,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ],
              ),
              heightGap(8),
              TextFormFieldWidget(
                hintText: AppLocalizations.of(context)!.searchInReviews,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
              ),
              heightGap(18),
              // Row(
              //   children: [
              //     Container(
              //       margin: const EdgeInsets.only(right: 8),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(18),
              //           color: AppColors.greyBorder),
              //       child: const Padding(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
              //         child: TextWidget(text: 'Filter'),
              //       ),
              //     )
              //   ],
              // ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: value.driverData?.review?.length,
                itemBuilder: (context, index) {
                  final review = value.driverData?.review?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 67,
                            width: 60,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          widthGap(10),
                          TextWidget(
                            text: review?.userName ?? '',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                          const TextWidget(
                            text: '11 months ago',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyText,
                          ),
                        ],
                      ),
                      heightGap(8),
                      TextWidget(
                        text: review?.description ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyText,
                      ),
                      heightGap(8),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating:
                                double.parse(review?.rating ?? '0.0'),
                            itemSize: 30,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          TextWidget(
                            text: review?.rating ?? '0.0',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackColor,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 40,
                      ),
                    ],
                  );
                },
              ),
            ]),
          );
        },
      ),
    );
  }
}
