import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Home/PayCash/pay_cash_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveAtDestinationScreen extends StatelessWidget {
  static const routeName = "/activeAtDestination_screen";

  const ActiveAtDestinationScreen({super.key});

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
                    title: AppLocalizations.of(context)!.activeAtDestination,
                  ),
                ),
                heightGap(deviceHeight(context) * 0.50),
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
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
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
                                    const SvgPic(
                                        image: AppImages.locationWithCheck),
                                    heightGap(20),
                                    TextWidget(
                                      text: AppLocalizations.of(context)!
                                          .arrivedAtDestination,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    heightGap(10),
                                    const TextWidget(
                                      text: '6391 Elgin St. Celina, Delawa...',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyHint,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButtonWidget(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(PayCashScreen.routeName);
                                },
                                text:
                                    '${AppLocalizations.of(context)!.payCash} kr12.5'),
                            heightGap(20),
                          ],
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
