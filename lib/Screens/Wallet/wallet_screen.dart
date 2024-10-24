import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Wallet/add_money_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = "/wallet_screen";

  final bool showToolbar;
  const WalletScreen({super.key, this.showToolbar = false});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          if (showToolbar) heightGap(16),
          if (showToolbar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Toolbar(
                title: AppLocalizations.of(context)!.wallet,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                        text: 'kr 0.00',
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                const SvgPic(
                                  image: AppImages.walletYellow,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            ElevatedButtonWidget(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AddMoney.routeName);
                              },
                              text: AppLocalizations.of(context)!.addMoney,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: AppLocalizations.of(context)!
                                            .moneyAddedWallet,
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const TextWidget(
                                      text: '+ kr 5000',
                                      fontSize: 16,
                                      color: AppColors.greenColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: TextWidget(
                                        text: '24 September | 7:30 AM',
                                        fontSize: 12,
                                        color: AppColors.greyText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextWidget(
                                      text:
                                          '${AppLocalizations.of(context)!.balance} kr12,000.00',
                                      fontSize: 12,
                                      color: AppColors.greyText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
