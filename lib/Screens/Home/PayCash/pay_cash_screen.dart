import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/Home/PayCash/loyalty_points_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/choose_location_card_widget.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayCashScreen extends StatelessWidget {
  static const routeName = "/payCash_screen";

  const PayCashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.payCash,
            ),
          ),
          // heightGap(deviceHeight(context) * 0.50),
          Consumer3<DriverProvider, BookRideProvider, DestinationProvider>(
            builder: (context, value, bookRideValue, destinationValue, child) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 5,
                        child: CouponCard(
                          height: deviceHeight(context) * 0.65,
                          curvePosition: deviceHeight(context) * 0.40,
                          curveRadius: 30,
                          backgroundColor: Colors.white,
                          borderRadius: 10,
                          border: const BorderSide(
                            color: AppColors.greyBorder,
                          ),
                          firstChild: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              heightGap(20),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.greyBorder),
                                child: const SvgPic(
                                  image: AppImages.walletYellow,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextWidget(
                                text: AppLocalizations.of(context)!.payCash,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              ChooseLocationCardWidget(
                                elevation: 0,
                                showFlag: false,
                                yourLocationController: TextEditingController(
                                    text: bookRideValue.bookingList.isNotEmpty
                                        ? bookRideValue.bookingList.first
                                                .pickupAddress ??
                                            ""
                                        : ""),
                                dropLocationController: TextEditingController(
                                    text: bookRideValue.bookingList.isNotEmpty
                                        ? bookRideValue.bookingList.first
                                                .destinationAddress ??
                                            ""
                                        : ""),
                                onTapPickUpLocationField: () {},
                                dropEnabled: false,
                              ),
                            ],
                          ),
                          secondChild: SizedBox(
                            width: double.maxFinite,
                            // padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 42),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const DottedLine(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 6.0,
                                  dashColor: AppColors.greyBg,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color:
                                                        AppColors.greyBorder),
                                                child: value.driverData !=
                                                            null &&
                                                        value.driverData
                                                                ?.image !=
                                                            null
                                                    ? Image.network(
                                                        "$IMAGE_URL${value.driverData?.image!}")
                                                    : Image.asset(
                                                        AppImages.user,
                                                        //'https://b2btobacco.s3.amazonaws.com/taxi/profile/image_1712987083086.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            widthGap(10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text:
                                                        "${value.driverData?.name}",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "${bookRideValue.bookingList.isNotEmpty ? bookRideValue.bookingList.first.carType ?? "" : ""}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.greyHint,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 48,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: WidgetStateProperty.all<
                                                  EdgeInsetsGeometry?>(
                                              EdgeInsets.zero),
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2))),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  AppColors.primary)),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: TextWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .totalAmount,
                                            )),
                                            TextWidget(
                                                text:
                                                    'kr ${bookRideValue.bookingList.isNotEmpty ? bookRideValue.bookingList.first.totalAmount != null ? double.parse(bookRideValue.bookingList.first.totalAmount.toString()).toStringAsFixed(2) : "" : ""}'),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          CommonFooterWidget(
              cartItem: ElevatedButtonWidget(
            text: AppLocalizations.of(context)!.cashPaid,
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(LoyaltyPointsScreen.routeName);
            },
          )),
        ],
      ),
    );
  }
}
