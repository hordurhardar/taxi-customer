import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Settings/Emergency/emergency_contact_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';

class EmergencyScreen extends StatelessWidget {
  static const routeName = "/emergency_screen";

  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heightGap(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: 'SOS',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(color: AppColors.greyStatusBar,borderRadius: BorderRadius.circular(100)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.warning_rounded, color: AppColors.red,size: 60,),
                    ),
                  ),
                  heightGap(10),
                  const TextWidget(text: 'Use in Case of Emergency',fontSize: 23,fontWeight: FontWeight.w600,),
                  heightGap(10),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            bottomSheet(context: context, content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                heightGap(10),
                                Center(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: AppColors.greyBorder),
                                    child: const SvgPic(
                                      image: AppImages.notification,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),

                                const Center(
                                  child: TextWidget(
                                    text: 'Continue to send Alert',
                                    fontSize: 20,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                heightGap(20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButtonWidget(
                                        elevation: 0,
                                        primary: AppColors.greyStatusBar,
                                        textColor: AppColors.primary,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: AppLocalizations.of(context)!.cancel,
                                      ),
                                    ),
                                    widthGap(10),
                                    Expanded(
                                      child: ElevatedButtonWidget(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: 'Send Alert',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),);
                          },
                          child: Card(
                            elevation: 2,
                            child: SizedBox(
                              height: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(color: AppColors.greyStatusBar,borderRadius: BorderRadius.circular(100)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.call, color: AppColors.primary,),
                                    ),
                                  ),
                                  heightGap(10),
                                  const Center(
                                    child: TextWidget(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      text: 'Call Police Control Room',
                                    ),
                                  ),
                                  heightGap(10),
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: AppColors.primary)),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.greyHint,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      widthGap(10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(EmergencyContactScreen.routeName);
                          },
                          child: Card(
                            elevation: 2,
                            child: SizedBox(
                              height: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(color: AppColors.greyStatusBar,borderRadius: BorderRadius.circular(100)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.notifications, color: AppColors.primary,),
                                    ),
                                  ),
                                  heightGap(10),
                                  const Center(
                                    child: TextWidget(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      text: 'Alert Your Emergency Contacts',
                                    ),
                                  ),
                                  heightGap(10),
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: AppColors.primary)),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.greyHint,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightGap(10),
                  const TextWidget(
                    color: AppColors.greyText,
                    fontWeight: FontWeight.w500,
                   fontSize: 12,
                    text: 'Company Tracks  Location Data for a Safar and Smooth Ride',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
