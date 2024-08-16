import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/toolbar.dart';

class EnableLocationAccess extends StatelessWidget {
  static const routeName = "/enableLocation_screen";

  const EnableLocationAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      heightGap(
                        16,
                      ),
                      const Toolbar(),
                      heightGap(
                        deviceHeight(context) * 0.02,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.greyBorder),
                            child: const Icon(
                              Icons.location_on_sharp,
                              size: 50,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Center(
                              child: TextWidget(
                                text: AppLocalizations.of(context)!
                                    .enableLocationAccess,
                                fontSize: 26,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            heightGap(10),
                            Center(
                              child: TextWidget(
                                color: AppColors.greyHint,
                                textAlign: TextAlign.center,
                                fontSize: 13,
                                text: AppLocalizations.of(context)!
                                    .toEnsureASeamlessAndEfficientExperience,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 9), 
                ),
              ],
            ),
            child: Card(
              color: AppColors.white,
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    ElevatedButtonWidget(
                      onPressed: () {
                        context
                            .read<AuthProvider>()
                            .getCurrentPosition(context: context);

                        /*  Navigator.of(context)
                            .pushNamed(NewPasswordScreen.routeName);*/
                      },
                      width: double.infinity,
                      text: AppLocalizations.of(context)!.allowLocationAccess,
                    ),
                    // heightGap(20),
                    // InkWell(
                    //   onTap: () {
                    //     if (context.read<AuthProvider>().getFromType ==
                    //         FromAuthType.fromSignUp) {
                    //       showSnackBar(
                    //           context: context,
                    //           message: AppLocalizations.of(context)!
                    //               .yourRegistrationIsConfirmed,
                    //           isSuccess: true);
                    //       Navigator.of(context).pushNamedAndRemoveUntil(
                    //           SignInScreen.routeName, (route) => false);
                    //     } else {
                    //       Navigator.of(context).pushNamedAndRemoveUntil(
                    //           BottomBarScreen.routeName, (route) => false);
                    //     }
                    //   },
                    //   child: TextWidget(
                    //     color: AppColors.primary,
                    //     fontWeight: FontWeight.w500,
                    //     text: AppLocalizations.of(context)!.maybeLater,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
