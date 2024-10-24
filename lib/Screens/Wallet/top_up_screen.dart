import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/list_tile_card_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopUpScreen extends StatefulWidget {
  static const routeName = "/topUp_screen";

  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  List timeSlot = [
    {
      'label': 'Paypal',
      'value': 1,
      'icon': AppImages.googleLogo,
    },
    {
      'label': 'Apple Pay',
      'value': 2,
      'icon': AppImages.appleLogo,
    },
    {
      'label': 'Google Pay',
      'value': 3,
      'icon': AppImages.googleLogo,
    },
  ];
  int _oneValue = -1;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.topUpWallet,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(AppImages.topUp),
                    ),
                    heightGap(8),
                    TextWidget(
                      text: AppLocalizations.of(context)!.creditDebitCard,
                      fontSize: 20,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    heightGap(8),
                    ListTileCardWidget(
                      titleText: AppLocalizations.of(context)!.addMoney,
                      leadingIconPath: AppImages.walletYellow,
                      arrowColor: AppColors.primary,
                    ),
                    heightGap(8),
                    TextWidget(
                      text: AppLocalizations.of(context)!.morePaymentOptions,
                      fontSize: 20,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    Card(
                      elevation: 5,
                      child: Column(
                          children: List.generate(timeSlot.length, (index) {
                        final item = timeSlot[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPic(image: item['icon']),
                                    widthGap(8),
                                    Expanded(
                                      child: Text(
                                        (item['label']),
                                        // style: Typographies.largeBodyStyle(),
                                      ),
                                    ),
                                    Radio(
                                        activeColor: AppColors.primary,
                                        value: item['value'],
                                        groupValue: _oneValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _oneValue = value!;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              if (index != timeSlot.length - 1) const Divider()
                            ],
                          ),
                        );
                      })),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CommonFooterWidget(
              cartItem: ElevatedButtonWidget(
                  onPressed: () {},
                  text: AppLocalizations.of(context)!.confirmPayment)),
        ],
      ),
    );
  }
}
