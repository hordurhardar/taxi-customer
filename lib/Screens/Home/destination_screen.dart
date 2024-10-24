import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/Type/from_destination_type.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Home/BookRide/book_ride_screen.dart';
import 'package:taxi/Screens/Home/pick_up_screen.dart';
import 'package:taxi/Screens/Home/saved_places.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/choose_location_card_widget.dart';
import 'package:taxi/Widgets/list_tile_card_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DestinationScreen extends StatefulWidget {
  static const routeName = "/destination_screen";

  const DestinationScreen({super.key});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  @override
  void initState() {
    context.read<DestinationProvider>().setDestinationYourLocationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<DestinationProvider>(context, listen: false);
    myProvider.setContext(context);
    return CustomScaffold(
      body: Consumer<DestinationProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Toolbar(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, BottomBarScreen.routeName, (route) => false);
                  },
                  title: AppLocalizations.of(context)!.destination,
                ),
              ),
              heightGap(30),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        ChooseLocationCardWidget(
                          yourLocationController: value.yourLocationController,
                          onTapPickUpLocationField: () {
                            context
                                    .read<DestinationProvider>()
                                    .setFromDestinationType =
                                FromDestinationType.fromDestination;
                            Navigator.of(context)
                                .pushReplacementNamed(PickUpScreen.routeName);
                          },
                          dropEnabled: true,
                          dropLocationController: value.dropLocationController,
                          onChangedDropLocation: (p0) {
                            context
                                .read<DestinationProvider>()
                                .getDropPlacesListApi(
                                    context: context, input: p0);
                          },
                          callBack: () {
                            Navigator.of(context)
                                .pushReplacementNamed(BookRideScreen.routeName);
                          },
                        ),
                        heightGap(10),
                        InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SavedPlacesScreen.routeName)
                                  .then((onValue) {
                                if (value.dropLocationController.text
                                    .trim()
                                    .isNotEmpty) {
                                  Navigator.of(context)
                                      .pushNamed(BookRideScreen.routeName);
                                }
                              });
                            },
                            child: ListTileCardWidget(
                                titleText:
                                    AppLocalizations.of(context)!.savedPlaces)),
                        heightGap(10),
                        if (context
                                .read<DestinationProvider>()
                                .predictionsList
                                ?.length !=
                            0)
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: value.predictionsList?.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final location =
                                        value.predictionsList?[index];
                                    return InkWell(
                                      onTap: () async {
                                        context
                                                .read<DestinationProvider>()
                                                .setFromDestinationType =
                                            FromDestinationType.fromDestination;
                                        await context
                                            .read<DestinationProvider>()
                                            .selectPredictionLocation(
                                                prediction: location!);
                                        await context
                                            .read<DestinationProvider>()
                                            .getLatLongFromPlaceIdApi(
                                                placeID: value
                                                        .selectedPrediction
                                                        ?.placeId
                                                        .toString() ??
                                                    '',
                                                context: context);

                                        Navigator.of(context).pushNamed(
                                            BookRideScreen.routeName);
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const SvgPic(
                                                    image: AppImages
                                                        .refreshYellow),
                                                widthGap(10),
                                                Expanded(
                                                    child: TextWidget(
                                                  text: location?.description ??
                                                      '',
                                                )),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                              visible: index !=
                                                  (value.predictionsList
                                                              ?.length ??
                                                          0) -
                                                      1,
                                              child: const Divider()),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              /*   CommonFooterWidget(
                cartItem: ElevatedButtonWidget(
                  onPressed: () {
                    if(context.read<DestinationProvider>().yourLocationController.text.isEmpty){
                      showSnackBar(context: context,isSuccess: false,message: 'Please Enter Your Location');
                      return;
                    }
                    if(context.read<DestinationProvider>().dropLocationController.text.isEmpty){
                      showSnackBar(context: context,isSuccess: false,message: 'Please Enter Drop Location');
                      return;
                    }
                    Navigator.of(context).pushNamed(BookRideScreen.routeName);
                  },
                  text: AppLocalizations.of(context)!.confirmLocation,
                )),*/
            ],
          );
        },
      ),
    );
  }
}
