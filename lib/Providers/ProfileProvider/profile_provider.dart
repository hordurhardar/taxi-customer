import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi/Models/get_profile_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/main.dart';

class ProfileProvider with ChangeNotifier {
  bool isLoading = false;
  ProfileData? profileData;
  bool isVerifyMobile = false;
  bool isVerifyEmail = false;
  bool buttonEnable = false;
  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  changeMobile(val) {
    if (val.toString().trim() != "") {
      if (val != profileData?.mobileNumber) {
        if (isVerifyMobile == false) {
          isVerifyMobile = true;
          notifyListeners();
        }
      } else {
        isVerifyMobile = false;
        notifyListeners();
      }
      validateButton();
    } else {
      buttonEnable = false;
      notifyListeners();
    }
  }

  void changeCountryCode(String val) {
    final formattedVal = val.replaceAll("+", "");

    log("value======>${val.length}");

    if (formattedVal.isNotEmpty &&
        formattedVal != profileData?.countryCode?.replaceAll("+", "")) {
      if (!isVerifyMobile) {
        isVerifyMobile = true;
        notifyListeners();
      }
    } else {
      isVerifyMobile = false;
      notifyListeners();
    }
    profileData?.countryCode = formattedVal;

    // Validate the button state
    validateButton();
  }

  validateButton({String? from}) {
    if (isVerifyMobile) {
      buttonEnable = false;
      return;
    } else if (isVerifyEmail) {
      buttonEnable = false;
      return;
    } else {
      buttonEnable = true;
    }
    if (from == "auth") {
      notifyListeners();
    }
  }

  changeEmail(val) {
    if (val.toString().trim().isNotEmpty) {
      if (val != profileData?.email) {
        if (isVerifyEmail == false) {
          isVerifyEmail = true;
          notifyListeners();
        }
      } else {
        isVerifyEmail = false;
        notifyListeners();
      }
      validateButton();
    } else {
      buttonEnable = false;

      notifyListeners();
    }
  }

  Future<void> getProfileApi({
    required BuildContext context,
  }) async {
    isLoading = true;
    final data = await RemoteService().callGetApi(
      context: context,
      url: tGetProfile,
    );
    if (data == null) {
      isLoading = false;
      notifyListeners();
      return;
    }
    final getProfileResponse = GetProfileModel.fromJson(jsonDecode(data.body));
    log("getProfileResponse ========> ${data.body}");

    if (context.mounted) {
      if (getProfileResponse.status == 200) {
        isLoading = false;
        profileData = getProfileResponse.data;
        print("Email is ${profileData?.email}");
        sharedPrefs?.setString(
            AppStrings.userName, getProfileResponse.data?.name ?? "");
        sharedPrefs?.setString(
            AppStrings.userImage, getProfileResponse.data?.profileImage ?? "");
        phoneNumberController.text = profileData?.mobileNumber ?? '';
        emailController.text = profileData?.email ?? '';
        nameController.text = profileData?.name ?? '';
        passwordController.text = profileData?.password ?? '';
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: getProfileResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> changeProfileValueLocally(
      {required ProfileData profileData}) async {
    this.profileData = profileData;
    notifyListeners();
  }
}
