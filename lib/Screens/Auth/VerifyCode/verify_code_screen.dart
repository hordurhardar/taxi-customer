import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Providers/Type/from_auth_type.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';

class VerifyCodeScreen extends StatefulWidget {
  static const routeName = "/verifyCode_screen";

  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final otpController = TextEditingController();
  bool enableResend = false;
  late Timer _timer;
  int _start = 60;
  bool enableOtpField = false;

  void startTimer() {
    _start = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    enableOtpField = false;
  }

  @override
  void dispose() {
    _timer.cancel();
    // otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightGap(deviceHeight(context) * 0.10),
              Center(
                child: TextWidget(
                  text: AppLocalizations.of(context)!.verifyCode,
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
                  text: AppLocalizations.of(context)!
                      .pleaseEnterTheCodeWeJustSentToEmail,
                ),
              ),
              heightGap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                    text: context.read<AuthProvider>().countryCode,
                  ),
                  const TextWidget(
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                    text: "-",
                  ),
                  TextWidget(
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                    text: context.read<AuthProvider>().getPhone,
                  ),
                ],
              ),
              heightGap(30),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                controller: otpController,
                animationType: AnimationType.fade,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Otp';
                  }
                  return null;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 56,
                  fieldWidth: 75,
                  borderWidth: 1,
                  activeBorderWidth: 1,
                  disabledBorderWidth: 1,
                  errorBorderWidth: 1,
                  inactiveBorderWidth: 1,
                  selectedBorderWidth: 1,
                  errorBorderColor: AppColors.greyBg,
                  activeFillColor: Colors.white,
                  activeColor: AppColors.greyBg,
                  selectedColor: AppColors.greyBg,
                  disabledColor: AppColors.greyBg,
                  inactiveColor: AppColors.greyBg,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                cursorColor: AppColors.black,
                enableActiveFill: true,
                onCompleted: (v) {
                  if (context.read<AuthProvider>().getFromType ==
                      FromAuthType.fromForgotPassword) {
                    context.read<AuthProvider>().verifyOtpApi(
                        context: context,
                        otp: otpController.text,
                        phone: context.read<AuthProvider>().getPhone);
                    return;
                  }
                  if (context.read<AuthProvider>().getFromType ==
                      FromAuthType.fromProfile) {
                    context.read<AuthProvider>().verifyOtpApiProfile(
                        context: context, otp: otpController.text);
                    return;
                  }
                  context.read<AuthProvider>().verifyOtpApiSignUp(
                      email: context.read<AuthProvider>().getEmail,
                      context: context,
                      otp: otpController.text,
                      phone: context.read<AuthProvider>().getPhone);
                },
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),
              heightGap(10),
              Center(
                child: TextWidget(
                  color: AppColors.greyHint,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  text: AppLocalizations.of(context)!.didNotReceiveOTP,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_start == 0 || _start == 60) {
                    context.read<AuthProvider>().resendOtp(context: context);
                    startTimer();
                  }
                },
                child: Center(
                  child: TextWidget(
                    color: _start == 0 || _start == 60
                        ? Colors.blue
                        : AppColors.greyHint,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.greyHint,
                    fontSize: 15,
                    text:
                        "${AppLocalizations.of(context)!.resendCode} 00:$_start",
                  ),
                ),
              ),
              heightGap(30),
              ElevatedButtonWidget(
                onPressed: () {
                  if (otpController.text.length < 4) {
                    showSnackBar(
                        context: context,
                        message: AppLocalizations.of(context)!.enterOtpFirst,
                        isSuccess: false);
                    return;
                  }
                  if (context.read<AuthProvider>().getFromType ==
                      FromAuthType.fromForgotPassword) {
                    log('verify otp from forgot-pass');
                    context.read<AuthProvider>().verifyOtpApi(
                        context: context,
                        otp: otpController.text,
                        phone: context.read<AuthProvider>().getPhone);
                    return;
                  } else if (context.read<AuthProvider>().getFromType ==
                      FromAuthType.fromProfile) {
                    log('verify otp from profile');
                    context.read<AuthProvider>().verifyOtpApiProfile(
                        context: context, otp: otpController.text);
                  }
                  log('verify otp from general');
                  context.read<AuthProvider>().verifyOtpApiSignUp(
                      email: context.read<AuthProvider>().getEmail,
                      context: context,
                      otp: otpController.text,
                      phone: context.read<AuthProvider>().getPhone);
                },
                width: double.infinity,
                text: AppLocalizations.of(context)!.verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class VerifyCodeScreen extends StatelessWidget {
//   static const routeName = "/verifyCode_screen";
//
//   VerifyCodeScreen({super.key});
//
//   final otpController = TextEditingController();
//   bool enableResend = false;
//   late Timer _timer;
//   int _start = 60;
//   void startTimer() {
//     _start = 60;
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//           (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     otpController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(right: 20.0, left: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             heightGap(
//               deviceHeight(context) * 0.10,
//             ),
//             Center(
//               child: TextWidget(
//                 text: AppLocalizations.of(context)!.verifyCode,
//                 fontSize: 26,
//                 color: AppColors.blackColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             heightGap(10),
//             Center(
//               child: TextWidget(
//                 color: AppColors.greyHint,
//                 textAlign: TextAlign.center,
//                 text: AppLocalizations.of(context)!
//                     .pleaseEnterTheCodeWeJustSentToEmail,
//               ),
//             ),
//              Center(
//               child: TextWidget(
//                 color: AppColors.primary,
//                 textAlign: TextAlign.center,
//                 text: context.read<AuthProvider>().getEmail??"",
//               ),
//             ),
//             heightGap(30),
//             PinCodeTextField(
//               length: 4,
//               obscureText: false,
//               controller: otpController,
//               animationType: AnimationType.fade,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter Otp';
//                 }
//                 return null;
//               },
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.box,
//                 borderRadius: BorderRadius.circular(5),
//                 fieldHeight: 56,
//                 fieldWidth: 75,
//                 borderWidth: 1,
//                 activeBorderWidth: 1,
//                 disabledBorderWidth: 1,
//                 errorBorderWidth: 1,
//                 inactiveBorderWidth: 1,
//                 selectedBorderWidth: 1,
//                 errorBorderColor: AppColors.greyBg,
//                 activeFillColor: Colors.white,
//                 activeColor: AppColors.greyBg,
//                 selectedColor: AppColors.greyBg,
//                 disabledColor: AppColors.greyBg,
//                 inactiveColor: AppColors.greyBg,
//                 inactiveFillColor: Colors.white,
//                 selectedFillColor: Colors.white,
//               ),
//               keyboardType: TextInputType.number,
//               animationDuration: const Duration(milliseconds: 300),
//               backgroundColor: Colors.transparent,
//               cursorColor: AppColors.black,
//               enableActiveFill: true,
//               onCompleted: (v) {
//                 if (context.read<AuthProvider>().getFromType ==
//                     FromAuthType.fromForgotPassword) {
//                   context.read<AuthProvider>().verifyOtpApi(
//                       context: context,
//                       otp: otpController.text,
//                       email: context.read<AuthProvider>().getEmail);
//                   return;
//                 }
//                 context.read<AuthProvider>().verifyOtpApiSignUp(
//                     context: context,
//                     otp: otpController.text,
//                     email: context.read<AuthProvider>().getEmail);
//               },
//               onChanged: (value) {},
//               beforeTextPaste: (text) {
//                 print("Allowing to paste $text");
//                 //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                 //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                 return true;
//               },
//               appContext: context,
//             ),
//             heightGap(10),
//             Center(
//               child: TextWidget(
//                 color: AppColors.greyHint,
//                 textAlign: TextAlign.center,
//                 fontWeight: FontWeight.w500,
//                 text: AppLocalizations.of(context)!.didNotReceiveOTP,
//               ),
//             ),
//             Center(
//               child: TextWidget(
//                 color: AppColors.greyHint,
//                 textAlign: TextAlign.center,
//                 fontWeight: FontWeight.w500,
//                 decoration: TextDecoration.underline,
//                 decorationColor: AppColors.greyHint,
//                 fontSize: 15,
//                 text: AppLocalizations.of(context)!.resendCode,
//               ),
//             ),
//             heightGap(30),
//             ElevatedButtonWidget(
//               onPressed: () {
//                 if (otpController.text.length < 4) {
//                   showSnackBar(
//                       context: context,
//                       message: AppLocalizations.of(context)!.enterOtpFirst,
//                       isSuccess: false);
//                   return;
//                 }
//                 if (context.read<AuthProvider>().getFromType ==
//                     FromAuthType.fromForgotPassword) {
//                   context.read<AuthProvider>().verifyOtpApi(
//                       context: context,
//                       otp: otpController.text,
//                       email: context.read<AuthProvider>().getEmail);
//                   return;
//                 }
//                 context.read<AuthProvider>().verifyOtpApiSignUp(
//                     context: context,
//                     otp: otpController.text,
//                     email: context.read<AuthProvider>().getEmail);
//               },
//               width: double.infinity,
//               text: AppLocalizations.of(context)!.verify,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
