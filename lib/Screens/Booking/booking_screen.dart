import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookingProvider/booking_provider.dart';
import 'package:taxi/Screens/Booking/Widgets/active_widget.dart';
import 'package:taxi/Screens/Booking/Widgets/cancelled_widget.dart';
import 'package:taxi/Screens/Booking/Widgets/completed_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    context
        .read<BookingProvider>()
        .getBookingList(context: context, status: 'Active');
    // _getLocationAndCheckCountry();
    super.initState();
  }

  String userCountry = '';
  bool isIceland = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _getLocationAndCheckCountry();
  // }

  Widget _showResults() {
    // Replace this with your actual API result display logic
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to Iceland!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Display API results here
        Text(
          'Here are your results...',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

// Function to check the location and country
  Future<void> _getLocationAndCheckCountry() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get the place marks for the current position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Check the country from the placemarks
    if (placemarks.isNotEmpty) {
      String country = placemarks[0].country ?? '';

      setState(() {
        userCountry = country;
        isIceland = (country == 'Iceland');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.white,
          // title: TextWidget(
          //   text: AppLocalizations.of(context)!.booking,
          // ),
          centerTitle: true,
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            unselectedLabelColor: AppColors.greyText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor: WidgetStateProperty.all<Color?>(Colors.transparent),
            labelStyle: const TextStyle(
                fontFamily: AppFonts.inter,
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            onTap: (value) {
              if (value == 0) {
                context
                    .read<BookingProvider>()
                    .getBookingList(context: context, status: 'Active');
              }
              if (value == 1) {
                context
                    .read<BookingProvider>()
                    .getBookingList(context: context, status: 'Completed');
              }
              if (value == 2) {
                context
                    .read<BookingProvider>()
                    .getBookingList(context: context, status: 'Cancelled');
              }
            },
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.active,
              ),
              Tab(
                text: AppLocalizations.of(context)!.completed,
              ),
              Tab(
                text: AppLocalizations.of(context)!.cancelled,
              ),
            ],
          ),
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          isIceland == false
              ? Center(
                  child: Text(
                    'You are not in Iceland',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                )
              : ActiveWidget(),
          isIceland == false
              ? Center(
                  child: Text(
                    'You are not in Iceland',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                )
              : CompletedWidget(),
          isIceland == false
              ? Center(
                  child: Text(
                    'You are not in Iceland',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                )
              : CancelledWidget(),
        ]),
      ),
    );
  }
}
