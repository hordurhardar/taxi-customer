import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/image_upload_model.dart';
import 'package:taxi/Models/login_model.dart';
import 'package:taxi/Models/update_profile_model.dart';
import 'package:taxi/Models/verify_otp_model.dart';
import 'package:taxi/Providers/ProfileProvider/profile_provider.dart';
import 'package:taxi/Providers/Type/from_auth_type.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Screens/Auth/LocationAccess/enable_location_access_screen.dart';
import 'package:taxi/Screens/Auth/SetPassword/new_password_screen.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/Auth/SignUp/sign_up_screen.dart';
import 'package:taxi/Screens/Auth/VerifyCode/verify_code_screen.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Profile/complete_profile_screen.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/main.dart';

class AuthProvider with ChangeNotifier {
  bool termsConditionCheck = false;
  File? imageData;
  bool isLoading = false;
  String profileImageUrl = '';
  String? _currentAddress;
  Position? _currentPosition;
  bool passwordObSecureLogin = true;
  bool passwordObSecureSignUp = true;
  bool code = true;
  String countryCode = '354';
  String _email = "";
  String _phone = "";
  String _password = "";
  String _name = "";
  String _type = "";
  String? selectedGender;
  String get getEmail => _email;
  String get getPhone => _phone;

  set setEmail(String value) {
    _email = value;
  }

