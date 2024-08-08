import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/Providers/OnBoardingProvider/on_boarding_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import '../../CommonWidgets/custom_scaffold.dart';
import '../../CommonWidgets/text_widget.dart';
import '../../Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Auth/SignIn/sign_in_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "/onBoarding_screen";

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    context.read<OnBoardingProvider>().initializedPageController();
    super.initState();
  }

  @override
  void deactivate() {
    context.read<OnBoardingProvider>().pageController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      statusBarColor: AppColors.greyBg,
      body: Consumer<OnBoardingProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: value.pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: value.onBoardingList.length,
                  onPageChanged: (value) async {
                    await context.read<OnBoardingProvider>().changePageIndex(index: value);
                  },
                  itemBuilder: (context, index) {
                    final onBoard = value.onBoardingList[index];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Image.asset(
                                  height: deviceHeight(context) * 0.55,
                                  fit: BoxFit.fill,
                                  onBoard.image ?? '',
                                ),
                              ),
                              index!=2?
                              Positioned(
                                top: 10,
                                right: 20,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                      SignInScreen.routeName,
                                      (route) => false,
                                    );
                                  },
                                  child: TextWidget(
                                    text: AppLocalizations.of(context)!.skip,
                                    fontFamily: AppFonts.inter,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ):const SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: deviceHeight(context) * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                richText(
                                  context: context,
                                  firstText: onBoard.heading1 ?? '',
                                  secondText: onBoard.heading2 ?? '',
                                  firstStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: AppFonts.inter, color: AppColors.primary),
                                  secondStyle: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.inter,
                                  ),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  height: deviceHeight(context) * 0.03,
                                ),
                                const TextWidget(textAlign: TextAlign.center, text: ''),
                                SizedBox(
                                  height: deviceHeight(context) * 0.03,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    value.pageChangeIndex != 0
                        ? GestureDetector(
                            onTap: () {
                              context.read<OnBoardingProvider>().previousPage();
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              margin: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: AppColors.primary)),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                          )
                        : Container(
                            width: 48,
                            height: 48,
                            margin: const EdgeInsets.only(left: 16),
                          ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              value.onBoardingList.length,
                              (indexDots) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: value.pageChangeIndex == indexDots ? 15 : 11,
                                  width: value.pageChangeIndex == indexDots ? 15 : 11,
                                  decoration:
                                      BoxDecoration(color: value.pageChangeIndex == indexDots ? AppColors.primary : AppColors.primaryLight.withOpacity(0.50), borderRadius: BorderRadius.circular(10)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<OnBoardingProvider>().nextPage(context: context);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
