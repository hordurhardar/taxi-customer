import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Providers/RatingProvider/ratingProvider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RateDriverScreen extends StatelessWidget {
  static const routeName = "/rateDriverScreen_screen";

   RateDriverScreen({super.key});
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ratingProvider =  context.read<RatingProvider>();
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.rateDriver,
            ),
          ),
        Consumer3<DriverProvider, BookRideProvider, DestinationProvider>(
        builder: (context, value, bookRideValue, destinationValue, child) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                ClipRRect(
                borderRadius:
                BorderRadius.circular(100),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          100),
                      color:
                      AppColors.greyBorder),
                  child:
                  value.driverData !=
                      null && value.driverData?.image!=null
                      ? Image.network("$IMAGE_URL${value.driverData?.image!}")
                      : Image.asset(
                    AppImages.user,
                    //'https://b2btobacco.s3.amazonaws.com/taxi/profile/image_1712987083086.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                    heightGap(10),
                     Center(
                      child: TextWidget(
                        text: "${value.driverData?.name}",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    heightGap(8),
                    Center(
                      child: TextWidget(
                        text: "${value.driverData?.carDetails?.carModel}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyHint,
                      ),
                    ),
                    heightGap(16),
                    Center(
                      child: TextWidget(
                        text: AppLocalizations.of(context)!.howWasYourTripWith,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    Center(
                      child: TextWidget(
                        text: "${value.driverData?.name}",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    const Divider(height: 40,),
                    Center(
                      child: TextWidget(
                        text: AppLocalizations.of(context)!.yourOverallRating,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyHint,
                      ),
                    ),
                    heightGap(16),
                    Center(
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(
                            horizontal: 4.0),
                        itemBuilder: (context, _) =>
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          context.read<RatingProvider>().changeRating(
                              rating: rating.toString());
                          print(rating);
                        },
                      ),
                    ),
                    const Divider(height: 40,),
                    TextWidget(
                      text: AppLocalizations.of(context)!.addDetailedReview,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyHint,
                    ),
                    heightGap(8),
                    TextFormFieldWidget(maxLines: 5,
                      hintText: AppLocalizations.of(context)!.enterHere,
                      controller: descriptionController,),
                  ],
                ),
              ),
            ),
          );
        }),

          CommonFooterWidget(cartItem: ElevatedButtonWidget(onPressed: () async {
            var bookingId = context.read<BookRideProvider>().bookingList.first.id;
            var driverId = context.read<DriverProvider>().driverData?.id;
            await context.read<RatingProvider>().addRatingApi(context: context, driverId: driverId.toString(), bookingId: bookingId!, rideId: bookingId, rating: ratingProvider.rating, description: descriptionController.text.toString());
          //  Navigator.of(context).pushReplacementNamed(ReceiptScreen.routeName);
            Navigator.of(context).pushNamedAndRemoveUntil(BottomBarScreen.routeName, (route) => false);

          },text: AppLocalizations.of(context)!.submit,)),
        ],
      ),
    );
  }
}
