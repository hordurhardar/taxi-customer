import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Utils/validations.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';

class PasswordManagerScreen extends StatelessWidget {
  static const routeName = "/passwordManager_screen";

  PasswordManagerScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.passwordManager,
            ),
          ),
          heightGap(
            deviceHeight(context) * 0.01,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextWidget(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        text: AppLocalizations.of(context)!.currentPassword,
                      ),
                      TextFormFieldWidget(
                        hintText:
                            AppLocalizations.of(context)!.enterCurrentPassword,
                        controller: currentPasswordController,
                        isPassword: true,
                      ),
                      heightGap(16),
                      /* Align(
                     alignment: Alignment.centerRight,
                     child: TextWidget(
                       color: AppColors.primary,
                       text: AppLocalizations.of(context)!.forgotPassword,
                       decoration: TextDecoration.underline,
                       decorationColor: AppColors.primary,
                     ),
                   ),*/
                      TextWidget(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        text: AppLocalizations.of(context)!.newPassword,
                      ),
                      TextFormFieldWidget(
                        hintText:
                            AppLocalizations.of(context)!.enterNewPassword,
                        isPassword: true,
                        controller: newPasswordController,
                        validator: (value) =>
                            Validations.instance.passwordValidation(value!, context),
                      ),
                      heightGap(16),
                      TextWidget(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        text: AppLocalizations.of(context)!.confirmPassword,
                      ),
                      TextFormFieldWidget(
                        hintText:
                            AppLocalizations.of(context)!.enterConfirmPassword,
                        isPassword: true,
                        controller: confirmNewPasswordController,
                        validator: (value) => Validations.instance
                            .confirmPasswordValidation(
                                newPasswordController.text, value!, context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CommonFooterWidget(
            cartItem: ElevatedButtonWidget(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthProvider>().changePasswordAPi(
                      context: context,
                      currentPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text);
                }
              },
              width: double.infinity,
              text: AppLocalizations.of(context)!.changePassword,
            ),
          ),
        ],
      ),
    );
  }
}
