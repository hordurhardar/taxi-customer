import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/ManageAddressProvider/manage_address_provider.dart';
import 'package:taxi/Screens/Settings/ManageAddress/add_address_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';

class ManageAddressScreen extends StatefulWidget {
  static const routeName = "/manageAddress_screen";

  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  @override
  void initState() {
    context.read<ManageAddressProvider>().getAllAddressApi(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<ManageAddressProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    heightGap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Toolbar(
                        title: AppLocalizations.of(context)!.manageAddress,
                      ),
                    ),
                    heightGap(20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: value.manageAddressList!.isEmpty
                            ? Center(
                                child: noDataWidget(),
                              )
                            : ListView.builder(
                                itemCount: value.manageAddressList?.length,
                                itemBuilder: (context, index) {
                                  final address =
                                      value.manageAddressList?[index];
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SvgPic(
                                            image: AppImages.locationPin,
                                            width: 28,
                                            height: 28,
                                          ),
                                          widthGap(10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: address?.addressType ??
                                                      '',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: AppColors.blackColor,
                                                ),
                                                TextWidget(
                                                  text: address?.address ?? '',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.greyText,
                                                ),
                                              ],
                                            ),
                                          ),
                                          widthGap(10),
                                          GestureDetector(
                                            onTap: () {
                                              value.isEdit = true;
                                              value.selectedAddress = value
                                                  .manageAddressList![index];
                                              value.selectedType = value
                                                      .selectedAddress!
                                                      .addressType ??
                                                  'Home';
                                              value.addressController
                                                  .text = value.selectedAddress!
                                                      .address ??
                                                  AppLocalizations.of(context)!
                                                      .enterHere;
                                              value.floorController.text = value
                                                      .selectedAddress!.floor ??
                                                  "";
                                              value.landmarkController.text =
                                                  value.selectedAddress!
                                                          .landmark ??
                                                      "";

                                              Navigator.pushNamed(context,
                                                  AddAddressScreen.routeName);
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              size: 28,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        height: 30,
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        color: AppColors.primary,
                        dashPattern: const [10, 3],
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButtonWidget(
                            textColor: AppColors.primary,
                            onPressed: () async {
                              final result = await Navigator.of(context)
                                  .pushNamed(AddAddressScreen.routeName);
                              if (result == true) {
                                if (context.mounted) {
                                  context
                                      .read<ManageAddressProvider>()
                                      .getAllAddressApi(context: context);
                                }
                              }
                            },
                            text:
                                '+ ${AppLocalizations.of(context)!.addAddress}',
                            primary: AppColors.greyStatusBar,
                            borderRadius: 8,
                          ),
                        ),
                      ),
                    ),
                    heightGap(10),
                  ],
                );
        },
      ),
    );
  }
}













// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:taxi/CommonWidgets/custom_scaffold.dart';
// import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
// import 'package:taxi/CommonWidgets/text_widget.dart';
// import 'package:taxi/Providers/ManageAddressProvider/manage_address_provider.dart';
// import 'package:taxi/Screens/Settings/ManageAddress/add_address_screen.dart';
// import 'package:taxi/Utils/app_colors.dart';
// import 'package:taxi/Utils/app_images.dart';
// import 'package:taxi/Utils/helper_methods.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:taxi/Widgets/svg_picture.dart';
// import 'package:taxi/Widgets/toolbar.dart';

// class ManageAddressScreen extends StatefulWidget {
//   static const routeName = "/manageAddress_screen";

//   const ManageAddressScreen({super.key});

//   @override
//   State<ManageAddressScreen> createState() => _ManageAddressScreenState();
// }

