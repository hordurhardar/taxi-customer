import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/ProfileProvider/profile_provider.dart';
import 'package:taxi/Screens/Home/Receipt/receipt_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoyaltyPointsScreen extends StatefulWidget {
  static const routeName = "/loyaltyPoints_screen";

  const LoyaltyPointsScreen({super.key});

  @override
  State<LoyaltyPointsScreen> createState() => _LoyaltyPointsScreenState();
}

class _LoyaltyPointsScreenState extends State<LoyaltyPointsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileProvider>().getProfileApi(context: context);
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacementNamed(ReceiptScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.addCard,
            ),
          ),
          heightGap(deviceHeight(context) * 0.10),
          Expanded(
            child: InkWell(
              onTap: () {
                //  Navigator.of(context).pushNamed(RateDriverScreen.routeName);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.celebrate),
                  const TextWidget(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    text: 'Congratulations',
                  ),
                  // const TextWidget(
                  //   color: AppColors.greyHint,
                  //   fontWeight: FontWeight.w500,
                  //   fontSize: 18,
                  //   text: 'You Win 40 Loyalty Points',
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
