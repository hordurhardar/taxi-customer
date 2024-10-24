// import 'dart:html';

import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Screens/Auth/ForgotPassword/forgot_password_screen.dart';
import 'package:taxi/Screens/Auth/SignUp/sign_up_screen.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Home/home_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Utils/social_login.dart';
import 'package:taxi/Utils/validations.dart';
import 'package:taxi/Widgets/svg_picture.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = "/sign_in_screen";

  SignInScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return CustomScaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.only(right: 20.0,left: 20.0,bottom: 30),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         SizedBox(
    //           height: deviceHeight(context) * 0.80,
    //           child: LayoutBuilder(
    //             builder: (context, constraints) {
    //               return SingleChildScrollView(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     heightGap(constraints.maxHeight * 0.05),
    //                     Center(
    //                       child: TextWidget(
    //                         text: AppLocalizations.of(context)!.signIn,
    //                         fontSize: 26,
    //                         color: AppColors.blackColor,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.03),
    //                     Center(
    //                       child: TextWidget(
    //                         color: AppColors.greyHint,
    //                         text: AppLocalizations.of(context)!.welcomeBack,
    //                       ),
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.04),
    //                     TextWidget(
    //                       color: AppColors.blackColor,
    //                       fontWeight: FontWeight.w500,
    //                       text: AppLocalizations.of(context)!.email,
    //                     ),
    //                     TextFormFieldWidget(
    //                       hintText: AppLocalizations.of(context)!.enterEmail,
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.02),
    //                     TextWidget(
    //                       color: AppColors.blackColor,
    //                       fontWeight: FontWeight.w500,
    //                       text: AppLocalizations.of(context)!.password,
    //                     ),
    //                     TextFormFieldWidget(
    //                       hintText: AppLocalizations.of(context)!.enterPassword,
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.02),
    //                     Align(
    //                       alignment: Alignment.centerRight,
    //                       child: TextWidget(
    //                         color: AppColors.primary,
    //                         text: AppLocalizations.of(context)!.forgotPassword,
    //                         decoration: TextDecoration.underline,
    //                         decorationColor: AppColors.primary,
    //                       ),
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.05),
    //                     ElevatedButtonWidget(
    //                       onPressed: () {
    //                         Navigator.of(context)
    //                             .pushNamedAndRemoveUntil(BottomBarScreen.routeName,(route) => false,);
    //                       },
    //                       width: double.infinity,
    //                       text: AppLocalizations.of(context)!.signIn,
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.05),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         SizedBox(width: 40, child: Divider()),
    //                         widthGap(10),
    //                         TextWidget(
    //                           color: AppColors.greyHint,
    //                           text: AppLocalizations.of(context)!.orSignUpWith,
    //                         ),
    //                         widthGap(10),
    //                         SizedBox(width: 40, child: Divider()),
    //                       ],
    //                     ),
    //                     heightGap(constraints.maxHeight * 0.05),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 60,
    //                           height: 60,
    //                           child: SvgPic(image: AppImages.appleLogo,),
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(100),
    //                               border:
    //                                   Border.all(color: AppColors.greyHint)),
    //                         ),
    //                         widthGap(10),
    //                         Container(
    //                           width: 60,
    //                           height: 60,
    //                           child: SvgPic(image: AppImages.googleLogo,),
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(100),
    //                               border:
    //                                   Border.all(color: AppColors.greyHint)),
    //                         ),
    //                         widthGap(10),
    //                         Container(
    //                           width: 60,
    //                           height: 60,
    //                           child: SvgPic(image: AppImages.facebookLogo,),
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(100),
    //                               border:
    //                                   Border.all(color: AppColors.greyHint)),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //         Center(
    //           child: richText(
    //             context: context,
    //             firstText: AppLocalizations.of(context)!.doNotHaveAnAccount,
    //             secondText: AppLocalizations.of(context)!.signUp,
    //             secondStyle: const TextStyle(
    //               color: AppColors.primary,
    //               fontSize: 16,
    //               fontWeight: FontWeight.w400,
    //               decoration: TextDecoration.underline,
    //               decorationColor: AppColors.primary,
    //               fontFamily: AppFonts.inter,
    //             ),
    //             onTap: () {
    //               Navigator.of(context)
    //                   .pushReplacementNamed(SignUpScreen.routeName);
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return WillPopScope(
      onWillPop: onWillPop,
      child: CustomScaffold(
        extendBodyBehindAppBar: true,
        statusBarColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Stack(
          //crossAxisAlignment: CrossAxisAlignment.start,
          // alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: deviceHeight(context) * 0.40,
              decoration: const BoxDecoration(color: Colors.cyan),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    AppImages.carBg,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(AppImages.car),
                ],
              ),
            ),
            Positioned(
              top: deviceHeight(context) * 0.38,
              left: 0,
              right: 0,
              child: Container(
                height: deviceHeight(context) * 0.60,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          16,
                        ),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightGap(16),
                          Center(
                            child: TextWidget(
                              text: AppLocalizations.of(context)!.signIn,
                              fontSize: 26,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          heightGap(10),
                          Center(
                            child: TextWidget(
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyHint),
                              color: AppColors.greyHint,
                              text: AppLocalizations.of(context)!.welcomeBack,
                            ),
                          ),
                          // heightGap(10),
                          // TextWidget(
                          //   color: AppColors.blackColor,
                          //   fontWeight: FontWeight.w500,
                          //   text: AppLocalizations.of(context)!.phoneNumber,
                          // ),
                          // Container(
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(8),
                          //         border:
                          //             Border.all(color: AppColors.greyBorder)),
                          //     child: Row(
                          //       children: [
                          //         CountryCodePicker(
                          //           onChanged: (value) {
                          //             context
                          //                 .read<AuthProvider>()
                          //                 .changeCountryCode(
                          //                     countryCode:
                          //                         value.dialCode.toString());
                          //           },
                          //           // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          //           initialSelection: 'IS',
                          //           favorite: const ['+354'],
                          //           // optional. Shows only country name and flag
                          //           showCountryOnly: false,
                          //           // optional. Shows only country name and flag when popup is closed.
                          //           showOnlyCountryWhenClosed: false,
                          //           // optional. aligns the flag and the Text left
                          //           alignLeft: false,
                          //           showFlagMain: false,
                          //         ),
                          //         const SizedBox(
                          //           height: 25,
                          //           child: VerticalDivider(
                          //             color: AppColors.greyBorder,
                          //           ),
                          //         ),
                          //         Expanded(
                          //           child: TextFormFieldWidget(
                          //             showBorder: false,
                          //             keyboardType: TextInputType.number,
                          //             controller: emailController,
                          //             maxLength: 13,
                          //             hintText: AppLocalizations.of(context)!
                          //                 .phoneNumber,
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          // // TextFormFieldWidget(
                          // //   hintText: AppLocalizations.of(context)!.enterEmail,
                          // //   controller: emailController,
                          // //   keyboardType: TextInputType.emailAddress,
                          // //   validator: (value) => Validations.instance.emailValidation(value!),
                          // // ),
                          heightGap(10),
                          TextWidget(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                            text: 'Email',
                          ),
                          Consumer<AuthProvider>(
                            builder: (context, value, child) {
                              return TextFormFieldWidget(
                                hintText: 'Please enter email',
                                controller: emailController,
                                isPassword: false,
                                // obscureText: value.passwordObSecureLogin,
                                onVisibilityIconTap: () {
                                  value.changeObSecureForLogin();
                                },
                                validator: (value) => Validations.instance
                                    .emailValidation(value!, context),
                              );
                            },
                          ),
                          heightGap(10),
                          TextWidget(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                            text: AppLocalizations.of(context)!.password,
                          ),
                          Consumer<AuthProvider>(
                            builder: (context, value, child) {
                              return TextFormFieldWidget(
                                hintText:
                                    AppLocalizations.of(context)!.enterPassword,
                                controller: passwordController,
                                isPassword: true,
                                obscureText: value.passwordObSecureLogin,
                                onVisibilityIconTap: () {
                                  value.changeObSecureForLogin();
                                },
                                validator: (value) => Validations.instance
                                    .passwordValidation(value!, context),
                              );
                            },
                          ),
                          heightGap(10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordScreen.routeName);
                              },
                              child: TextWidget(
                                color: AppColors.primary,
                                text: AppLocalizations.of(context)!
                                    .forgotPassword,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          ),
                          heightGap(10),
                          ElevatedButtonWidget(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (builder) =>
                              //             const BottomBarScreen()));
                              context.read<AuthProvider>().loginApi(
                                    context: context,
                                    password: passwordController.text,
                                    email: emailController.text,
                                  );
                              // FocusManager.instance.primaryFocus?.unfocus();
                              // if (formKey.currentState!.validate()) {
                              //   context.read<AuthProvider>().loginApi(
                              //         context: context,
                              //         password: passwordController.text,
                              //         email: emailController.text,
                              //       );
                              // }
                            },
                            width: double.infinity,
                            text: AppLocalizations.of(context)!.signIn,
                          ),
                          heightGap(10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const SizedBox(width: 40, child: Divider()),
                          //     widthGap(10),
                          //     TextWidget(
                          //       color: AppColors.greyHint,
                          //       text: AppLocalizations.of(context)!.orSignUpWith,
                          //     ),
                          //     widthGap(10),
                          //     const SizedBox(width: 40, child: Divider()),
                          //   ],
                          // ),
                          heightGap(10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Platform.isIOS
                          //         ? socialContainer(
                          //             image: AppImages.appleLogo,
                          //             onTap: () {},
                          //           )
                          //         : SizedBox(),
                          //     widthGap(10),
                          //     socialContainer(
                          //       image: AppImages.googleLogo,
                          //       onTap: () async {
                          //         final loginResult =
                          //             await SocialLogin.instance.googleLogin();

                          //         if (loginResult.status == true) {
                          //           log("loginresponse=====>${loginResult.status}");
                          //           final jsonData = {
                          //             "email": loginResult.emailAddress ?? "",
                          //             "name": loginResult.name ?? "",
                          //             "type": "User",
                          //             "loginType": loginResult.socialType ?? "",
                          //             "deviceToken": await FirebaseMessaging
                          //                 .instance
                          //                 .getToken(),
                          //             "socialId": loginResult.socialId
                          //           };
                          //           log("loginresponse=====>${jsonData.toString()}");
                          //           if (kDebugMode) {
                          //             print("$jsonData");
                          //           }
                          //           await context
                          //               .read<AuthProvider>()
                          //               .socialLoginApi(
                          //                   context: context,
                          //                   jsonData: jsonData);
                          //         } else {
                          //           log("message");
                          //         }
                          //       },
                          //     ),
                          //     widthGap(10),
                          //     socialContainer(
                          //       image: AppImages.facebookLogo,
                          //       onTap: () {},
                          //     ),
                          //   ],
                          // ),
                          heightGap(10),
                          Center(
                            child: richText(
                              context: context,
                              firstText: AppLocalizations.of(context)!
                                  .doNotHaveAnAccount,
                              secondText: AppLocalizations.of(context)!.signUp,
                              secondStyle: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                                fontFamily: AppFonts.inter,
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SignUpScreen.routeName);
                              },
                            ),
                          ),
                          heightGap(200),
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
    );
  }

  Widget socialContainer({required String image, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.greyHint)),
        child: SvgPic(
          image: image,
        ),
      ),
    );
  }
}
