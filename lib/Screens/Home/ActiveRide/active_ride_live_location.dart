import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Home/ActiveRide/active_at_destination_screen.dart';
import 'package:taxi/Screens/Home/Driver/driver_details_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveRideLiveLocation extends StatelessWidget {
  static const routeName = "/activeRideLocation_screen";

  const ActiveRideLiveLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      statusBarColor: Colors.transparent,
      body: Stack(
        children: [
          const GoogleMapWidget(),
          SafeArea(
            child: Column(
              children: [
                heightGap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Toolbar(
                    title: AppLocalizations.of(context)!.activeRideLiveLocation,
                  ),
                ),
                heightGap(deviceHeight(context) * 0.60),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ActiveAtDestinationScreen.routeName);
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      heightGap(20),
                                      Center(
                                        child: Container(
                                          width: 100,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.greyBorder,
                                          ),
                                        ),
                                      ),
                                      heightGap(20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .activeRide,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextWidget(
                                            text:
                                                '5 ${AppLocalizations.of(context)!.minAway}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyHint,
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.greyBorder,
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                DriverDetailsScreen.routeName,
                                              );
                                            },
                                            child: Container(
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                          widthGap(10),
                                          const Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: 'Jenny Wilson',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black,
                                                ),
                                                TextWidget(
                                                  text: 'Sedan',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.greyHint,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const TextWidget(
                                                    text: 'kr 1.25/',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black,
                                                  ),
                                                  TextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .perMile,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.greyHint,
                                                  ),
                                                ],
                                              ),
                                              const TextWidget(
                                                text: 'GR 676-UVWX',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.greyHint,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
