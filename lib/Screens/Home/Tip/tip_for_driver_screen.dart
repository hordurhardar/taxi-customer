import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/TipProvider/tip_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipForDriverScreen extends StatefulWidget {
  static const routeName = "/tipForDriver_screen";

  const TipForDriverScreen({super.key});

  @override
  State<TipForDriverScreen> createState() => _TipForDriverScreenState();
}

class _TipForDriverScreenState extends State<TipForDriverScreen> {
  final form = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<TipProvider>().getTipAmountApi(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tipProvider = context.read<TipProvider>();
    return CustomScaffold(
      body: Column(
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.tipForDriver,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.primary),
                      ),
                    ),
                    heightGap(10),
                    const Center(
                      child: TextWidget(
                        text: 'Jenny Wilson',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    heightGap(8),
                    const Center(
                      child: TextWidget(
                        text: 'Hyundai Verna',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyHint,
                      ),
                    ),
                    heightGap(16),
                    Center(
                      child: TextWidget(
                        text: '${AppLocalizations.of(context)!.youRated} Jenny',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    Center(
                      child: TextWidget(
                        text: '5 ${AppLocalizations.of(context)!.star}',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    Center(
                      child: TextWidget(
                        text:
                            '${AppLocalizations.of(context)!.doYouWantToAddTipFor} Jenny ?',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyHint,
                      ),
                    ),
                    const Divider(
                      height: 40,
                    ),
                    Center(
                      child: TextWidget(
                        text:
                            '${AppLocalizations.of(context)!.addTipFor} Jenny',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                    heightGap(10),
                    Consumer<TipProvider>(
                      builder: (context, value, child) {
                        return GridView.builder(
                          itemCount: value.tipAmountList?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1 / 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            final tip = value.tipAmountList?[index];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: AppColors.greyBorder)),
                              child: Center(
                                  child: TextWidget(
                                text: 'US ${tip?.amount.toString()}',
                              )),
                            );
                          },
                        );
                      },
                    ),
                    heightGap(10),
                    Center(
                      child: InkWell(
                        onTap: () {
                          bottomSheet(
                            context: context,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.greyBorder,
                                    ),
                                  ),
                                ),
                                heightGap(20),
                                Center(
                                  child: TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .enterCustomAmount,
                                    fontSize: 20,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                heightGap(20),
                                Form(
                                  key: form,
                                  child: TextFormFieldWidget(
                                    hintText: AppLocalizations.of(context)!
                                        .enterCustomAmount,
                                    keyboardType: TextInputType.number,
                                    controller: tipProvider.amountController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .enterAmount;
                                      }
                                      return null;
                                    },
                                  ),
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
                                        text: AppLocalizations.of(context)!
                                            .cancel,
                                      ),
                                    ),
                                    widthGap(10),
                                    Expanded(
                                      child: ElevatedButtonWidget(
                                        onPressed: ()async {
                                          if(form.currentState!.validate()){

                                            await tipProvider.addManualTipAmount(tipAmount: double.parse(tipProvider.amountController.text));
                                         Navigator.of(context).pop();
                                          }
                                        },
                                        text: AppLocalizations.of(context)!
                                            .confirm,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: TextWidget(
                          text: AppLocalizations.of(context)!.enterCustomAmount,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CommonFooterWidget(
              cartItem: Row(
            children: [
              Expanded(
                child: ElevatedButtonWidget(
                  elevation: 0,
                  primary: AppColors.greyStatusBar,
                  textColor: AppColors.primary,
                  onPressed: () {},
                  text: AppLocalizations.of(context)!.noThanks,
                ),
              ),
              widthGap(10),
              Expanded(
                child: ElevatedButtonWidget(
                  onPressed: () {
                    //TODO: make dynamic here
                    tipProvider.payTipApi(context: context, amount: 'amount', driverId: 'driverId');
                  },
                  text: AppLocalizations.of(context)!.payTip,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