// class _ManageAddressScreenState extends State<ManageAddressScreen> {
//   @override
//   void initState() {
//     context.read<ManageAddressProvider>().getAllAddressApi(context: context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       resizeToAvoidBottomInset: true,
//       body: Consumer<ManageAddressProvider>(
//         builder: (context, value, child) {
//           return value.isLoading
//               ? const Center(
//                   child: CupertinoActivityIndicator(),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     heightGap(16),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Toolbar(
//                         title: AppLocalizations.of(context)!.manageAddress,
//                       ),
//                     ),
//                     heightGap(20),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: value.manageAddressList!.isEmpty
//                             ? Center(
//                                 child: noDataWidget(),
//                               )
//                             : ListView.builder(
//                                 itemCount: value.manageAddressList?.length,
//                                 itemBuilder: (context, index) {
//                                   final address =
//                                       value.manageAddressList?[index];
//                                   return Dismissible(
//                                     key: UniqueKey(),
//                                     background: Container(
//                                       color: Colors.red,
//                                       alignment: Alignment.centerRight,
//                                       margin: const EdgeInsets.only(bottom: 15),
//                                       padding:
//                                           const EdgeInsets.only(right: 20.0),
//                                       // Background color when swiping
//                                       child: const Icon(Icons.delete,
//                                           color: Colors.white),
//                                     ),
//                                     confirmDismiss:
//                                         (DismissDirection direction) async {
//                                       return await showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text("Confirm"),
//                                             content: const Text(
//                                                 "Are you sure you wish to delete this item?"),
//                                             actions: <Widget>[
//                                               ElevatedButtonWidget(
//                                                   onPressed: () {
//                                                     return Navigator.of(context)
//                                                         .pop(false);
//                                                   },
//                                                   text: 'CANCEL'),
//                                               ElevatedButtonWidget(
//                                                   onPressed: () {
//                                                     return Navigator.of(context)
//                                                         .pop(true);
//                                                   },
//                                                   text: 'DELETE'),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                     onDismissed: (direction) {
//                                       context
//                                           .read<ManageAddressProvider>()
//                                           .deleteAddressApi(
//                                               context: context,
//                                               id: address?.id.toString() ?? '',
//                                               index: index);
//                                     },
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const SvgPic(
//                                               image: AppImages.locationPin,
//                                               width: 28,
//                                               height: 28,
//                                             ),
//                                             widthGap(10),
//                                             Expanded(
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   TextWidget(
//                                                     text:
//                                                         address?.addressType ??
//                                                             '',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: 16,
//                                                     color: AppColors.blackColor,
//                                                   ),
//                                                   TextWidget(
//                                                     text:
//                                                         address?.address ?? '',
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 14,
//                                                     color: AppColors.greyText,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             widthGap(10),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 value.isEdit = true;
//                                                 value.selectedAddress = value
//                                                     .manageAddressList![index];
//                                                 value.selectedType = value
//                                                         .selectedAddress!
//                                                         .addressType ??
//                                                     'Home';
//                                                 value.addressController.text =
//                                                     value.selectedAddress!
//                                                             .address ??
//                                                         AppLocalizations.of(
//                                                                 context)!
//                                                             .enterHere;
//                                                 value.floorController.text =
//                                                     value.selectedAddress!
//                                                             .floor ??
//                                                         "";
//                                                 value.landmarkController.text =
//                                                     value.selectedAddress!
//                                                             .landmark ??
//                                                         "";

//                                                 Navigator.pushNamed(context,
//                                                     AddAddressScreen.routeName);
//                                               },
//                                               child: const Icon(
//                                                 Icons.edit,
//                                                 size: 28,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const Divider(
//                                           height: 30,
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child: DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(10),
//                         color: AppColors.primary,
//                         dashPattern: const [10, 3],
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButtonWidget(
//                             textColor: AppColors.primary,
//                             onPressed: () async {
//                               final result = await Navigator.of(context)
//                                   .pushNamed(AddAddressScreen.routeName);
//                               if (result == true) {
//                                 if (context.mounted) {
//                                   context
//                                       .read<ManageAddressProvider>()
//                                       .getAllAddressApi(context: context);
//                                 }
//                               }
//                             },
//                             text:
//                                 '+ ${AppLocalizations.of(context)!.addAddress}',
//                             primary: AppColors.greyStatusBar,
//                             borderRadius: 8,
//                           ),
//                         ),
//                       ),
//                     ),
//                     heightGap(10),
//                   ],
//                 );
//         },
//       ),
//     );
//   }
// }
