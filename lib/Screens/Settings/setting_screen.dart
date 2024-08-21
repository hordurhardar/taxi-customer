import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/Settings/ManageAddress/manage_address_screen.dart';
import 'package:taxi/Screens/Settings/password_manager_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:taxi/main.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = "/setting_screen";

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.settings,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: const SvgPic(image: AppImages.notificationsetting),
                  title: TextWidget(
                    text: AppLocalizations.of(context)!.notificationSettings,
                  ),
                  trailing: const SvgPic(image: AppImages.arrowForwardYellow),
                ),
                const Divider(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PasswordManagerScreen.routeName);
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const SvgPic(image: AppImages.key),
                  title: TextWidget(
                    text: AppLocalizations.of(context)!.passwordManager,
                  ),
                  trailing: const SvgPic(image: AppImages.arrowForwardYellow),
                ),
                const Divider(
                  height: 12,
                ),
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
                              text: AppLocalizations.of(context)!.deleteAccount,
                              fontSize: 20,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(
                            height: 40,
                          ),
                          Center(
                            child: TextWidget(
                              text: AppLocalizations.of(context)!
                                  .areYouSureYouWantToDeleteTheAccount,
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
                                  text: AppLocalizations.of(context)!.cancel,
                                ),
                              ),
                              widthGap(10),
                              Expanded(
                                child: ElevatedButtonWidget(
                                  onPressed: () async {
                                    await context
                                        .read<AuthProvider>()
                                        .deleteAccountApi(context: context);
                                    sharedPrefs?.remove(AppStrings.token);
                                    sharedPrefs?.remove(AppStrings.isLogin);
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      SignInScreen.routeName,
                                      (route) => false,
                                    );
                                  },
                                  text: AppLocalizations.of(context)!.yesDelete,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const SvgPic(image: AppImages.deleteIcon),
                  title: TextWidget(
                    text: AppLocalizations.of(context)!.deleteAccount,
                  ),
                  trailing: const SvgPic(image: AppImages.arrowForwardYellow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
