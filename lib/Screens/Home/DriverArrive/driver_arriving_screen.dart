import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/Booking/CancelTaxiBooking/cancel_taxi_booking.dart';
import 'package:taxi/Screens/Chat/chat_screen.dart';
import 'package:taxi/Screens/Home/Driver/driver_details_screen.dart';
import 'package:taxi/Screens/Home/PayCash/pay_cash_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/heading_value_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:cached_network_image/cached_network_image.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class DriverArrivingScreen extends StatefulWidget {
  static const routeName = "/driverArriving_screen";

  const DriverArrivingScreen({super.key});

  @override
  State<DriverArrivingScreen> createState() => _DriverArrivingScreenState();
}

class _DriverArrivingScreenState extends State<DriverArrivingScreen> {
  @override
  void initState() {
    context.read<BookRideProvider>().initSocket(context);
    super.initState();
  }

  @override
  void dispose() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        context.read<BookRideProvider>().closeSocket();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: CustomScaffold(
        extendBodyBehindAppBar: true,
        statusBarColor: Colors.transparent,
        key: scaffoldKey,
        body: Stack(
          children: [
            Consumer<BookRideProvider>(
              builder: (context, value, child) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: GoogleMapWidget(
                    polylines: Set<Polyline>.of(value.polylines.values),
                    markers: value.markers,
                  ),
                );
              },
            ),
            SafeArea(
              child: Consumer3<DriverProvider, BookRideProvider,
                  DestinationProvider>(
                builder:
                    (context, value, bookRideValue, destinationValue, child) {
                  bookRideValue.driverData = value.driverData;
                  return Column(
                    children: [
                      heightGap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Toolbar(
                          title: bookRideValue.getToolBarTitle(
                              context: context,
                              status: bookRideValue
                                      .receiveStatusUpdateModel?.data?.status ??
                                  ''),
                          showBack: false,
                        ),
                      ),
                      if (bookRideValue
                              .receiveStatusUpdateModel?.data?.status ==
                          'Arrived')
                        heightGap(deviceHeight(context) * 0.28),
                      if (bookRideValue
                              .receiveStatusUpdateModel?.data?.status ==
                          'Arriving')
                        heightGap(deviceHeight(context) * 0.40),
                      if (bookRideValue
                              .receiveStatusUpdateModel?.data?.status ==
                          'InProgress')
                        heightGap(deviceHeight(context) * 0.60),
                      if (bookRideValue
                              .receiveStatusUpdateModel?.data?.status ==
                          'Drop')
                        heightGap(deviceHeight(context) * 0.50),
                      if (bookRideValue
                              .receiveStatusUpdateModel?.data?.status ==
                          'Completed')
                        heightGap(deviceHeight(context) * 0.50),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      //   child: SizedBox(
                      //     height: 55,
                      //     child: Card(
                      //       elevation: 5,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Row(
                      //           children: [
                      //             const SvgPic(image: AppImages.infoYellow),
                      //             widthGap(5),
                      //             Expanded(
                      //                 child: TextWidget(
                      //               text:
                      //                   '10,000 ${AppLocalizations.of(context)!.areYourEstimatedRide}',
                      //               fontSize: 13,
                      //             )),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: bookRideValue
                                      .receiveStatusUpdateModel?.data?.status ==
                                  'InProgress'
                              ? InkWell(
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(ActiveAtDestinationScreen.routeName);
                                  },
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20.0, left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  heightGap(20),
                                                  Center(
                                                    child: Container(
                                                      width: 100,
                                                      height: 3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: AppColors
                                                            .greyBorder,
                                                      ),
                                                    ),
                                                  ),
                                                  heightGap(20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextWidget(
                                                          text:
                                                              '${'Active' ?? bookRideValue.receiveStatusUpdateModel?.data?.status ?? ''} Ride',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      // TextWidget(
                                                      //   text: '5 ${AppLocalizations.of(context)!.minAway}',
                                                      //   fontSize: 14,
                                                      //   fontWeight: FontWeight.w500,
                                                      //   color: AppColors.greyHint,
                                                      // ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    color: AppColors.greyBorder,
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          // Navigator.of(context)
                                                          //     .pushNamed(
                                                          //         DriverDetailsScreen
                                                          //             .routeName);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: 42,
                                                            width: 42,
                                                            imageUrl:
                                                                "$IMAGE_URL${value.driverData?.image}",
                                                            placeholder:
                                                                (context, url) {
                                                              return SvgPicture
                                                                  .asset(AppImages
                                                                      .personGrey);
                                                            },
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return SvgPicture
                                                                  .asset(AppImages
                                                                      .personGrey);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      widthGap(10),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextWidget(
                                                              text: value
                                                                      .driverData
                                                                      ?.name ??
                                                                  '',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                            TextWidget(
                                                              text: bookRideValue
                                                                      .bookingList
                                                                      .isNotEmpty
                                                                  ? bookRideValue
                                                                          .bookingList
                                                                          .first
                                                                          .carType ??
                                                                      ""
                                                                  : "",
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .greyHint,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              TextWidget(
                                                                text:
                                                                    '${bookRideValue.bookingList.isNotEmpty ? bookRideValue.bookingList.first.perMileAmount : ""}',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .black,
                                                              ),
                                                              TextWidget(
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .perMile,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .greyHint,
                                                              ),
                                                            ],
                                                          ),
                                                          TextWidget(
                                                            text: value
                                                                    .driverData
                                                                    ?.carDetails
                                                                    ?.carNumber ??
                                                                '',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .greyHint,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : bookRideValue.receiveStatusUpdateModel?.data
                                              ?.status ==
                                          'Drop' ||
                                      bookRideValue.receiveStatusUpdateModel
                                              ?.data?.status ==
                                          'Completed'
                                  ? Card(
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    heightGap(20),
                                                    Center(
                                                      child: Container(
                                                        width: 100,
                                                        height: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: AppColors
                                                              .greyBorder,
                                                        ),
                                                      ),
                                                    ),
                                                    heightGap(20),
                                                    const SvgPic(
                                                        image: AppImages
                                                            .locationWithCheck),
                                                    heightGap(20),
                                                    TextWidget(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .arrivedAtDestination,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    heightGap(10),
                                                    TextWidget(
                                                      text: destinationValue
                                                          .dropLocationController
                                                          .text,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.greyHint,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ElevatedButtonWidget(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(PayCashScreen
                                                          .routeName);
                                                },
                                                text:
                                                    '${AppLocalizations.of(context)!.payCash} kr ${bookRideValue.bookingList.isNotEmpty ? bookRideValue.bookingList.first.totalAmount != null ? double.parse(bookRideValue.bookingList.first.totalAmount.toString()).toStringAsFixed(2) : "" : ""}'),
                                            heightGap(20),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Card(
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    heightGap(20),
                                                    Center(
                                                      child: Container(
                                                        width: 100,
                                                        height: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: AppColors
                                                              .greyBorder,
                                                        ),
                                                      ),
                                                    ),
                                                    heightGap(20),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextWidget(
                                                            text:
                                                                'Driver is ${bookRideValue.receiveStatusUpdateModel?.data?.status ?? ''}...' /*AppLocalizations.of(
                                                          context)!
                                                      .driverArriving*/
                                                            ,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        // TextWidget(
                                                        //   text:
                                                        //       '5 ${AppLocalizations.of(context)!.minAway}',
                                                        //   fontSize: 14,
                                                        //   fontWeight:
                                                        //       FontWeight.w500,
                                                        //   color: AppColors
                                                        //       .greyText,
                                                        // ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color:
                                                          AppColors.greyBorder,
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    DriverDetailsScreen
                                                                        .routeName,
                                                                    arguments: {
                                                                  'driver_id': value
                                                                      .driverData
                                                                      ?.driverId
                                                                });
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              height: 42,
                                                              width: 42,
                                                              imageUrl:
                                                                  "$IMAGE_URL${value.driverData != null ? value.driverData?.image : ""}",
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return SvgPicture
                                                                    .asset(AppImages
                                                                        .personGrey);
                                                              },
                                                              errorWidget:
                                                                  (context, url,
                                                                      error) {
                                                                return SvgPicture
                                                                    .asset(AppImages
                                                                        .personGrey);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        widthGap(10),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              TextWidget(
                                                                text: value
                                                                        .driverData
                                                                        ?.name ??
                                                                    '',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .black,
                                                              ),
                                                              TextWidget(
                                                                text: bookRideValue
                                                                        .bookingList
                                                                        .isNotEmpty
                                                                    ? bookRideValue
                                                                            .bookingList
                                                                            .first
                                                                            .carType ??
                                                                        ""
                                                                    : "",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .greyHint,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (builder) => ChatScreen(
                                                                        driverData:
                                                                            value
                                                                                .driverData,
                                                                        bookingData: bookRideValue
                                                                            .bookingList
                                                                            .first)));
                                                            currentRoute =
                                                                ChatScreen
                                                                    .routeName;
                                                          },
                                                          child: const SvgPic(
                                                              image: AppImages
                                                                  .chatYellowRound),
                                                        ),
                                                        widthGap(10),
                                                        InkWell(
                                                            onTap: () {
                                                              makingPhoneCall(
                                                                  number: value
                                                                          .driverData
                                                                          ?.contact ??
                                                                      '');
                                                            },
                                                            child: const SvgPic(
                                                                image: AppImages
                                                                    .phoneYellowRound)),
                                                      ],
                                                    ),
                                                    if (bookRideValue
                                                            .receiveStatusUpdateModel
                                                            ?.data
                                                            ?.status ==
                                                        'Arrived')
                                                      Card(
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 8),
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  const SvgPic(
                                                                      image: AppImages
                                                                          .roundBlack),
                                                                  SizedBox(
                                                                    width: 30,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount:
                                                                          3,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            const TextWidget(
                                                                              text: '|',
                                                                              fontSize: 8,
                                                                            ),
                                                                            heightGap(1),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SvgPic(
                                                                      image: AppImages
                                                                          .locationYellow),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    InkWell(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            TextFormFieldWidget(
                                                                          controller: bookRideValue
                                                                              .yourLocationController
                                                                            ..text =
                                                                                destinationValue.yourLocationController.text,
                                                                          showBorder:
                                                                              false,
                                                                          enabled:
                                                                              false,
                                                                          hintText:
                                                                              'Your Location',
                                                                        )),
                                                                    Stack(
                                                                      children: [
                                                                        const Divider(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        if (bookRideValue.receiveStatusUpdateModel?.data?.otp !=
                                                                            null)
                                                                          Card(
                                                                            child:
                                                                                TextWidget(
                                                                              text: "OTP - ${bookRideValue.receiveStatusUpdateModel?.data?.otp ?? ""}",
                                                                            ),
                                                                          )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                null,
                                                                            child:
                                                                                TextFormFieldWidget(
                                                                              controller: bookRideValue.dropLocationController..text = destinationValue.dropLocationController.text,
                                                                              enabled: false,
                                                                              showBorder: false,
                                                                              hintText: 'Drop Location',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    const Divider(
                                                      color:
                                                          AppColors.greyBorder,
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        HeadingValueWidget(
                                                            heading:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .ratePer,
                                                            value: bookRideValue
                                                                    .bookingList
                                                                    .isNotEmpty
                                                                ? bookRideValue
                                                                    .bookingList
                                                                    .first
                                                                    .perMileAmount
                                                                    .toString()
                                                                : ""),
                                                        HeadingValueWidget(
                                                            heading:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .carNumber,
                                                            value: value
                                                                    .driverData
                                                                    ?.carDetails
                                                                    ?.carNumber ??
                                                                ''),
                                                        HeadingValueWidget(
                                                            heading:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .noOfSeats,
                                                            value: bookRideValue
                                                                    .bookingList
                                                                    .isNotEmpty
                                                                ? bookRideValue
                                                                    .bookingList
                                                                    .first
                                                                    .seatCapacity
                                                                    .toString()
                                                                : ""),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ElevatedButtonWidget(
                                              onPressed: () {
                                                //context.read<BookRideProvider>().cancelRide(context: context, bookingId: bookRideValue.bookingList.first.id!, reason: "");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            CancelTaxiBooking(
                                                              bookingId:
                                                                  bookRideValue
                                                                      .bookingList
                                                                      .first
                                                                      .id,
                                                            )));
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .cancelRide,
                                            ),
                                            heightGap(20),
                                          ],
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  makingPhoneCall({required String number}) async {
    var url = Uri.parse("tel:$number");
    if (await UrlLauncher.canLaunchUrl(url)) {
      await UrlLauncher.launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