  set setPhone(String value) {
    _phone = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  set setName(String value) {
    _name = value;
  }

  set setType(String value) {
    _type = value;
  }

  FromAuthType? _fromType;

  FromAuthType? get getFromType => _fromType;

  set setFromType(FromAuthType? value) {
    _fromType = value;
  }

  Future<void> clearData() async {
    imageData = null;
    notifyListeners();
  }

  Future<void> updateTermsConditionCheckBoxValue({required bool value}) async {
    termsConditionCheck = value;
    notifyListeners();
  }

  Future<void> registerApi({required BuildContext context}) async {
    var osType = await RemoteService().getOsType();
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tSignUpNew, jsonData: {
      "countryCode": countryCode.toString().replaceAll("+", ""),
      "mobileNumber": _phone,
      "password": _password,
      "name": _name,
      "email": _email,
      "type": "User",
      "loginType": "Phone",
      "gender": selectedGender,
      "deviceType": osType ?? 'Android',
      "deviceToken": sharedPrefs?.getString(AppStrings.fcm)
    });
    log("registerApi=====>${data}");
    if (data == null) {
      hideLoader(context);
      return;
    }
    final signUpResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (signUpResponse.status == 201) {
        hideLoader(context);
        showSnackBar(
            context: context, message: signUpResponse.message, isSuccess: true);

        // Save the country code locally
        sharedPrefs?.setString(
            AppStrings.countryCode, countryCode.toString().replaceAll("+", ""));

        Navigator.of(context).pushNamed(VerifyCodeScreen.routeName);
      } else {
        showSnackBar(
            context: context,
            message: signUpResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> verifyOtpApiSignUp({
    required BuildContext context,
    required String otp,
    required String phone,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callPostApi(
        context: context,
        url: tVerifyOtpAuthenticateNew,
        jsonData: {
          "countryCode": countryCode.toString().replaceAll("+", ""),
          "mobileNumber": phone,
          "otp": otp,
        });

    if (data == null) {
      hideLoader(context);
      return;
    }
    final verifyOtpResponse = VerifyOtpModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (verifyOtpResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: true);
        sharedPrefs?.setString(
            AppStrings.token, verifyOtpResponse.data?.token.toString() ?? '');

        setFromType = FromAuthType.fromSignUp;
        // Navigator.of(context).pushNamed(EnableLocationAccess.routeName);
        if (verifyOtpResponse.data?.user?.isProfileCompleted != null &&
            verifyOtpResponse.data?.user?.isProfileCompleted == false) {
          Navigator.of(context)
              .pushReplacementNamed(CompleteProfileScreen.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);
        }
      } else {
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<bool> updateProfile({
    required BuildContext context,
    String? gender,
    String? mobile,
    String? countryCode,
    String? lat,
    String? long,
    String? address,
    String? email,
    String? profileImage,
    String? name,
  }) async {
    showLoaderDialog(context);

    final data = await RemoteService()
        .callPostApi(context: context, url: tUpdateProfile, jsonData: {
      "gender": gender,
      "mobileNumber": mobile,
      "countryCode": countryCode.toString().replaceAll("+", ""),
      "latitude": lat,
      "longitude": long,
      "address": address,
      "email": email,
      "profileImage": profileImage,
      "name": name,
      "isProfileCompleted": true,
    });

    if (data == null) {
      log("updateprofile==========>${data?.body}");
      hideLoader(context);
      return false;
    }

    final updateProfileResponse =
        UpdateProfileModel.fromJson(jsonDecode(data.body));
    log("updateprofile==========>${data?.body}");

    if (context.mounted) {
      if (updateProfileResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: updateProfileResponse.message,
            isSuccess: true);
        sharedPrefs?.setBool(AppStrings.isLogin, true);

        context.read<ProfileProvider>().changeProfileValueLocally(
            profileData: updateProfileResponse.data!);
        return true;
      } else {
        showSnackBar(
            context: context,
            message: updateProfileResponse.message,
            isSuccess: false);
        hideLoader(context);
        return false;
      }
    }
    notifyListeners();
    return false;
  }

  Future<void> imageUploadApi(
      {required BuildContext context, required File file}) async {
    isLoading = true;
    final data = await RemoteService().callMultipartApi(
      context: context,
      url: tImageUpload,
      requestBody: {},
      file: file,
      fileParamName: 'image',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final imageUploadResponse =
        ImageUploadModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (imageUploadResponse.status == 200) {
        log(file.path);
        profileImageUrl = file.path ?? '';
        isLoading = false;
        showSnackBar(
            context: context,
            message: imageUploadResponse.message,
            isSuccess: true);
      } else {
        showSnackBar(
            context: context,
            message: imageUploadResponse.message,
            isSuccess: false);
        isLoading = false;
      }
    }
    notifyListeners();
  }

  Future<void> loginApi({
    required BuildContext context,
    required String password,
    required String email,
  }) async {
    var osType = await RemoteService().getOsType();
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tLoginNew, jsonData: {
      "countryCode": countryCode.toString().replaceAll("+", ""),
      "mobileNumber": email,
      "password": password,
      "type": "User",
      "deviceType": osType ?? 'Android',
      "deviceToken": sharedPrefs?.getString(AppStrings.fcm)
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final loginResponse = LoginModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (loginResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context, message: loginResponse.message, isSuccess: true);
        sharedPrefs?.setString(
            AppStrings.token, loginResponse.data?.token.toString() ?? '');
        sharedPrefs?.setString(AppStrings.userName,
            loginResponse.data?.user?.name.toString() ?? '');
        sharedPrefs?.setString(AppStrings.userImage,
            loginResponse.data?.user?.profilePic.toString() ?? '');
        sharedPrefs?.setBool(AppStrings.isLogin, true);
        sharedPrefs?.setString(AppStrings.countryCode,
            loginResponse.data?.user?.country.toString() ?? '');
        if (loginResponse.data?.user?.isProfileCompleted ?? false) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            EnableLocationAccess.routeName,
            (route) => false,
          );
        } else {
          setFromType = FromAuthType.fromLogin;
          Navigator.of(context)
              .pushReplacementNamed(CompleteProfileScreen.routeName);
        }
      } else {
        showSnackBar(
            context: context, message: loginResponse.message, isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> showBottomSheet({
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext c) {
          return Padding(
            padding: MediaQuery.of(c).viewInsets,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      await pickMedia(source: ImageSource.gallery)
                          .then((value) {
                        imageUploadApi(context: context, file: imageData!);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () async {
                      await pickMedia(source: ImageSource.camera).then((value) {
                        imageUploadApi(context: context, file: imageData!);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickMedia({
    required ImageSource source,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxHeight: 480,
      maxWidth: 640,
    );
    if (image != null) {
      imageData = File(image.path);
      notifyListeners();
    }
  }

  Future<bool> _handleLocationPermission(
      {required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(
          context: context,
          message: 'Location services are disabled. Please enable the services',
          isSuccess: false);

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(
            context: context,
            message: 'Location permissions are denied',
            isSuccess: false);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          context: context,
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          isSuccess: false);

      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition({required BuildContext context}) async {
    showLoaderDialog(context);
    final hasPermission = await _handleLocationPermission(context: context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(context);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(BuildContext context) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      hideLoader(context);
      final update = await updateProfile(
          context: context,
          address: _currentAddress,
          mobile: _phone,
          countryCode: countryCode,
          email: _email,
          name: _name,
          lat: _currentPosition?.latitude.toString(),
          long: _currentPosition?.longitude.toString());
      if (update) {
        if (context.read<AuthProvider>().getFromType ==
            FromAuthType.fromSignUp) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              BottomBarScreen.routeName, (route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              BottomBarScreen.routeName, (route) => false);
        }
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> changeCountryCode({required String countryCode}) async {
    this.countryCode = countryCode;
    notifyListeners();
  }

  Future<void> changeObSecureForLogin() async {
    passwordObSecureLogin = !passwordObSecureLogin;
    notifyListeners();
  }

  Future<void> changeObSecureForSignUp() async {
    passwordObSecureSignUp = !passwordObSecureSignUp;
    notifyListeners();
  }

  Future<void> forgotPasswordApi({
    required BuildContext context,
    required String phone,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tForgotPassword, jsonData: {
      "mobileNumber": phone,
      "countryCode": countryCode.toString().replaceAll("+", ""),
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final loginResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (loginResponse.status == 200) {
        setPhone = _phone;
        hideLoader(context);
        showSnackBar(
            context: context, message: loginResponse.message, isSuccess: true);
        Navigator.of(context).pushNamed(VerifyCodeScreen.routeName);
      } else {
        hideLoader(context);
        showSnackBar(
            context: context, message: loginResponse.message, isSuccess: false);
      }
    } else {
      showSnackBar(
          context: context, message: loginResponse.message, isSuccess: false);
      hideLoader(context);
    }
    notifyListeners();
  }

  Future<void> resendOtp({
    required BuildContext context,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tResendOtp, jsonData: {
      "mobileNumber": _phone,
      "countryCode": countryCode.toString().replaceAll("+", ""),
      "type": "User",
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final verifyOtpResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (verifyOtpResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: true);
      } else {
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> verifyOtpApi({
    required BuildContext context,
    required String otp,
    required String phone,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tVerifyOtpNew, jsonData: {
      "mobileNumber": phone,
      "countryCode": countryCode.toString().replaceAll("+", ""),
      "otp": otp,
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final verifyOtpResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (verifyOtpResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: true);
        Navigator.of(context).pushReplacementNamed(NewPasswordScreen.routeName);
      } else {
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> sendOtp(
      {required BuildContext context, required String type}) async {
    isLoading = true;
    showLoaderDialog(context);
    Map<String, dynamic> requestBody = {};

    requestBody["type"] = type;
    if (type == "email") {
      requestBody["email"] = _email;
    } else {
      requestBody["mobileNumber"] = _phone;
      requestBody["countryCode"] = countryCode;
    }

    final data = await RemoteService().callPostApi(
        context: context, url: tUpdateMobileEmail, jsonData: requestBody);
    log("Response-------> $requestBody");
    hideLoader(context);
    if (data == null) {
      isLoading = false;
      notifyListeners();
      return;
    }

    final getProfileResponse = CommonModel.fromJson(jsonDecode(data.body));

    if (context.mounted) {
      if (getProfileResponse.status == 200) {
        isLoading = false;
        setFromType = FromAuthType.fromProfile;
        Navigator.pushNamed(context, VerifyCodeScreen.routeName);
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

  Future<void> verifyOtpApiProfile(
      {required BuildContext context, required String otp}) async {
    showLoaderDialog(context);

    Map<String, dynamic> map = {};
    map["otp"] = otp;
    map["type"] = _type;
    if (_type == "email") {
      map["email"] = _email;
    } else {
      map["mobileNumber"] = _phone;
      map["countryCode"] = countryCode;
    }
    final data = await RemoteService()
        .callPostApi(context: context, url: tVerifyMobileEmail, jsonData: map);
    if (data == null) {
      hideLoader(context);
      return;
    }
    final verifyOtpResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (verifyOtpResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: true);
        if (_type == "email") {
          context.read<ProfileProvider>().isVerifyEmail = false;
        } else {
          context.read<ProfileProvider>().isVerifyMobile = false;
        }
        context.read<ProfileProvider>().validateButton(from: "auth");

        Navigator.of(context).pop();
      } else {
        showSnackBar(
            context: context,
            message: verifyOtpResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> resetPasswordAPi({
    required BuildContext context,
    required String password,
    required String phone,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tResetPassword, jsonData: {
      "mobileNumber": phone,
      "countryCode": countryCode.toString().replaceAll("+", ""),
      "password": password,
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final resetPasswordResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (resetPasswordResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: resetPasswordResponse.message,
            isSuccess: true);
        Navigator.of(context).pushNamedAndRemoveUntil(
          SignInScreen.routeName,
          (route) => false,
        );
      } else {
        showSnackBar(
            context: context,
            message: resetPasswordResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> changePasswordAPi({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tChangePassword, jsonData: {
      "new_password": newPassword,
      "password": currentPassword,
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final changePasswordScreen = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (changePasswordScreen.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: changePasswordScreen.message,
            isSuccess: true);
        Navigator.of(context).pushNamedAndRemoveUntil(
          SignInScreen.routeName,
          (route) => false,
        );
      } else {
        showSnackBar(
            context: context,
            message: changePasswordScreen.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> deleteAccountApi({
    required BuildContext context,
  }) async {
    showLoaderDialog(context);

    final data = await RemoteService().callGetApi(
      context: context,
      url: tDeleteAccount,
    );
    if (data == null) {
      hideLoader(context);

      return;
    }
    final deleteAccountResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (deleteAccountResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: deleteAccountResponse.message,
            isSuccess: false);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
      } else {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: deleteAccountResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<dynamic> logOutApi({
    required BuildContext context,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callGetApi(
      context: context,
      url: tLogout,
    );
    hideLoader(context);
    if (data == null) {
      return;
    }

    final logOutResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (logOutResponse.status == 200) {
        sharedPrefs?.remove(AppStrings.token);
        sharedPrefs?.remove(AppStrings.isLogin);

        showSnackBar(
            context: context, message: logOutResponse.message, isSuccess: true);
        return true;
      } else {
        showSnackBar(
            context: context,
            message: logOutResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> socialLoginApi({
    required BuildContext context,
    required Map<String, dynamic> jsonData,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tSocialSignUp, jsonData: jsonData);
    if (data == null) {
      hideLoader(context);
      return;
    }

    notifyListeners();
  }
}
