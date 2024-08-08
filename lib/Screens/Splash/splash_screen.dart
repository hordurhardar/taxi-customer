import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Splash/get_start_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/main.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      statusBarColor: AppColors.white,
      body: Container(
        color: AppColors.white,
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: SvgPic(
            image: AppImages.logoTaxi,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final isLoggedIn = sharedPrefs?.getBool(AppStrings.isLogin) ?? false;
        if (isLoggedIn) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            BottomBarScreen.routeName,
            (route) => false,
          );
        } else {
          final isFirstTime = sharedPrefs?.getBool(AppStrings.isFirstTime) ?? true;
          if(isFirstTime) {
            Navigator.of(context).pushReplacementNamed(
                GetStartScreen.routeName);
          } else {
            Navigator.of(context).pushReplacementNamed(
                SignInScreen.routeName);
          }
        }
      },
    );
    super.initState();
  }
}
