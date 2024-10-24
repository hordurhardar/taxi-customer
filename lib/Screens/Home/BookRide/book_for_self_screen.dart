import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/contact_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/contact_sheet_widget.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/list_tile_card_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookForSelfScreen extends StatefulWidget {
  static const routeName = "/bookForSelf_screen";

  const BookForSelfScreen({super.key});

  @override
  State<BookForSelfScreen> createState() => _BookForSelfScreenState();
}

class _BookForSelfScreenState extends State<BookForSelfScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timestamp) async {
        context
            .read<ContactProvider>()
            .getContactListFromPhone(context: context, fromGetStarted: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      statusBarColor: Colors.transparent,
      body: Stack(
        children: [
          Consumer<BookRideProvider>(
            builder: (context, value, child) {
              return GoogleMapWidget(
                polylines: Set<Polyline>.of(value.polylines.values),
                markers: value.markers,
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                        Toolbar(title: AppLocalizations.of(context)!.bookRide)),
                heightGap(deviceHeight(context) * 0.40),
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
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 10, bottom: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 100,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.greyBorder,
                                      ),
                                    ),
                                  ),
                                  heightGap(20),
                                  TextWidget(
                                      text: AppLocalizations.of(context)!
                                          .someOneElseTakingThisRide,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  heightGap(5),
                                  TextWidget(
                                      height: 1.1,
                                      text: AppLocalizations.of(context)!
                                          .chooseAContactSoThatTheyAlsoGetDriverNumber,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyHint),
                                  heightGap(30),
                                  ListTileCardWidget(
                                    onTap: Navigator.of(context).pop,
                                    titleText:
                                        AppLocalizations.of(context)!.mySelf,
                                    leadingIconPath: AppImages.personYellow,
                                    isTrailingVisible: false,
                                  ),
                                  Consumer<ContactProvider>(
                                    builder: (context, value, child) {
                                      return value.selectedContactList.isEmpty
                                          ? const SizedBox()
                                          : _buildContactList(value);
                                    },
                                  ),
                                  const Divider(),
                                  ListTileCardWidget(
                                    onTap: () {
                                      _showContactBottomSheet(
                                        context: context,
                                      );
                                    },
                                    leadingIconPath: AppImages.contact,
                                    isTrailingVisible: false,
                                    titleText: AppLocalizations.of(context)!
                                        .chooseAnotherContacts,
                                  ),
                                  heightGap(80),
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
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: AppLocalizations.of(context)!.confirm,
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
    );
  }

  Widget _buildContactList(ContactProvider value) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: value.selectedContactList.length,
      itemBuilder: (context, index) {
        final contact = value.selectedContactList[index];
        return Column(
          children: [
            const Divider(),
            ListTileCardWidget(
              titleText: contact?.name ?? '',
              subtitleText: contact?.phone ?? '',
              isTrailingVisible: false,
              leadingWidget: (contact?.isSelected ?? true)
                  ? const Icon(Icons.circle, color: AppColors.primary)
                  : const Icon(Icons.circle_outlined),
              onTap: () async {
                await context
                    .read<ContactProvider>()
                    .makeContactSelection(index: index);
              },
            ),
            // heightGap(5),
          ],
        );
      },
    );
  }

  Future<void> _showContactBottomSheet({
    BuildContext? context,
  }) async {
    await showContactListSheet(
      context: context!,
      onSelect: (contact) async {
        await context.read<ContactProvider>().selectContact(contact: contact);
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
    );
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/contact_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookForSelfScreen extends StatelessWidget {
  static const routeName = "/bookForSelf_screen";

  const BookForSelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      statusBarColor: Colors.transparent,
      body: Stack(
        children: [
          //  GoogleMapWidget(),
          Consumer<BookRideProvider>(
            builder: (context, value, child) {
              return GoogleMapWidget(
                polylines: Set<Polyline>.of(value.polylines.values),
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                heightGap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Toolbar(
                    title: AppLocalizations.of(context)!.bookRide,
                  ),
                ),
                heightGap(deviceHeight(context) * 0.40),
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
                        // alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 100,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.greyBorder,
                                      ),
                                    ),
                                  ),
                                  heightGap(20),
                                  TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .someOneElseTakingThisRide,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  heightGap(5),
                                  TextWidget(
                                    height: 1.1,
                                    text: AppLocalizations.of(context)!
                                        .chooseAContactSoThatTheyAlsoGetDriverNumber,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyHint,
                                  ),
                                  heightGap(30),
                                  Row(
                                    children: [
                                      const Icon(Icons.circle_outlined),
                                      widthGap(10),
                                      const SvgPic(
                                          image: AppImages.personYellow),
                                      widthGap(10),
                                      TextWidget(
                                        text: AppLocalizations.of(context)!
                                            .mySelf,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    height: 28,
                                  ),
                                  Consumer<ContactProvider>(
                                    builder: (context, value, child) {
                                      return value.selectedContactList.isEmpty
                                          ? const SizedBox()
                                          : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemCount: value
                                            .selectedContactList.length,
                                        itemBuilder: (context, index) {
                                          final contact = value
                                              .selectedContactList[index];
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  // await context
                                                  //     .read<
                                                  //         ContactProvider>()
                                                  //     .makeContactSelection(
                                                  //         index: index);
                                                },
                                                child: Row(
                                                  children: [
                                                    (contact?.isSelected ??
                                                        false)
                                                        ? const Icon(
                                                      Icons.circle,
                                                      color: AppColors
                                                          .primary,
                                                    )
                                                        : const Icon(Icons
                                                        .circle_outlined),
                                                    widthGap(10),
                                                    const SvgPic(
                                                        image: AppImages
                                                            .jYellow),
                                                    widthGap(10),
                                                    TextWidget(
                                                      text:
                                                      contact?.name ??
                                                          '',
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color:
                                                      AppColors.black,
                                                    ),
                                                    widthGap(10),
                                                    const Icon(
                                                      Icons.circle,
                                                      size: 8,
                                                      color: AppColors
                                                          .primary,
                                                    ),
                                                    widthGap(10),
                                                    TextWidget(
                                                      text: contact
                                                          ?.phone ??
                                                          '',
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: AppColors
                                                          .greyHint,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              heightGap(5),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  const Divider(
                                    height: 28,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await  context
                                          .read<ContactProvider>()
                                          .askPermissions(
                                          context: context,
                                          fromGetStarted: false);
                                      await _showContactBottomSheet(
                                          context: context);


                                    },
                                    child: Row(
                                      children: [
                                        widthGap(36),
                                        const SvgPic(image: AppImages.contact),
                                        widthGap(10),
                                        TextWidget(
                                          text: AppLocalizations.of(context)!
                                              .chooseAnotherContacts,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  text: AppLocalizations.of(context)!.confirm,
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
    );
  }

  Future<void> _showContactBottomSheet({
    BuildContext? context,
  }) async {
    await showModalBottomSheet(
        context: context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext c) {
          return Padding(
            padding: MediaQuery.of(c).viewInsets,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              height: deviceHeight(context) * 0.70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<ContactProvider>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.contactRequestList.length,
                            itemBuilder: (context, index) {
                              final contact = value.contactRequestList[index];
                              return InkWell(
                                onTap: () async {
                                  // await context
                                  //     .read<ContactProvider>()
                                  //     .selectContact(contact: contact);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 60,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: TextWidget(
                                                  text: contact.name ?? '')),
                                          TextWidget(text: contact.phone ?? ''),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}*/
