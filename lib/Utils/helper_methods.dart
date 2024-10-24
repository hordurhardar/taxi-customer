import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/Booking/CancelTaxiBooking/cancel_taxi_booking.dart';
import 'package:taxi/Screens/contact_request.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Widgets/contact_sheet_widget.dart';
import 'dart:ui' as ui;

import '../main.dart';
import 'app_strings.dart';

const emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

bool underDevelopemnt = true;

Future<void> closeKeyBoard({required BuildContext context}) async {
  FocusScope.of(context).unfocus();
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

SizedBox heightGap(double height) {
  return SizedBox(
    height: height,
  );
}

hideLoader(BuildContext context) {
  try {
    if (context.mounted) {
      if (shouldLogout == false) {
        Navigator.of(context).pop();
      }
    }
  } catch (e) {
    print("Error is $e");
  }
}

Widget noDataWidget() {
  return const TextWidget(text: 'No Notification Found');
}

var shouldLogout = false;
Future<void> logOut({BuildContext? context}) async {
  //context?.read<AuthProvider>().logOutApi(context: context);
  //navigatorKey!.currentContext?.read<AuthProvider>().logOutApi(context: navigatorKey!.currentContext!);
  if (shouldLogout == false) {
    try {
      if (context!.mounted) {
        sharedPrefs?.remove(AppStrings.token);
        sharedPrefs?.remove(AppStrings.isLogin);
        shouldLogout = true;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
      }
    } catch (e) {
      print("Error logout is $e");
      shouldLogout = false;
    }
  }
}

Widget richText(
    {required BuildContext context,
    required String firstText,
    required String secondText,
    TextStyle? firstStyle,
    TextStyle? secondStyle,
    TextDecoration? decoration,
    required Function() onTap}) {
  return Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      style: firstStyle ??
          const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.inter,
              color: AppColors.greyHint),
      children: [
        TextSpan(
          text: firstText,
        ),
        const WidgetSpan(child: SizedBox(width: 3)),
        TextSpan(
          text: secondText,
          style: secondStyle ??
              TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                decoration: decoration,
                fontFamily: AppFonts.inter,
              ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}

Widget shimmerEffect({required Widget widget}) {
  return Shimmer.fromColors(
    baseColor: AppColors.shimmerBaseColor,
    highlightColor: Colors.white,
    child: widget,
  );
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(
          color: AppColors.primary,
        ),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(canPop: false, child: alert);
    },
  );
}

void showSnackBar({
  BuildContext? context,
  String? message,
  bool isSuccess = true,
  int duration = 3,
}) {
  final snackBar = SnackBar(
    elevation: 6,
    duration: Duration(seconds: duration),
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        isSuccess
            ? const Icon(Icons.check, color: AppColors.white)
            : const Icon(Icons.error_outline_rounded, color: AppColors.white),
        widthGap(10),
        Flexible(
            child: TextWidget(
          text: message ?? "",
          fontFamily: AppFonts.inter,
          color: AppColors.white,
          overflow: TextOverflow.fade,
        )),
      ],
    ),
    backgroundColor: isSuccess ? AppColors.green : AppColors.red,
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}

SizedBox widthGap(double width) {
  return SizedBox(
    width: width,
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
            margin: const EdgeInsets.symmetric(horizontal: 0),
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

extension ContainerShadowExtension on Container {
  Container withShadow(
      {Color shadowColor = const Color.fromRGBO(68, 160, 169, 0.2),
      double borderRadius = 8,
      double dx = 0.5,
      double dy = 0,
      Color color = AppColors.white,
      double spreadRadius = 5,
      BoxShape? shape,
      Border? borderColor,
      double blurRadius = 5}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: borderColor,
        shape: shape ?? BoxShape.rectangle,
        borderRadius: shape != BoxShape.circle
            ? BorderRadius.circular(borderRadius)
            : null,
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            offset: Offset(dx, dy),
            color: shadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}

extension EmptySpace on num {
  SizedBox get hh => SizedBox(height: toDouble());

  SizedBox get ww => SizedBox(width: toDouble());
}

formattedDateTime(String date) {
  DateTime dateTime = DateTime.parse(date.toString());
  var formattedTime =
      DateFormat('MMM d, yyyy - h:mm a').format(dateTime.toLocal());
  return formattedTime;
}

DateTime? currentBackPressTime;

Future<bool> onWillPop() async {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    ScaffoldMessenger.of(navigatorKey!.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(navigatorKey!.currentContext!)
                  ?.pleaseClickBackAgain ??
              'Please click back again to exit',
        ),
      ),
    );
    return false;
  }
  return true;
}

Future<void> showContactListSheet({
  BuildContext? context,
  Function(ContactRequest)? onSelect,
}) async {
  await showModalBottomSheet(
    context: context!,
    showDragHandle: true,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.white,
    useSafeArea: true,
    builder: (BuildContext context) {
      return ContactSheetWidget(onSelect: onSelect);
    },
  );
}

Future<void> showCancelDialog(BuildContext context, String bookingId) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    TextWidget(
                      text:
                          '${AppLocalizations.of(context)!.cancelWithIn} 3 mins ${AppLocalizations.of(context)!.otherwisePayCancellationFee}',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
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
                            text: AppLocalizations.of(context)!.skip,
                          ),
                        ),
                        widthGap(10),
                        Expanded(
                          child: ElevatedButtonWidget(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CancelTaxiBooking(
                                    bookingId: bookingId,
                                  ),
                                ),
                              );
                            },
                            text: AppLocalizations.of(context)!.cancelRide,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]));
    },
  );
}
