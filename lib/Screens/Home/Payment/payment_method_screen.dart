import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Screens/Home/Payment/add_card_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/list_tile_card_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';

class PaymentMethodScreen extends StatefulWidget {
  static const routeName = "/paymentMethod_screen";

  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List timeSlot = [
    {'label': 'Cash', 'value': 1},
    {'label': 'Loyalty Points', 'value': 2},
    {'label': 'Wallet', 'value': 3},
  ];

  List paymentOptions = [
    {
      'label': 'Paypal',
      'value': 1,
      'icon': AppImages.googleLogo,
    },
    {
      'label': 'Apple Pay',
      'value': 2,
      'icon': AppImages.appleLogo,
    },
    {
      'label': 'Google Pay',
      'value': 3,
      'icon': AppImages.googleLogo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<BookRideProvider>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heightGap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Toolbar(
                  title: AppLocalizations.of(context)!.paymentMethods,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            children: List.generate(timeSlot.length, (index) {
                          final item = timeSlot[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              heightGap(10),
                              TextWidget(
                                text: item['label'],
                                fontSize: 20,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                              heightGap(8),
                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextWidget(
                                          text: (item['label']),
                                          // style: Typographies.largeBodyStyle(),
                                        ),
                                      ),
                                      Radio(
                                          activeColor: Colors.blue,
                                          value: item['value'],
                                          groupValue: value.oneValue,
                                          onChanged: (value) {
                                            setState(() {
                                              // _oneValue = value!;
                                              // print(_oneValue);
                                              context
                                                  .read<BookRideProvider>()
                                                  .selectPayment(type: value!);

                                              context
                                                  .read<BookRideProvider>()
                                                  .selectPaymentMethod(
                                                      type: item['label']);
                                              // if(_oneValue == 3){
                                              //   Navigator.of(context).pushNamed(WalletScreen.routeName,arguments: true);
                                              // }
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })),
                        heightGap(10),
                        TextWidget(
                          text: AppLocalizations.of(context)!.creditDebitCard,
                          fontSize: 20,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                        heightGap(8),
                        InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AddCardScreen.routeName);
                            },
                            child: ListTileCardWidget(
                              titleText: AppLocalizations.of(context)!.addCard,
                              arrowColor: AppColors.primary,
                              leadingIconPath: AppImages.walletYellow,
                            )),
                        heightGap(10),
                        TextWidget(
                          text:
                              AppLocalizations.of(context)!.morePaymentOptions,
                          fontSize: 20,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                        heightGap(10),
                        Card(
                          elevation: 5,
                          child: Column(
                              children:
                                  List.generate(paymentOptions.length, (index) {
                            final item = paymentOptions[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPic(image: item['icon']),
                                        widthGap(8),
                                        Expanded(
                                          child: Text(
                                            (item['label']),
                                            // style: Typographies.largeBodyStyle(),
                                          ),
                                        ),
                                        Radio(
                                            activeColor: AppColors.primary,
                                            value: item['value'],
                                            groupValue:
                                                value.paymentOptionsValue,
                                            onChanged: (value) {
                                              // setState(() {
                                              //   _paymentOptionsValue = value!;
                                              // });
                                              context
                                                  .read<BookRideProvider>()
                                                  .selectMorePaymentOptions(
                                                      type: value!);

                                              context
                                                  .read<BookRideProvider>()
                                                  .selectPaymentMethod(
                                                      type: item['label']);
                                            }),
                                      ],
                                    ),
                                  ),
                                  if (index != paymentOptions.length - 1)
                                    const Divider()
                                ],
                              ),
                            );
                          })),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CommonFooterWidget(
                  cartItem: ElevatedButtonWidget(
                onPressed: () {
                  context.read<BookRideProvider>().bookRideApi(
                      context: context,
                      pickUpLat:
                          context.read<HomeProvider>().currentPosition?.latitude ??
                              0.0,
                      pickUpLong:
                          context.read<HomeProvider>().currentPosition?.longitude ??
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
                      gender: context.read<BookRideProvider>().gender,
                      vehicleType: 'MIni car',
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
                      rideType: context.read<BookRideProvider>().isRideNow
                          ? 'Now'
                          : 'Scheduled',
                      paymentType:
                          context.read<BookRideProvider>().paymentMethod,
                      bookingDate: context.read<BookRideProvider>().isRideNow
                          ? DateTime.now().toUtc().toString()
                          : context.read<BookRideProvider>().scheduleTime.toString());
                },
                text: AppLocalizations.of(context)!.bookMini,
              )),
            ],
          );
        },
      ),
    );
  }
}
