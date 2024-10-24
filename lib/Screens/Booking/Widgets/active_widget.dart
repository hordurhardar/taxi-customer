import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/Providers/BookingProvider/booking_provider.dart';
import 'package:taxi/Screens/Booking/Widgets/card_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget_booking.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ActiveWidget extends StatefulWidget {
  const ActiveWidget({super.key});

  @override
  State<ActiveWidget> createState() => _ActiveWidgetState();
}

class _ActiveWidgetState extends State<ActiveWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<BookingProvider>(
        builder: (context, value, child) {
          print('Booking List Length: ${value.bookingList.length}');
          return
              // value.isLoading
              //     ? const Center(
              //         child: CupertinoActivityIndicator(),
              //       )
              //     :
              ListView.builder(
            itemCount: value.bookingList.length,
            itemBuilder: (context, index) {
              final booking = value.bookingList[index];
              log("bookinglist ======>${value.bookingList[index].toJson()}");
              var startRideTime = "";
              var diff = "0";
              if (booking.startRideTime != null &&
                  booking.endRideTime != null) {
                log('inside condition - dates were not null.');
                DateTime startDateTime = DateFormat("yyyy-MM-dd HH:mm")
                    .parse(booking.startRideTime ?? '');
                DateFormat targetFormat = DateFormat("MMM dd, yyyy. | hh:mm a");
                startRideTime = targetFormat.format(startDateTime);
                var endDateTime = DateTime.parse(booking.endRideTime ?? '');
                var dif = endDateTime.difference(startDateTime).inMinutes;
                diff = dif.toString();
              }

              print('Booking List Length: $index');
              log('customer id => ${booking.customer?.id}');
              return booking.status == "Pending"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CardWidget(
                            driverImage: booking.customer?.profileImage ?? '',
                            name: booking.customer?.name ?? 'No Name',
                            rating: booking.driverRating.toString(),
                            mile: booking.totalDistance ?? "",
                            min: diff,
                            rate: booking.perMileAmount.toString(),
                            date: startRideTime,
                            carNumber: booking.vehicleNumber ?? '',
                            carType: booking.carType ?? '',
                            startLocation: booking.pickupAddress ?? '',
                            endLocation: booking.destinationAddress ?? '',
                            driverId: booking.customer?.id,
                          ),
                          heightGap(20),
                          SizedBox(
                            height: 140,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: GoogleMapWidgetBooking(
                                  position: CameraPosition(
                                    target: LatLng(booking.destinationLatitude!,
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
                                      context,
                                      booking.id!,
                                    );
                                  },
                                  text: AppLocalizations.of(context)!.cancel,
                                ),
                              ),
                              // widthGap(10),
                              // Expanded(
                              //   child: ElevatedButtonWidget(
                              //     onPressed: () {},
                              //     text: AppLocalizations.of(context)!
                              //         .reschedule,
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    )
                  : SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
