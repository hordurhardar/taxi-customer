import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Screens/Home/saved_places.dart';
import 'package:taxi/Screens/Settings/ManageAddress/add_address_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';

class ChooseLocationCardWidget extends StatelessWidget {
  final double elevation;
  final bool showFlag;
  final bool dropEnabled;
  final double padding;
  final Function()? onTapPickUpLocationField;
  final Function()? callBack;
  final Function(String)? onChangedDropLocation;
  final TextEditingController? yourLocationController;
  final TextEditingController? dropLocationController;

  const ChooseLocationCardWidget(
      {super.key,
      this.elevation = 5,
      this.showFlag = true,
      this.dropEnabled = false,
      this.padding = 8,
      required this.onTapPickUpLocationField,
      this.callBack,
      this.yourLocationController,
      this.onChangedDropLocation,
      this.dropLocationController});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: Row(
          children: [
            Column(
              children: [
                const SvgPic(image: AppImages.roundBlack),
                SizedBox(
                  width: 30,
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
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
                const SvgPic(image: AppImages.locationYellow),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                      onTap: onTapPickUpLocationField,
                      child: TextFormFieldWidget(
                        controller: yourLocationController,
                        showBorder: false,
                        enabled: false,
                        hintText: 'Your Location',
                        hintColor: AppColors.logoblackthree,
                      )),
                  const Divider(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: context
                                  .read<DestinationProvider>()
                                  .disableDropField
                              ? () {
                                  context
                                      .read<DestinationProvider>()
                                      .disableDropFieldCall(value: true);
                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: TextFormFieldWidget(
                            /* onChanged: (value) {
                              context.read<DestinationProvider>().getDropPlacesListApi(context: context, input: value);
                            },*/
                            controller: dropLocationController,
                            onChanged: onChangedDropLocation,
                            enabled: dropEnabled,
                            showBorder: false,
                            hintText: 'Drop Location',
                          ),
                        ),
                      ),
                      if (showFlag)
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(SavedPlacesScreen.routeName)
                                      .then((onValue) {
                                    if (dropLocationController!.text
                                        .trim()
                                        .isNotEmpty) {
                                      if (callBack != null) {
                                        callBack!();
                                      }
                                    }
                                  });
                                },
                                child: const SvgPic(
                                    image: AppImages.locationFlagYellow)),
                            const SizedBox(
                              height: 36,
                              child: VerticalDivider(
                                color: AppColors.greyBorder,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AddAddressScreen.routeName);
                              },
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                    ],
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
