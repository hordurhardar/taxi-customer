import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/BookingProvider/booking_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CancelTaxiBooking extends StatefulWidget {
  static const routeName = "/cancelTaxiBooking_screen";
  final bookingId;

  const CancelTaxiBooking({this.bookingId, super.key});

  @override
  State<CancelTaxiBooking> createState() => _CancelTaxiBookingState();
}

class _CancelTaxiBookingState extends State<CancelTaxiBooking> {
  @override
  void initState() {
    context.read<BookingProvider>().getCancelReasons(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.read<BookingProvider>();
    return CustomScaffold(
      body: Consumer3<BookingProvider, BookRideProvider, DriverProvider>(
        builder: (context, bookingProvider, bookRideProvider, driverProvider,
            child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightGap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Toolbar(
                  title: AppLocalizations.of(context)!.cancelTaxiBooking,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: AppLocalizations.of(context)!
                              .pleaseSelectTheReasonForCancellations,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyHint,
                        ),
                        Column(
                            children: List.generate(
                                bookingProvider.reasonsList.length, (index) {
                          final item = bookingProvider.reasonsList[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Radio(
                                  activeColor: Colors.blue,
                                  value: item.title,
                                  groupValue: bookingProvider.selectedReason,
                                  onChanged: (value) {
                                    bookingProvider.selectReason(
                                        reason: value!);
                                  }),
                              Expanded(
                                child: TextWidget(
                                  text: (item.title ?? ''),
                                ),
                              ),
                            ],
                          );
                        })),
                        // Column(
                        //     children: List.generate(timeSlot.length, (index) {
                        //   final item = timeSlot[index];
                        //   return Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Radio(
                        //           activeColor: Colors.blue,
                        //           value: item['value'],
                        //           groupValue: _oneValue,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _oneValue = value!;
                        //             });
                        //           }),
                        //       Expanded(
                        //         child: Text(
                        //           (item['label']),
                        //           // style: Typographies.largeBodyStyle(),
                        //         ),
                        //       ),
                        //     ],
                        //   );
                        // })),
                        Visibility(
                          visible: bookingProvider.selectedReason == "Other",
                          child: const Divider(
                            height: 40,
                          ),
                        ),
                        Visibility(
                          visible: bookingProvider.selectedReason == "Other",
                          child: TextWidget(
                            text: AppLocalizations.of(context)!.other,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyHint,
                          ),
                        ),
                        heightGap(8),
                        Visibility(
                          visible: bookingProvider.selectedReason == "Other",
                          child: TextFormFieldWidget(
                            maxLines: 5,
                            controller: bookingProvider.reasonController,
                            hintText: AppLocalizations.of(context)!.enterHere,
                          ),
                        ),
                        heightGap(8),
                        TextWidget(
                          text:
                              '${AppLocalizations.of(context)!.cancelWithIn} 3 mins ${AppLocalizations.of(context)!.otherwisePayCancellationFee}',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CommonFooterWidget(
                cartItem: ElevatedButtonWidget(
                  onPressed: () {
                    if (bookingProvider.selectedReason == "" ||
                        bookingProvider.selectedReason == "Other") {
                      bookingProvider.selectedReason =
                          bookingProvider.reasonController.text.trim();
                    }
                    print(bookingProvider.selectedReason);
                    if (bookingProvider.selectedReason != "") {
                      bookRideProvider.cancelRide(
                        context: context,
                        bookingId: widget.bookingId,
                        reason: bookingProvider.selectedReason,
                      );
                    } else {
                      showSnackBar(
                          context: context,
                          message: "Please select reason to cancel",
                          isSuccess: false);
                    }
                  },
                  text: AppLocalizations.of(context)!.cancelRide,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
