import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(children: [
        expansionItem(title: AppLocalizations.of(context)!.customerService, icon: AppImages.customerservice,  ),
        expansionItem(title: AppLocalizations.of(context)!.whatsapp, icon: AppImages.whatsapp,  ),
        expansionItem(title: AppLocalizations.of(context)!.website, icon: AppImages.website,  ),
        expansionItem(title: AppLocalizations.of(context)!.facebook, icon: AppImages.facebook,  ),
        expansionItem(title: AppLocalizations.of(context)!.twitter, icon: AppImages.twitter,  ),
        expansionItem(title: AppLocalizations.of(context)!.instagram, icon: AppImages.instagram,  ),
      ],));
  }


  Widget expansionItem({required String title,required String icon, Widget? child }) {
    return  Card(
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        childrenPadding: const EdgeInsets.all(8),
        trailing: SvgPic(image: icon),
        iconColor: AppColors.primary,collapsedIconColor: AppColors.primary,
        title:  TextWidget(
          text: title,
          fontSize: 14,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        children: [
          child ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}
