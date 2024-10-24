import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/Chat/chat_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/raw_item_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class DriverAboutWidget extends StatelessWidget {
  const DriverAboutWidget({super.key});
  static const routeName = "/Chat-screen";
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<DriverProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: AppLocalizations.of(context)!.about,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                heightGap(8),
                TextWidget(
                  text: value.driverData?.about ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyHint,
                ),
                heightGap(12),
                TextWidget(
                  text: AppLocalizations.of(context)!.driverContact,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                heightGap(8),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                        imageUrl:
                            "$IMAGE_URL${value.driverData != null ? value.driverData?.image : ""}",
                        placeholder: (context, url) {
                          return SvgPicture.asset(AppImages.personGrey);
                        },
                        errorWidget: (context, url, error) {
                          return SvgPicture.asset(AppImages.personGrey);
                        },
                      ),
                    ),
                    widthGap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: value.driverData?.name ?? '',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          TextWidget(
                            text: value.driverData?.address ?? '',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyHint,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(ChatScreen.routeName);
                        },
                        child: const SvgPic(image: AppImages.chatYellowRound)),
                    widthGap(10),
                    InkWell(
                        onTap: () {
                          makingPhoneCall(
                              number: value.driverData?.contact ?? '');
                        },
                        child: const SvgPic(image: AppImages.phoneYellowRound)),
                  ],
                ),
                heightGap(24),
                TextWidget(
                  text: AppLocalizations.of(context)!.carDetails,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                value.driverData?.carDetails?.carModel == ''
                    ? Text('')
                    : RawItemWidget(
                        title: AppLocalizations.of(context)!.carModel,
                        value: value.driverData?.carDetails?.carModel ?? ''),
                value.driverData?.carDetails?.carModel == ''
                    ? Text('')
                    : RawItemWidget(
                        title: AppLocalizations.of(context)!.carNumber,
                        value: value.driverData?.carDetails?.carNumber ?? ''),
                value.driverData?.carDetails?.carColor == ''
                    ? Text('')
                    : RawItemWidget(
                        title: AppLocalizations.of(context)!.carColor,
                        value: value.driverData?.carDetails?.carColor ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }

  makingPhoneCall({required String number}) async {
    var url = Uri.parse("tel:$number");
    if (await url_launcher.canLaunchUrl(url)) {
      await url_launcher.launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
