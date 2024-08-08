import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Providers/Type/from_auth_type.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/toolbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = "/forgot_password_screen";

  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:onWillPop,
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightGap(16),
              Toolbar(
                title: AppLocalizations.of(context)!.forgotPwd,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightGap(40),
                            Center(
                              child: TextWidget(
                                text:
                                AppLocalizations.of(context)!.title_forgot,
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            heightGap(20),
                            TextWidget(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              text: AppLocalizations.of(context)!.phoneNumber,
                            ),
                            Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.greyBorder)),
                                child: Row(
                                  children: [
                                    CountryCodePicker(
                                      onChanged: (value) {
                                        context.read<AuthProvider>().changeCountryCode(countryCode: value.dialCode.toString());
                                      },
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'IS',
                                      favorite: const ['+354'],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                      showFlagMain: false,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                      child: VerticalDivider(
                                        color: AppColors.greyBorder,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormFieldWidget(
                                        showBorder: false,
                                        keyboardType: TextInputType.number,
                                        controller: emailController,
                                        maxLength: 13,
                                        hintText: AppLocalizations.of(context)!.phoneNumber,
                                      ),
                                    ),
                                  ],
                                )),
                            heightGap(20),
                            ElevatedButtonWidget(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthProvider>().setFromType =
                                      FromAuthType.fromForgotPassword;
                                  context.read<AuthProvider>().setPhone = emailController.text;
                                  context.read<AuthProvider>().forgotPasswordApi(
                                      context: context,
                                      phone: emailController.text);
                                }
                              },
                              width: double.infinity,
                              text: AppLocalizations.of(context)!.continues,
                            ),
                            heightGap(20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
