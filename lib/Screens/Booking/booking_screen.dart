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
    super.initState();
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
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [ActiveWidget(), CompletedWidget(), CancelledWidget()]),
      ),
    );
  }
}
