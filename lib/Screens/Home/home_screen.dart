import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Providers/Type/from_destination_type.dart';
import 'package:taxi/Screens/Home/destination_screen.dart';
import 'package:taxi/Screens/Home/pick_up_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';

import '../../Providers/BookRideProvider/book_ride_provider.dart';
import '../../Providers/ManageAddressProvider/manage_address_provider.dart';
import '../Settings/ManageAddress/add_address_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<BookRideProvider>().initSocket(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<DestinationProvider>(context, listen: false);
    myProvider.setContext(context);
    return CustomScaffold(
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.82,
                    child: GoogleMapWidget(
                      markers: value.markers,
                      onCameraMove: (val) {
                        value.homeSearchController.text = val;
                      },
                    ),
                  );
                },
              ),
              Center(
                //picker image on google map
                child: Image.asset(
                  AppImages.locationPinIcon,
                  width: 80,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    context.read<DestinationProvider>().setFromDestinationType =
                        FromDestinationType.fromHome;

                    Navigator.of(context).pushNamed(
                      PickUpScreen.routeName,
                    );
                  },
                  child: TextFormFieldWidget(
                    enabled: false,
                    controller: value.homeSearchController,
                    suffixIcon: const Icon(
                      Icons.bookmark_border_rounded,
                      color: AppColors.primary,
                    ),
                    hintText: AppLocalizations.of(context)!.currentLocation,
                    fillColor: AppColors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 274,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: AppLocalizations.of(context)!.whereTo,
                            fontSize: 20,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                          heightGap(20),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                          .read<DestinationProvider>()
                                          .setFromDestinationType =
                                      FromDestinationType.fromHome;
                                  if (context
                                          .read<HomeProvider>()
                                          .currentPosition !=
                                      null) {
                                    Navigator.of(context)
                                        .pushNamed(DestinationScreen.routeName);
                                  }
                                },
                                child: SizedBox(
                                  width: 150,
                                  height: 180,
                                  child: Card(
                                    color: AppColors.primary,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: AppColors.white,
                                            ),
                                            child: const Icon(
                                              Icons.location_on_sharp,
                                              size: 32,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        heightGap(10),
                                        Center(
                                          child: TextWidget(
                                            text: AppLocalizations.of(context)!
                                                .destination,
                                            fontSize: 16,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        heightGap(10),
                                        Center(
                                          child: TextWidget(
                                            color: AppColors.greyHint,
                                            textAlign: TextAlign.center,
                                            fontSize: 13,
                                            text: AppLocalizations.of(context)!
                                                .enterDestination,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Consumer<ManageAddressProvider>(
                                  builder: (context, value, child) {
                                    return SizedBox(
                                      height: 180,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            value.manageAddressList?.length,
                                        itemBuilder: (context, index) {
                                          final address =
                                              value.manageAddressList?[index];
                                          return SizedBox(
                                            width: 150,
                                            child: Card(
                                              color: AppColors.white,
                                              child: InkWell(
                                                highlightColor: AppColors
                                                    .primary
                                                    .withOpacity(0.5),
                                                focusColor: AppColors.primary
                                                    .withOpacity(0.5),
                                                onTap: () {
                                                  value.isEdit = true;
                                                  value.selectedAddress =
                                                      value.manageAddressList![
                                                          index];
                                                  value.selectedType = value
                                                          .selectedAddress!
                                                          .addressType ??
                                                      'Home';
                                                  value.addressController.text =
                                                      value.selectedAddress!
                                                              .address ??
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .enterHere;
                                                  value.floorController.text =
                                                      value.selectedAddress!
                                                              .floor ??
                                                          "";
                                                  value.landmarkController
                                                      .text = value
                                                          .selectedAddress!
                                                          .landmark ??
                                                      "";
                                                  Navigator.pushNamed(
                                                      context,
                                                      AddAddressScreen
                                                          .routeName);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                AppColors.black,
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .location_on_sharp,
                                                            size: 32,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      heightGap(10),
                                                      Center(
                                                        child: TextWidget(
                                                          text: address
                                                                  ?.addressType ??
                                                              '',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .blackColor,
                                                        ),
                                                      ),
                                                      heightGap(10),
                                                      TextWidget(
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        text:
                                                            address?.address ??
                                                                '',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color:
                                                            AppColors.greyText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
