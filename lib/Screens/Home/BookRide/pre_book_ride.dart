import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Screens/Booking/Widgets/card_widget.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/toolbar.dart';

class PreBookedRide extends StatefulWidget {
  static const routeName = "/preBookRide_screen";

  const PreBookedRide({super.key});

  @override
  State<PreBookedRide> createState() => _PreBookedRideState();
}

class _PreBookedRideState extends State<PreBookedRide> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<BookRideProvider>().getPreBookRideListApi(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: 'Pre-Booked Rides',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TableCalendar(
              firstDay: DateTime(2010, 10, 20),
              lastDay: DateTime(2040, 10, 20),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
                child: Consumer<BookRideProvider>(
                    builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.docs.length,
                    itemBuilder: (context, index) {
                      final ride = value.docs[index];
                      return Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CardWidget(
                              driverImage: "",
                              carType: ride.carType ?? "",
                              name: ride.otherPersonName ?? 'No Name',
                              rating: 'rating',
                              mile: ride.totalDistance ?? 'mile',
                              min: ride.time ?? 'min',
                              rate: ride.perMileAmount ?? 'rate',
                              date: formattedDateTime(ride.date ?? 'date'),
                              carNumber: ride.vehicleNumber ?? 'Not Available',
                              startLocation: ride.pickupAddress ?? "",
                              endLocation: ride.destinationAddress ?? "",
                            ),
                          ));
                    },
                  );
                })),
          ),
        ],
      ),
    );
  }
}
