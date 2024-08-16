import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Providers/Type/from_destination_type.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Home/destination_screen.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Remote/api_config.dart';
import '../../Utils/app_images.dart';

class PickUpScreen extends StatefulWidget {
  static const routeName = "/pickUp_screen";

  const PickUpScreen({
    super.key,
  });

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = context.read<HomeProvider>();
      context.read<MapProvider>().setAutoCompleteFieldController(
            address: homeProvider.homeSearchController.text,
          );
      context.read<MapProvider>().setCameraPosition();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final destinationProvider = context.read<DestinationProvider>();

    return CustomScaffold(
      extendBodyBehindAppBar: true,
      statusBarColor: Colors.transparent,
      body: Stack(
        children: [
          const GoogleMapWidget(),
          Center(
            //picker image on google map
            child: Image.asset(
              AppImages.locationPinIcon,
              width: 80,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  heightGap(16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Toolbar(
                      title: 'Pick-up',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: deviceHeight(context) * 0.14,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 48,
              child: Consumer<MapProvider>(
                builder: (context, value, child) {
                  value.context = context;
                  return GooglePlacesAutoCompleteTextFormField(
                      textEditingController: value.controller,
                      googleAPIKey: GOOGLE_API_KEY,
                      countries: ['IS', 'IN'],
                      decoration:
                      const InputDecoration(
                          hintText: 'Enter your address',
                          filled: true,
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: AppFonts.inter),
                          border: InputBorder.none,
                          fillColor: Colors.white),
                      debounceTime: 400,
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (prediction) {
                        print(prediction.lat);
                        print(prediction.lng);
                        context.read<MapProvider>().updateMapLatLongFromAutoCompleteField(prediction: prediction);
                      },

                      // this callback is called when isLatLngRequired is true
                      itmClick: (prediction) {

                        context.read<MapProvider>().onItemClickFromAutoCompleteField(prediction: prediction);
                      //  context.read<MapProvider>().updateMapLatLongFromAutoCompleteField(prediction: prediction);

                      });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 0,
            child: InkWell(
                onTap: (){
                  context.read<MapProvider>().cameraMovedToCurrentLocation();
                },
                child: SvgPicture.asset(AppImages.gps, height: 120, width: 120,)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CommonFooterWidget(
                cartItem: ElevatedButtonWidget(
              onPressed: () async {
                //Set the text form field with address
                await homeProvider.setHomeSearchController(text: context.read<MapProvider>().controller.text);
                await destinationProvider.setDestinationYourLocationController();

                await homeProvider.setCurrentPosition(
                    position: LatLng(context.read<MapProvider>().cameraPosition?.target.latitude ?? 0.0, context.read<MapProvider>().cameraPosition?.target.longitude ?? 0.0));
                context.read<MapProvider>().setCameraPosition();

                await context.read<HomeProvider>().getAllDriverApi(
                      context: context,
                      lat: homeProvider.currentPosition?.latitude.toString() ?? '0.0',
                      long: homeProvider.currentPosition?.longitude.toString() ?? '0.0',
                    );

                if (context.read<DestinationProvider>().getFromDestinationType == FromDestinationType.fromDestination) {
                  Navigator.pushReplacementNamed(
                    context,
                    DestinationScreen.routeName,
                  );
                  return;
                }
                if (context.read<DestinationProvider>().getFromDestinationType == FromDestinationType.fromBookRide) {
                  Navigator.of(context).pop();
                  return;
                }
                Navigator.pushNamedAndRemoveUntil(context, BottomBarScreen.routeName, (route) => false);
              },
              text: AppLocalizations.of(context)!.confirmLocation,
            )),
          ),
        ],
      ),
    );
  }
}
