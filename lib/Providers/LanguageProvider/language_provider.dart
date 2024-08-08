
import 'package:flutter/material.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/main.dart';


class LanguageProvider with ChangeNotifier {

  String lang = "en";
  bool isEnglish = true;
  Locale locale = const Locale("en");

  void initProvider() {
    lang = sharedPrefs?.getString(AppStrings.language) ?? "en";
    changeLanguage(Locale(lang));
    notifyListeners();
  }

  void changeLanguage(Locale value) {
    locale = value;
    sharedPrefs?.setString(AppStrings.language, lang);
    notifyListeners();
  }
}
