import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Utils/no_data_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedPlacesScreen extends StatefulWidget {
  static const routeName = "/savedPlaces_screen";

  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  @override
  void initState() {
    context.read<DestinationProvider>().getSavedPlacesListApi(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Toolbar(
              title: AppLocalizations.of(context)!.savedPlaces,
            ),
            heightGap(20),
            Expanded(
              child: Consumer<DestinationProvider>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : value.savedAddressList.isNotEmpty
                          ? ListView.builder(
                              itemCount: value.savedAddressList.length,
                              itemBuilder: (context, index) {
                                final place = value.savedAddressList[index];
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              if(place.location != null && place.address != null){
                                                if(place.location!.coordinates != null && place.location!.coordinates!.isNotEmpty) {
                                                  context.read<DestinationProvider>().selectedPredictionLatLong = LatLng(place.location!.coordinates!.last, place.location!.coordinates!.first);
                                                  context.read<DestinationProvider>().dropLocationController.text = place.address!;
                                                  Navigator.of(context).pop();

                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                  border: Border.all(
                                                      color: AppColors.primary)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: (place.isDefault ??
                                                              false)
                                                          ? AppColors.primary
                                                          : AppColors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          widthGap(10),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (){
                                                if(place.location != null && place.address != null){
                                                  if(place.location!.coordinates != null && place.location!.coordinates!.isNotEmpty) {
                                                    context.read<DestinationProvider>().selectedPredictionLatLong = LatLng(place.location!.coordinates!.last, place.location!.coordinates!.first);
                                                    context.read<DestinationProvider>().dropLocationController.text = place.address!;
                                                    Navigator.of(context).pop();

                                                  }
                                                }
                                              },
                                              child: TextWidget(
                                                text: place.address ?? '',
                                                fontSize: 16,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                           GestureDetector(
                                             onTap: (){
                                               showDialog(
                                                 context: context,
                                                 builder: (BuildContext context) {
                                                   return AlertDialog(
                                                     title: const Text("Confirm"),
                                                     content: Text(
                                                         AppLocalizations.of(context)!.areYouSureYouWishToDeleteThisItem),
                                                     actions: <Widget>[
                                                       ElevatedButtonWidget(
                                                           onPressed: () {
                                                             return Navigator.of(context)
                                                                 .pop(false);
                                                           },
                                                           text:  AppLocalizations.of(context)!.cancel),
                                                       ElevatedButtonWidget(
                                                           onPressed: () {

                                                             value.deleteAddressApi(context: context, id: value.savedAddressList[index].id!, index: index).then((val){
                                                               Navigator.of(context).pop();
                                                             });

                                                           },
                                                           text: AppLocalizations.of(context)!.delete),
                                                     ],
                                                   );
                                                 },
                                               );
                                             },
                                             child: const Icon(
                                              Icons.highlight_remove_rounded,
                                              color: AppColors.primary,
                                                                                       ),
                                           ),
                                        ],
                                      ),
                                    ),
                                    heightGap(30),
                                  ],
                                );
                              },
                            )
                          : NoDataWidget(title: AppLocalizations.of(context)!
                      .noSavedPlacesAvailable,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
