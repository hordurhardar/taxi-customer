import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/toolbar.dart';
import '../../../Providers/HelpCenterProvider/help_center_provider.dart';

class ContentScreen extends StatefulWidget {
  static const routeName = "/content_screen";

  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  void initState() {
    context
        .read<HelpCenterProvider>()
        .getContentApi(context: context, slug: "terms-conditions");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<HelpCenterProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      heightGap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Toolbar(
                          title: AppLocalizations.of(context)!.termsCondition,
                          showCount: false,
                        ),
                      ),
                      // TODO: add list here
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Html(data: value.content?[0].description ?? ""),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: value.termsConditionCheck,
                            onChanged: (val) {
                              print(
                                  "Country Code ${context.read<AuthProvider>().countryCode}");
                              value.updateTermsConditionCheckBoxValue(
                                  value: val!);
                            },
                            checkColor: AppColors.black,
                            activeColor: AppColors.primary,
                          ),
                          richText(
                            context: context,
                            firstText:
                                "${AppLocalizations.of(context)!.agreeWith} ${AppLocalizations.of(context)!.termsCondition}",
                            secondText: "",
                            // secondStyle: const TextStyle(
                            //   color: AppColors.primary,
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.w400,
                            //   decoration: TextDecoration.underline,
                            //   decorationColor: AppColors.primary,
                            //   fontFamily: AppFonts.inter,
                            // ),
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushNamed(
                              //     ContentScreen.routeName);
                            },
                          )
                        ],
                      ),
                      heightGap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ElevatedButtonWidget(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (value.termsConditionCheck) {
                              print('yes');
                              context
                                  .read<AuthProvider>()
                                  .registerApi(context: context);
                            } else {
                              showSnackBar(
                                  context: context,
                                  message: AppLocalizations.of(context)!
                                      .pleaseSelectTermsAndCondition,
                                  isSuccess: false);
                            }
                          },
                          width: double.infinity,
                          text: AppLocalizations.of(context)!.signUp,
                        ),
                      ),

                      heightGap(20),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
