import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/Providers/ManageAddressProvider/manage_address_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';

class ChooseAddressMapScreen extends StatelessWidget {
  static const routeName = "/chooseAddressMap_screen";
   const ChooseAddressMapScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      statusBarColor: Colors.transparent,
      body: Consumer<MapProvider>(builder: (context, value, child) {
        return Stack(
          children: [
            const GoogleMapWidget(),
            Center( //picker image on google map
              child: Image.asset(AppImages.locationPinIcon, width: 80,),
            ),
            Positioned(
              top: deviceHeight(context) * 0.08,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 48,
                child: GooglePlacesAutoCompleteTextFormField(
                    textEditingController: value.controller,
                    googleAPIKey: GOOGLE_API_KEY,
                    countries: ['IS', 'IN'],
                    decoration: const InputDecoration(
                        hintText: 'Enter your address',
                        filled: true,
                        hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: AppFonts.inter),
                        border: InputBorder.none,
                        fillColor: Colors.white
                    ),
                    debounceTime: 400, // defaults to 600 ms
                   // countries: ["de"], // optional, by default the list is empty (no restrictions)
                    isLatLngRequired: true, // if you require the coordinates from the place details
                    getPlaceDetailWithLatLng: (prediction) {
                      // this method will return latlng with place detail
                      print("Coordinates: (${prediction.lat},${prediction.lng})");
                      context.read<MapProvider>().updateMapLatLongFromAutoCompleteField(prediction: prediction);
                    }, // this callback is called when isLatLngRequired is true
                    itmClick: (prediction) {
                      context.read<MapProvider>().onItemClickFromAutoCompleteField(prediction: prediction);
                    }
                ),
              ),
            ),
            Positioned(
              bottom: deviceHeight(context) * 0.08,
              left: 20,
              right: 20,
              child:ElevatedButtonWidget(onPressed: () {
                context.read<ManageAddressProvider>().setAddress(address: value.controller.text);
                Navigator.pop(context);
              }, text: 'Confirm Location'),
            )
          ],
        );
      },),
    );
  }
}
