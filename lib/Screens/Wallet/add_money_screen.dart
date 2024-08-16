import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddMoney extends StatelessWidget {
  static const routeName = "/addMoney_screen";

  const AddMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.addMoney,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(AppImages.taxiImage),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.yellowLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: AppLocalizations.of(context)!
                                            .walletBalance,
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      const TextWidget(
                                        text: '\$ 12.000',
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: SvgPic(
                                        image: AppImages.walletYellow,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ],
                            ),
                            heightGap(16),
                            TextFormFieldWidget(
                              fillColor: AppColors.white,
                              hintText:
                                  AppLocalizations.of(context)!.enterAmount,
                              prefixText: '\$',
                            ),
                            heightGap(16),
                            ElevatedButtonWidget(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: AppLocalizations.of(context)!.addMoney,
                            ),
                          ],
                        ),
                      ),
                    ),
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
