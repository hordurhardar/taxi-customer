import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookingProvider/booking_provider.dart';
import 'package:taxi/Screens/Booking/CancelTaxiBooking/cancel_taxi_booking.dart';
import 'package:taxi/Screens/Booking/Widgets/card_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget_booking.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveWidget extends StatelessWidget {
  const ActiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<BookingProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : ListView.builder(
                  itemCount: value.bookingList.length,
                  itemBuilder: (context, index) {
                    final booking = value.bookingList[index];
                    var startRideTime = "";
                    var diff = "0";
                    if (booking.startRideTime != null &&
                        booking.endRideTime != null) {
                      DateTime startDateTime = DateFormat("yyyy-MM-dd HH:mm")
                          .parse(booking.startRideTime!);
                      DateFormat targetFormat =
                          DateFormat("MMM dd, yyyy. | hh:mm a");
                      startRideTime = targetFormat.format(startDateTime);
                      var endDateTime = DateTime.parse(booking.endRideTime!);
                      var dif = endDateTime.difference(startDateTime).inMinutes;
                      diff = dif.toString();
                    }
                    return booking.status == "Active"
                        ? Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CardWidget(
                                    driverImage:
                                        booking.driver?.profileImage ?? '',
                                    name: booking.driver?.name ?? 'No Name',
                                    rating: booking.driverRating.toString(),
                                    mile: booking.totalDistance ?? "",
                                    min: diff,
                                    rate: booking.perMileAmount.toString(),
                                    date: startRideTime,
                                    carNumber: booking.vehicleNumber ?? '',
                                    carType: booking.carType ?? '',
                                    startLocation: booking.pickupAddress ?? '',
                                    endLocation:
                                        booking.destinationAddress ?? '',
                                  ),
                                  heightGap(20),
                                  SizedBox(
                                    height: 140,
                                    width: double.infinity,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: GoogleMapWidgetBooking(
                                          position: CameraPosition(
                                            target: LatLng(
                                                booking.destinationLatitude!,
                                                booking.destinationLongitude!),
                                          ),
                                          markers: booking.markers,
                                          polylines: booking.polylines,
                                        )),
                                  ),
                                  heightGap(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButtonWidget(
                                          elevation: 0,
                                          primary: AppColors.greyStatusBar,
                                          textColor: AppColors.primary,
                                          onPressed: () {
                                            showCancelDialog(
                                                context, booking.id!);
                                          },
                                          text: AppLocalizations.of(context)!
                                              .cancel,
                                        ),
                                      ),
                                      // widthGap(10),
                                      // Expanded(
                                      //   child: ElevatedButtonWidget(
                                      //     onPressed: () {
                                      //
                                      //     },
                                      //     text: AppLocalizations.of(context)!.reschedule,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                );
        },
      ),
    );
  }

  Future<void> showCancelDialog(BuildContext context, String bookingId) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      TextWidget(
                        text:
                            '${AppLocalizations.of(context)!.cancelWithIn} 3 mins ${AppLocalizations.of(context)!.otherwisePayCancellationFee}',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      heightGap(20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButtonWidget(
                              elevation: 0,
                              primary: AppColors.greyStatusBar,
                              textColor: AppColors.primary,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: AppLocalizations.of(context)!.skip,
                            ),
                          ),
                          widthGap(10),
                          Expanded(
                            child: ElevatedButtonWidget(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CancelTaxiBooking(
                                            bookingId: bookingId)));
                              },
                              text: AppLocalizations.of(context)!.cancelRide,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]));
      },
    );
  }
}
