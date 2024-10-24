import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Screens/Home/BookRide/book_for_self_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/shimmer_coupan_card.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PromoScreen extends StatefulWidget {
  static const routeName = "/promo_screen";

  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  final promoController = TextEditingController();

  @override
  void initState() {
    context.read<BookRideProvider>().getPromoCodeApi(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.promo,
            ),
          ),
          heightGap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextWidget(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              text: AppLocalizations.of(context)!.promoForYou,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<BookRideProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.isLoading ? 4 : value.promoList?.length,
                    itemBuilder: (context, index) {
                      final promo = value.promoList?[index];
                      return value.isLoading
                          ? const ShimmerCouponCard()
                          : Card(
                              child: CouponCard(
                                height: deviceHeight(context) * 0.25,
                                curvePosition: deviceHeight(context) * 0.12,
                                curveRadius: 30,
                                backgroundColor: Colors.white,
                                borderRadius: 10,
                                border: const BorderSide(
                                  color: AppColors.greyBorder,
                                ),
                                firstChild: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: promo?.title ?? '',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      TextWidget(
                                        text: promo?.description ?? '',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      TextWidget(
                                        text:
                                            'Get ${promo?.percentage ?? ""}% OFF',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                secondChild: SizedBox(
                                  width: double.maxFinite,
                                  // padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 42),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 48,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                padding: WidgetStateProperty
                                                    .all<EdgeInsetsGeometry?>(
                                                        EdgeInsets.zero),
                                                shape: WidgetStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            2))),
                                                backgroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        AppColors.primary)),
                                            onPressed: () async {
                                              print('prmo applied');

                                              SharedPreferences sp =
                                                  await SharedPreferences
                                                      .getInstance();

                                              setState(() {});
                                              await context
                                                  .read<BookRideProvider>()
                                                  .selectCoupon(
                                                      id: promo?.id
                                                              .toString() ??
                                                          '');
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      promo?.promoCode ?? ''));
                                              await sp.setBool(
                                                  'promoCodeApplied', true);
                                              showSnackBar(
                                                  context: context,
                                                  message: AppLocalizations.of(
                                                          context)!
                                                      .promoApplied,
                                                  isSuccess: true);
                                              Navigator.of(context).pop();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .copyCode,
                                                    color: AppColors.white,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          ),
          CommonFooterWidget(
              cartItem: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormFieldWidget(
                borderRadius: 22,
                controller: promoController,
                hintText: AppLocalizations.of(context)!.promo,
                suffixIcon: ElevatedButtonWidget(
                  onPressed: () async {
                    if (promoController.text.isEmpty) {
                      showSnackBar(
                          context: context,
                          message: 'Please Enter Code First',
                          isSuccess: false);
                      return;
                    }
                    await context.read<BookRideProvider>().applyPromoCode(
                        context: context,
                        couponId: context
                            .read<BookRideProvider>()
                            .couponId
                            .toString());
                    Navigator.of(context)
                        .pushNamed(BookForSelfScreen.routeName);
                  },
                  text: AppLocalizations.of(context)!.apply,
                ),
              ),
              heightGap(8),
              ElevatedButtonWidget(
                onPressed: () {
                  //  Navigator.of(context).pushNamed(BookForSelfScreen.routeName);
                  Navigator.of(context).pop();
                },
                text: AppLocalizations.of(context)!.continues,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
