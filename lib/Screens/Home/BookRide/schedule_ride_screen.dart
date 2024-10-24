import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Providers/DestinationProvider/destination_provider.dart';
import '../../../Providers/HomeProvider/home_provider.dart';

class ScheduleRideScreen extends StatelessWidget {
  static const routeName = "/scheduleRide_screen";

  const ScheduleRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      statusBarColor: Colors.transparent,
      body: Stack(
        children: [
          Consumer<BookRideProvider>(
            builder: (context, value, child) {
              return GoogleMapWidget(
                polylines: Set<Polyline>.of(value.polylines.values),
                markers: value.markers,
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                heightGap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Toolbar(
                    title: AppLocalizations.of(context)!.bookRide,
                  ),
                ),
                heightGap(deviceHeight(context) * 0.5),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightGap(2),
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.greyBorder,
                                    ),
                                  ),
                                ),
                                heightGap(20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, left: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextWidget(
                                          text: AppLocalizations.of(context)!
                                              .scheduleRide,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await context
                                              .read<BookRideProvider>()
                                              .selectScheduleTimeInUtc(
                                                  time: DateTime.now());
                                          await context
                                              .read<BookRideProvider>()
                                              .isRideNowUpdate(value: true);
                                          Navigator.of(context).pop();
                                        },
                                        child: TextWidget(
                                          text: AppLocalizations.of(context)!
                                              .rideNow,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                heightGap(5),
                                SizedBox(
                                  height: 165,
                                  width: double.infinity,
                                  child: CupertinoDatePicker(
                                    onDateTimeChanged: (value) async {
                                      await context
                                          .read<BookRideProvider>()
                                          .isRideNowUpdate(value: false);
                                      context
                                          .read<BookRideProvider>()
                                          .selectScheduleTimeInUtc(time: value);

                                      context
                                          .read<BookRideProvider>()
                                          .selectScheduleTimeInUtc(time: value);
                                    },
                                  ),
                                ),
                                heightGap(20),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: CommonFooterWidget(
                                cartItem: ElevatedButtonWidget(
                              onPressed: () {
                                log("ggjggjg");
                                if (context
                                        .read<BookRideProvider>()
                                        .selectedVehicleType ==
                                    null) {
                                  var msg = AppLocalizations.of(context)!
                                      .selectVehicle;
                                  if (context
                                      .read<BookRideProvider>()
                                      .vehicleList
                                      .isEmpty) {}
                                  showSnackBar(
                                      context: context,
                                      message: AppLocalizations.of(context)!
                                          .selectVehicle,
                                      isSuccess: false);
                                  return;
                                }
                                if (context
                                    .read<DestinationProvider>()
                                    .dropLocationController
                                    .text
                                    .trim()
                                    .isEmpty) {
                                  showSnackBar(
                                      context: context,
                                      message: AppLocalizations.of(context)!
                                          .selectDestination,
                                      isSuccess: false);
                                  return;
                                }


                                context.read<BookRideProvider>().bookRideApi(
                                      context: context,
                                      pickUpLat: context
                                              .read<HomeProvider>()
                                              .currentPosition
                                              ?.latitude ??
                                          0.0,
                                      pickUpLong: context
                                              .read<HomeProvider>()
                                              .currentPosition
                                              ?.longitude ??
                                          0.0,
                                      destinationLat: context
                                              .read<DestinationProvider>()
                                              .selectedPredictionLatLong
                                              ?.latitude ??
                                          0.0,
                                      destinationLong: context
                                              .read<DestinationProvider>()
                                              .selectedPredictionLatLong
                                              ?.longitude ??
                                          0.0,
                                      gender: context
                                          .read<BookRideProvider>()
                                          .gender,
                                      vehicleType: context
                                          .read<BookRideProvider>()
                                          .selectedVehicleType!
                                          .vehicleType
                                          .toString(),
                                      amount: '',
                                      pickUpAddress: context
                                          .read<DestinationProvider>()
                                          .yourLocationController
                                          .text,
                                      destinationAddress: context
                                          .read<DestinationProvider>()
                                          .dropLocationController
                                          .text,
                                      bookForSelf: true,
                                      rideType: context
                                              .read<BookRideProvider>()
                                              .isRideNow
                                          ? 'Now'
                                          : 'Scheduled',
                                      paymentType: context
                                          .read<BookRideProvider>()
                                          .paymentMethod,
                                      bookingDate: context
                                              .read<BookRideProvider>()
                                              .isRideNow
                                          ? DateTime.now().toUtc().toString()
                                          : context
                                              .read<BookRideProvider>()
                                              .scheduleTime
                                              .toString(),
                                    );
                                
                              },
                              text: AppLocalizations.of(context)!.confirm,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
