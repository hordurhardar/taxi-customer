import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Providers/Type/from_destination_type.dart';
import 'package:taxi/Screens/Home/destination_screen.dart';
import 'package:taxi/Screens/Home/pick_up_screen.dart';
import 'package:taxi/Screens/Settings/ManageAddress/manage_address_screen.dart';
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
  clearPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('promoCodeApplied');
    await sp.remove('selectedVehicleId');
    setState(() {});
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      clearPrefs();
      context.read<BookRideProvider>().initSocket(context);
      _goToCurrentLocation();
    });
    context.read<ManageAddressProvider>().getAllAddressApi(context: context);
    super.initState();
  }

// GoogleMapController? _mapController;
  Future<Position> _getCurrentLocation() async {
    setState(() {});
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Function to move map to current location
  Future<void> _goToCurrentLocation() async {
    setState(() {});
    Position currentPosition = await _getCurrentLocation();
    setState(() {});
    await context
        .read<MapProvider>()
        .mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15.0, // Adjust zoom as needed
          ),
        ));
    // Get address from coordinates
    await _getAddressFromLatLng(
        currentPosition.latitude, currentPosition.longitude);
    print(
        'the current lat ${currentPosition.latitude} lng ${currentPosition.longitude}');
  }

  // Function to get address from coordinates
  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = '${place.street}, ${place.locality}, ${place.country}';
        print('Address: $address');
        // Do something with the address (e.g., update UI)
      }
    } catch (e) {
      print('Error getting address: $e');
    }
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
                    height: MediaQuery.of(context).size.height / 1.62,
                    child: GoogleMapWidget(
                      markers: value.markers,
                      onCameraMove: (val) {
                        setState(() {});
                        value.homeSearchController.text = val;
                      },
                    ),
                  );
                },
              ),
              Center(
                //picker image on google map
                child: GestureDetector(
                  onTap: () {
                    _goToCurrentLocation();
                  },
                  child: Image.asset(
                    AppImages.locationPinIcon,
                    width: 80,
                  ),
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
                  height: 234,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: AppLocalizations.of(context)!.whereTo,
                                fontSize: 20,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ManageAddressScreen.routeName);
                                },
                                child: TextWidget(
                                  text: AppLocalizations.of(context)!.manage,
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              )
                            ],
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
                                  height: 130,
                                  child: Card(
                                    color: AppColors.primary,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
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
                                                .enterDestination,
                                            fontSize: 15,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // heightGap(10),
                                        // Center(
                                        //   child: TextWidget(
                                        //     color: AppColors.greyHint,
                                        //     textAlign: TextAlign.center,
                                        //     fontSize: 13,
                                        //     text: AppLocalizations.of(context)!
                                        //         .enterDestination,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Consumer<ManageAddressProvider>(
                                  builder: (context, value, child) {
                                    return SizedBox(
                                      height: 130,
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
                                                      'Saved address';
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
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
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
                                                          text: 'Saved Address',
                                                          //  text: address
                                                          //     ?.addressType ??
                                                          // '',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .blackColor,
                                                        ),
                                                      ),
                                                      heightGap(5),
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
                                                        fontSize: 12,
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
