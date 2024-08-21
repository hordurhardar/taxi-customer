import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Providers/ProfileProvider/profile_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/Profile/your_profile_screen.dart';
import 'package:taxi/Screens/Settings/ManageAddress/manage_address_screen.dart';
import 'package:taxi/Screens/Settings/setting_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Utils/helper_methods.dart';
import '../Home/BookRide/pre_book_ride.dart';
import '../Home/Payment/payment_method_screen.dart';
import '../Home/promo_screen.dart';
import '../Notification/notification_screen.dart';
import '../Settings/Emergency/emergency_screen.dart';
import '../Settings/help_center_screen.dart';
import '../Settings/invite_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileProvider>().getProfileApi(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      heightGap(deviceHeight(context) * 0.04),
                      Center(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: value.profileData?.profileImage != null
                                    ? Image.network(
                                        '$IMAGE_URL${value.profileData?.profileImage ?? ''}',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(AppImages.user),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 10,
                            //   right: 0,
                            //   child: Container(
                            //     width: 36,
                            //     height: 36,
                            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.primary),
                            //     child: const Icon(
                            //       Icons.edit_outlined,
                            //       color: AppColors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      heightGap(10),
                      Center(
                        child: TextWidget(
                          text: value.profileData?.name ?? '',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      heightGap(8),

                      //FOR YOUR PROFILE
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(YourProfileScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.personYellow),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.yourProfile,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR EDIT OR SAVE ADDRESS
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ManageAddressScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.locationYellow),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.manageAddress,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR NOTIFICATION
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(NotificationScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.notification),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.notification,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR PAYMENT METHODS
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PaymentMethodScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.paymethod),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.paymentMethods,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR PRE-BOOKED RIDES LIST
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PreBookedRide.routeName);
                        },
                        leading: const SvgPic(image: AppImages.prebook),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.preBookedRides,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR SETTINGS
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SettingScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.setting),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.settings,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR EMERGENCY CONTACT
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(EmergencyScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.emergency),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.emergencyContact,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR HELP CENTER
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(HelpCenterScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.helpcenter),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.helpCenter,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR INVITE FRIENDS
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(InviteScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.invite),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.inviteFriends,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR PROMO SCREEN
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PromoScreen.routeName);
                        },
                        leading: const SvgPic(image: AppImages.coupon),
                        title: TextWidget(
                          text: AppLocalizations.of(context)!.coupon,
                        ),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),

                      //FOR LOGOUT
                      ListTile(
                        onTap: () {
                          bottomSheet(
                            context: context,
                            content: Column(
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
                                heightGap(20),
                                Center(
                                  child: TextWidget(
                                    text: AppLocalizations.of(context)!.logout,
                                    fontSize: 20,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Divider(height: 40),
                                Center(
                                  child: TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .areYouSureYouWantToLogOut,
                                    fontSize: 16,
                                    color: AppColors.greyHint,
                                    fontWeight: FontWeight.w500,
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
                                        text: AppLocalizations.of(context)!
                                            .cancel,
                                      ),
                                    ),
                                    widthGap(10),
                                    Expanded(
                                      child: ElevatedButtonWidget(
                                        onPressed: () async {
                                          var res = await context
                                              .read<AuthProvider>()
                                              .logOutApi(context: context);
                                          if (res == true) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                              SignInScreen.routeName,
                                              (route) => false,
                                            );
                                          }
                                        },
                                        text: AppLocalizations.of(context)!
                                            .yesLogout,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        leading: const SvgPic(image: AppImages.logout),
                        title: TextWidget(
                            text: AppLocalizations.of(context)!.logout),
                        trailing:
                            const SvgPic(image: AppImages.arrowForwardYellow),
                      ),
                      const Divider(height: 12),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Future<void> bottomSheet({
    required BuildContext? context,
    bool showBookAgainText = false,
    String? type,
    required Widget content,
    String? sessionId,
    bool navigateToPackageScreen = false,
  }) async {
    return await showModalBottomSheet<void>(
      context: context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext c, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(c).viewInsets,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: content,
              ),
            ),
          );
        });
      },
    );
  }
}
