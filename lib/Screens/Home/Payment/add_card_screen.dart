import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';

class AddCardScreen extends StatefulWidget {
  static const routeName = "/addCard_screen";

  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.addCard,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppImages.visaCard),
                    heightGap(16),
                    TextWidget(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      text: AppLocalizations.of(context)!.cardHolderName,
                    ),
                    TextFormFieldWidget(
                      hintText: AppLocalizations.of(context)!.name,
                    ),
                    heightGap(16),
                    TextWidget(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      text: AppLocalizations.of(context)!.cardNumber,
                    ),
                    TextFormFieldWidget(
                      hintText: AppLocalizations.of(context)!.enterHere,
                    ),
                    heightGap(16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                text: AppLocalizations.of(context)!.expiryDate,
                              ),
                              heightGap(4),
                              const TextFormFieldWidget(),
                            ],
                          ),
                        ),
                        widthGap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                text: AppLocalizations.of(context)!.cvv,
                              ),
                              heightGap(4),
                              const TextFormFieldWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          activeColor: AppColors.primary,
                          onChanged: (value) {},
                        ),
                        TextWidget(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          text: AppLocalizations.of(context)!.saveCard,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CommonFooterWidget(
              cartItem: ElevatedButtonWidget(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: AppLocalizations.of(context)!.addCard,
          )),
        ],
      ),
    );
  }
}
