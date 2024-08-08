import 'package:flutter/material.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validations {
  Validations._();
  static final instance = Validations._();

  emptyValidation({required String value,required String field}) {
    if (value.isEmpty) {
      return "Please enter $field";
    }
  }

  bool isValidate(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  phoneValidation(String value, context) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.phoneNumberNotEmpty;
    }
    if (value.length < 7) {
      return AppLocalizations.of(context)!.phoneShould7Digit;
    }
  }

  confirmPasswordValidation(String pass1, String pass2, context) {
    if (pass2.isEmpty) {
      return AppLocalizations.of(context)!.confirmPasswordNotEmpty;
    }
    if (pass1 != pass2) {
      return AppLocalizations.of(context)!.confirmPasswordNotCorrect;
    }
  }

  _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
        emailPattern,
    );

    return emailRegExp.hasMatch(email);
  }

  emailValidation(String email, context) {
    final validEmailAddress = _isValidEmail(email);
    if (email.isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    }
    if (!validEmailAddress) {
      return AppLocalizations.of(context)!.emailNotValid;
    }
  }

  passwordValidation(String value, context) {
    RegExp passwordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`])[A-Za-z\d!@#$%^&*()_+{}|:;<>,.?/~`]{8,}$',
    );
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (!passwordPattern.hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordValidation;
    }
  }
}
