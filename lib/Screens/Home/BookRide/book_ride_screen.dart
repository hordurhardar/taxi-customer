import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Screens/Home/BookRide/book_for_self_screen.dart';
import 'package:taxi/Screens/Home/BookRide/schedule_ride_screen.dart';
import 'package:taxi/Screens/Home/Payment/payment_method_screen.dart';
import 'package:taxi/Screens/Home/pick_up_screen.dart';
import 'package:taxi/Screens/Home/promo_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/choose_location_card_widget.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/list_tile_card_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/vehicel_detail_card_widget.dart';

import '../../../Providers/Type/from_destination_type.dart';

class BookRideScreen extends StatefulWidget {
  static const routeName = "/bookRide_screen";

  const BookRideScreen({super.key});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<DestinationProvider>().disableDropFieldCall(value: true);

      if (context.read<HomeProvider>().currentPosition != null) {
        context.read<BookRideProvider>().makeLines(
              context: context,
              pickUpLatLng: PointLatLng(
                  context.read<HomeProvider>().currentPosition!.latitude,
                  context.read<HomeProvider>().currentPosition!.longitude),
              dropLatLng: PointLatLng(
                  context
                          .read<DestinationProvider>()
                          .selectedPredictionLatLong
                          ?.latitude ??
                      0.0,
                  context
                          .read<DestinationProvider>()
                          .selectedPredictionLatLong
                          ?.longitude ??
                      0.0),
            );
        context.read<BookRideProvider>().addMarkers(context: context);
        context.read<BookRideProvider>().getAllDriverApi(
              context: context,
            );
        context.read<BookRideProvider>().getVehicleListApi(
              context: context,
              latitude: context.read<HomeProvider>().currentPosition!.latitude,
              longitude:
                  context.read<HomeProvider>().currentPosition!.longitude,
            );
      }
    });
    super.initState();
  }

  bool isPromoapplied = false;
  Future checkPromocodeSelection() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    isPromoapplied = sp.getBool('promoCodeApplied') ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.read<DestinationProvider>().disableDropFieldCall(value: false);
      },
      child: CustomScaffold(
        extendBodyBehindAppBar: true,
        statusBarColor: Colors.transparent,
        body: Stack(
          children: [
            Consumer<BookRideProvider>(
              builder: (context, value, child) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.32,
                  child: GoogleMapWidget(
                    polylines: Set<Polyline>.of(value.polylines.values),
                    markers: value.markers,
                  ),
                );
              },
            ),
            SafeArea(
              child: Column(
                children: [
                  heightGap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Toolbar(
                      onTap: () {
                        context
                            .read<DestinationProvider>()
                            .disableDropFieldCall(value: false);
                        Navigator.of(context).pop();
                      },
                      title: AppLocalizations.of(context)!.bookRide,
                    ),
                  ),
                  heightGap(deviceHeight(context) * 0.30),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.greyBorder,
                                        ),
                                      ),
                                    ),
                                    heightGap(20),
                                    Consumer<DestinationProvider>(
                                      builder: (context, value, child) {
                                        return ChooseLocationCardWidget(
                                          yourLocationController:
                                              value.yourLocationController,
                                          onTapPickUpLocationField: () {
                                            context
                                                    .read<DestinationProvider>()
                                                    .setFromDestinationType =
                                                FromDestinationType
                                                    .fromBookRide;
                                            Navigator.of(context).pushNamed(
                                                PickUpScreen.routeName);
                                          },
                                          dropLocationController:
                                              value.dropLocationController,
                                          onChangedDropLocation: (p0) {},
                                          dropEnabled: false,
                                        );
                                      },
                                    ),
                                    heightGap(10),
                                    InkWell(
                                      onTap: () async {
                                        Navigator.of(context).pushNamed(
                                            ScheduleRideScreen.routeName);
                                      },
                                      child: ListTileCardWidget(
                                          titleText: 'Schedule later'),
                                    ),
                                    heightGap(10),
                                    Consumer<BookRideProvider>(
                                      builder: (context, value, child) {
                                        return value.vehicleList.isEmpty
                                            ? const SizedBox()
                                            : SizedBox(
                                                height: 130,
                                                width: double.infinity,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      value.vehicleList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final vehicle = value
                                                        .vehicleList[index];
                                                    return VehicleDetailCardWidget(
                                                        onTap: () async {
                                                          print(vehicle
                                                              .vehicleId);
                                                          setState(() {});
                                                          SharedPreferences sp =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          await sp.setString(
                                                              'selectedVehicleId',
                                                              vehicle.userId
                                                                  .toString());
                                                          // context
                                                          //     .read<
                                                          //         BookRideProvider>()
                                                          //     .driverId = vehicle
                                                          //         .userId ??
                                                          //     '';
                                                          await context
                                                              .read<
                                                                  BookRideProvider>()
                                                              .selectCar(
                                                                  index: index);
                                                        },
                                                        carType: vehicle
                                                                .vehicleType ??
                                                            "",
                                                        seatCapacity: vehicle
                                                            .seatCapacity
                                                            .toString(),
                                                        isSelect:
                                                            vehicle.isSelected,
                                                        miles: vehicle
                                                            .vehiclePrice
                                                            .toString(),
                                                        min: '5',
                                                        image: AppImages
                                                            .vehicleYellow);
                                                  },
                                                ),
                                              );
                                      },
                                    ),

                                    /*const Row(
                                      children: [
                                        Expanded(
                                            child: VehicleDetailCardWidget(
                                          seatCapacity: '3',
                                          miles: '1.0',
                                          min: '5',
                                          image: AppImages.vehicleYellow,
                                        )),
                                        Expanded(
                                            child: VehicleDetailCardWidget(
                                          seatCapacity: '4',
                                          miles: '1.25',
                                          min: '9',
                                          image: AppImages.vehicleBlack,
                                        )),
                                      ],
                                    ),*/
                                    // heightGap(10),
                                    // TextWidget(
                                    //   color: AppColors.blackColor,
                                    //   fontWeight: FontWeight.w500,
                                    //   text: AppLocalizations.of(context)!
                                    //       .chooseDriverGender,
                                    // ),
                                    // heightGap(10),
                                    // Consumer<BookRideProvider>(
                                    //   builder: (context, value, child) {
                                    //     return Row(
                                    //       children: [
                                    //         GestureDetector(
                                    //           onTap: () async {
                                    //             //  await  context.read<BookRideProvider>().updateLatLong();
                                    //             await context
                                    //                 .read<BookRideProvider>()
                                    //                 .selectGender(
                                    //                     gender: 'Male');
                                    //           },
                                    //           child: Stack(
                                    //             children: [
                                    //               Card(
                                    //                 elevation: 2,
                                    //                 shape:
                                    //                     RoundedRectangleBorder(
                                    //                         side: BorderSide(
                                    //                           color: value.gender ==
                                    //                                   'Male'
                                    //                               ? AppColors
                                    //                                   .primary
                                    //                               : AppColors
                                    //                                   .white,
                                    //                         ),
                                    //                         borderRadius:
                                    //                             BorderRadius
                                    //                                 .circular(
                                    //                                     12)),
                                    //                 child: SizedBox(
                                    //                   width: 150,
                                    //                   height: 120,
                                    //                   child: Column(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment
                                    //                             .center,
                                    //                     children: [
                                    //                       Container(
                                    //                         width: 70,
                                    //                         height: 70,
                                    //                         decoration: BoxDecoration(
                                    //                             color: AppColors
                                    //                                 .greyStatusBar,
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         100)),
                                    //                         child:
                                    //                             const Padding(
                                    //                           padding:
                                    //                               EdgeInsets
                                    //                                   .all(8.0),
                                    //                           child: SvgPic(
                                    //                             image: AppImages
                                    //                                 .man,
                                    //                             fit: BoxFit
                                    //                                 .contain,
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       heightGap(10),
                                    //                       const TextWidget(
                                    //                         color: AppColors
                                    //                             .blackColor,
                                    //                         fontWeight:
                                    //                             FontWeight.w400,
                                    //                         text: 'Man',
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               Positioned(
                                    //                   top: 0,
                                    //                   right: 0,
                                    //                   child: value.gender ==
                                    //                           'Male'
                                    //                       ? const SvgPic(
                                    //                           image: AppImages
                                    //                               .checkYellow)
                                    //                       : const SizedBox()),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         GestureDetector(
                                    //           onTap: () async {
                                    //             await context
                                    //                 .read<BookRideProvider>()
                                    //                 .selectGender(
                                    //                     gender: 'Female');
                                    //           },
                                    //           child: Stack(
                                    //             children: [
                                    //               Card(
                                    //                 elevation: 2,
                                    //                 shape:
                                    //                     RoundedRectangleBorder(
                                    //                         side: BorderSide(
                                    //                           color: value.gender ==
                                    //                                   'Female'
                                    //                               ? AppColors
                                    //                                   .primary
                                    //                               : AppColors
                                    //                                   .white,
                                    //                         ),
                                    //                         borderRadius:
                                    //                             BorderRadius
                                    //                                 .circular(
                                    //                                     12)),
                                    //                 child: SizedBox(
                                    //                   width: 150,
                                    //                   height: 120,
                                    //                   child: Column(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment
                                    //                             .center,
                                    //                     children: [
                                    //                       Container(
                                    //                         width: 70,
                                    //                         height: 70,
                                    //                         decoration: BoxDecoration(
                                    //                             color: AppColors
                                    //                                 .greyStatusBar,
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         100)),
                                    //                         child:
                                    //                             const Padding(
                                    //                           padding:
                                    //                               EdgeInsets
                                    //                                   .all(8.0),
                                    //                           child: SvgPic(
                                    //                             image: AppImages
                                    //                                 .women,
                                    //                             fit: BoxFit
                                    //                                 .contain,
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       heightGap(10),
                                    //                       const TextWidget(
                                    //                         color: AppColors
                                    //                             .blackColor,
                                    //                         fontWeight:
                                    //                             FontWeight.w400,
                                    //                         text: 'Woman',
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               Positioned(
                                    //                   top: 0,
                                    //                   right: 0,
                                    //                   child: value.gender ==
                                    //                           'Female'
                                    //                       ? const SvgPic(
                                    //                           image: AppImages
                                    //                               .checkYellow)
                                    //                       : const SizedBox()),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     );
                                    //   },
                                    // ),

                                    heightGap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          PaymentMethodScreen.routeName,
                                        );
                                      },
                                      child: ListTileCardWidget(
                                          titleText: 'Select payment method'),
                                    ),
                                    heightGap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          BookForSelfScreen.routeName,
                                        );
                                      },
                                      child: ListTileCardWidget(
                                        titleText: 'Pick up another rider?',
                                      ),
                                    ),
                                    heightGap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          PromoScreen.routeName,
                                        );
                                      },
                                      child: ListTileCardWidget(
                                          titleText:
                                              AppLocalizations.of(context)!
                                                  .applyPromo),
                                    ),
                                    heightGap(100),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: CommonFooterWidget(
                                  cartItem: ElevatedButtonWidget(
                                onPressed: () async {
                                  await checkPromocodeSelection();
                                  if (isPromoapplied) {
                                    if (context
                                            .read<BookRideProvider>()
                                            .selectedVehicleType ==
                                        null) {
                                      var msg = AppLocalizations.of(context)!
                                          .selectVehicle;
                                      if (context
                                          .read<BookRideProvider>()
                                          .vehicleList
                                          .isEmpty) {}
                                      showSnackBar(
                                          context: context,
                                          message: AppLocalizations.of(context)!
                                              .selectVehicle,
                                          isSuccess: false);
                                      return;
                                    }
                                    if (context
                                        .read<DestinationProvider>()
                                        .dropLocationController
                                        .text
                                        .trim()
                                        .isEmpty) {
                                      showSnackBar(
                                          context: context,
                                          message: AppLocalizations.of(context)!
                                              .selectDestination,
                                          isSuccess: false);
                                      return;
                                    }
                                    context
                                        .read<BookRideProvider>()
                                        .bookRideApi(
                                          context: context,
                                          pickUpLat: context
                                                  .read<HomeProvider>()
                                                  .currentPosition
                                                  ?.latitude ??
                                              0.0,
                                          pickUpLong: context
                                                  .read<HomeProvider>()
                                                  .currentPosition
                                                  ?.longitude ??
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
                                          gender: context
                                              .read<BookRideProvider>()
                                              .gender,
                                          vehicleType: context
                                              .read<BookRideProvider>()
                                              .selectedVehicleType!
                                              .vehicleType
                                              .toString(),
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
                                          rideType: context
                                                  .read<BookRideProvider>()
                                                  .isRideNow
                                              ? 'Now'
                                              : 'Scheduled',
                                          paymentType: context
                                              .read<BookRideProvider>()
                                              .paymentMethod,
                                          bookingDate: context
                                                  .read<BookRideProvider>()
                                                  .isRideNow
                                              ? DateTime.now()
                                                  .toUtc()
                                                  .toString()
                                              : context
                                                  .read<BookRideProvider>()
                                                  .scheduleTime
                                                  .toString(),
                                        );
                                  } else {
                                    showSnackBar(
                                        context: context,
                                        message: 'Please apply promo',
                                        isSuccess: false);
                                  }
                                },
                                text:
                                    "${AppLocalizations.of(context)!.bookMini} ",
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
