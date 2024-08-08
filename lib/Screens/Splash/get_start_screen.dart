import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/OnBording/on_boarding_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/main.dart';

class GetStartScreen extends StatefulWidget {
  static const routeName = "/getStartScreen";
  const GetStartScreen({super.key});

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {

  @override
  void initState() {
    //context.read<ContactProvider>().askPermissions(context: context);
    super.initState();

    setFirstTime();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      statusBarColor: AppColors.greyBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  height: deviceHeight(context) * 0.55,
                  fit: BoxFit.fill,
                  AppImages.girl,
                ),
              ),
            ),
            SizedBox(height: deviceHeight(context) * 0.03,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  richText(
                    context: context,
                    firstText: AppLocalizations.of(context)!.welcomeToYour,
                    secondText:
                    AppLocalizations.of(context)!.ultimateTransportationSolution,
                    firstStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.inter,
                        color: AppColors.black),
                    secondStyle: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: deviceHeight(context) * 0.03,),
                  TextWidget(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.greyHint,
                    textAlign: TextAlign.center,
                      text:
                      AppLocalizations.of(context)!.promotional_text),
                  SizedBox(height: deviceHeight(context) * 0.03,),
                  ElevatedButtonWidget(
                    onPressed: () {

                      Navigator.of(context)
                          .pushReplacementNamed(OnBoardingScreen.routeName);
                    },
                    width: double.infinity,
                    text: AppLocalizations.of(context)!.letsGetStarted,
                  ),
                  SizedBox(height: deviceHeight(context) * 0.03,),
                  richText(
                    secondStyle: const TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                    context: context,
                    firstText: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                    secondText: AppLocalizations.of(context)!.signIn,
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignInScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setFirstTime() async {
    await sharedPrefs?.setBool(AppStrings.isFirstTime, false);
  }
}
