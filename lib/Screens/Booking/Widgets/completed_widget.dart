import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxi/Screens/Booking/Widgets/card_widget.dart';
import 'package:taxi/Utils/no_data_widget.dart';

import '../../../Providers/BookingProvider/booking_provider.dart';

class CompletedWidget extends StatelessWidget {
  const CompletedWidget({super.key});

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
                    return value.bookingList.isEmpty
                        ? const NoDataWidget()
                        : Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  CardWidget(
                                    driverImage:
                                        booking.customer?.profileImage ?? '',
                                    name: booking.customer?.name ?? 'No Name',
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
                                ],
                              ),
                            ),
                          );
                  },
                );
        },
      ),
    );
  }
}
