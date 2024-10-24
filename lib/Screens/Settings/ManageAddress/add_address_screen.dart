import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/ManageAddressProvider/manage_address_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Screens/Settings/ManageAddress/choose_address_map_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAddressScreen extends StatelessWidget {
  static const routeName = "/addAddress_screen";

  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      statusBarColor: Colors.transparent,
      body: Stack(
        children: [
          const GoogleMapWidget(),
          SafeArea(
            child: Consumer<ManageAddressProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    heightGap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Toolbar(
                        title: value.isEdit
                            ? AppLocalizations.of(context)!.editAddress
                            : AppLocalizations.of(context)!.addAddress,
                      ),
                    ),
                    heightGap(deviceHeight(context) * 0.45),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const TextWidget(
                                    text: 'Save Address as*',
                                    fontSize: 14,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: value.addressType.length,
                                      itemBuilder: (context, index) {
                                        final type = value.addressType[index];
                                        return InkWell(
                                          onTap: () {
                                            value.changeType(type: type);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: value.selectedType ==
                                                        type
                                                    ? AppColors.primary
                                                    : AppColors.greyStatusBar,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Center(
                                                child: TextWidget(text: type)),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return widthGap(10);
                                      },
                                    ),
                                  ),
                                  heightGap(5),
                                  TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .completeAddress,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                  heightGap(8),
                                  InkWell(
                                    onTap: () async {
                                      final result = await Navigator.of(context)
                                          .pushNamed(
                                              ChooseAddressMapScreen.routeName);
                                    },
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormFieldWidget(
                                        maxLines: 5,
                                        enabled: false,
                                        controller: value.addressController,
                                      ),
                                    ),
                                  ),
                                  // heightGap(16),
                                  // TextWidget(
                                  //   color: AppColors.blackColor,
                                  //   fontWeight: FontWeight.w500,
                                  //   text: AppLocalizations.of(context)!.floor,
                                  // ),
                                  // heightGap(8),
                                  // TextFormFieldWidget(
                                  //   controller: value.floorController,
                                  //   hintText: AppLocalizations.of(context)!
                                  //       .enterFloor,
                                  // ),
                                  // heightGap(8),
                                  // TextWidget(
                                  //   color: AppColors.blackColor,
                                  //   fontWeight: FontWeight.w500,
                                  //   text:
                                  //       AppLocalizations.of(context)!.landmark,
                                  // ),
                                  // heightGap(8),
                                  // TextFormFieldWidget(
                                  //   controller: value.landmarkController,
                                  // ),
                                  heightGap(20),
                                  ElevatedButtonWidget(
                                      onPressed: () async {
                                        final mapProvider =
                                            context.read<MapProvider>();
                                        if (value.isEdit) {
                                          await context
                                              .read<ManageAddressProvider>()
                                              .editAddressApi(
                                                  context: context,
                                                  addressType:
                                                      value.selectedType,
                                                  long: mapProvider
                                                      .cameraPosition!
                                                      .target
                                                      .longitude
                                                      .toString(),
                                                  lat: mapProvider
                                                      .cameraPosition!
                                                      .target
                                                      .latitude
                                                      .toString(),
                                                  address: value
                                                      .addressController.text);
                                        } else {
                                          await context
                                              .read<ManageAddressProvider>()
                                              .addAddressApi(
                                                  context: context,
                                                  addressType:
                                                      value.selectedType,
                                                  long:
                                                      mapProvider.cameraPosition!
                                                          .target.longitude
                                                          .toString(),
                                                  lat: mapProvider
                                                      .cameraPosition!
                                                      .target
                                                      .latitude
                                                      .toString(),
                                                  address: value
                                                      .addressController.text);
                                        }
                                        Navigator.pop(context, true);
                                      },
                                      text: AppLocalizations.of(context)!
                                          .saveAddress),
                                ],
                              ),
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
    );
  }
}
