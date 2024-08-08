import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';

import '../../../Utils/validations.dart';

class NewPasswordScreen extends StatelessWidget {
  static const routeName = "/newPassword_screen";

  NewPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightGap(
                16,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: AppColors.greyHint)),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.greyHint,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
              heightGap(
                deviceHeight(context) * 0.01,
              ),
              Center(
                child: TextWidget(
                  text: AppLocalizations.of(context)!.newPassword,
                  fontSize: 26,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              heightGap(20),
              Center(
                child: TextWidget(
                  color: AppColors.greyHint,
                  textAlign: TextAlign.center,
                  text: AppLocalizations.of(context)!.yourNewPasswordMustBeDifferent,
                ),
              ),
              heightGap(20),
              TextWidget(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                text: AppLocalizations.of(context)!.password,
              ),
              TextFormFieldWidget(
                hintText: AppLocalizations.of(context)!.enterPassword,
                isPassword: true,
                controller: passwordController,
                validator: (value) => Validations.instance.passwordValidation(value!, context),
              ),
              heightGap(16),
              TextWidget(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                text: AppLocalizations.of(context)!.confirmPassword,
              ),
              TextFormFieldWidget(
                hintText: AppLocalizations.of(context)!.enterConfirmPassword,
                isPassword: true,
                controller: confirmPasswordController,
                validator: (value) => Validations.instance.confirmPasswordValidation(passwordController.text, value!, context),
              ),
              heightGap(30),
              ElevatedButtonWidget(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthProvider>().resetPasswordAPi(context: context, password: passwordController.text, phone: context.read<AuthProvider>().getPhone);
                  }
                },
                width: double.infinity,
                text: AppLocalizations.of(context)!.createNewPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
