import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/main.dart';

import 'api_config.dart';
import 'app_exceptions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RemoteService {
  Future<http.Response?> callDeleteApi({
    BuildContext? context,
    required String url,
  }) async {
    http.Response? responseJson;
    try {
      var authToken = await getAuthToken();
      var osType = await getOsType();
      var header = <String, String>{
        'Content-Type': 'application/json',
        'device_type': osType ?? 'mobile',
        'Authorization': 'Bearer ${authToken ?? ""}',
      };
      final response =
          await http.delete(Uri.parse('$BASE_URL$url'), headers: header);
      log('Api response >>> : ${response.body.toString()}');
      log('Api response >>> : ${response.statusCode.toString()}');
      responseJson = _returnResponse(response);
      log('Api header : $header');
    } on SocketException catch (exception) {
      showSnackBar(
          context: context,
          isSuccess: false,
          message: exception.message.toString());
      throw NoInternetException('No Internet');
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: context,
          isSuccess: false,
          message: exceptionData['message'].toString());
      if (exceptionData['status'].toString() == '403') {
        //      logOut(context: context);
      }
      if (exceptionData['status'].toString() == '500') {
        //      logOut(context: context);
      }
      if (exceptionData['message'].toString().contains('jwt')) {
        // logOut(context: context);
      }
    }
    log('Api Url : $BASE_URL$url');

    return responseJson;
  }

  Future<http.Response?> callGetApi({
    required BuildContext? context,
    required String url,
    bool forLocation = false,
  }) async {
    http.Response? responseJson;
    print('the outside of trycatch and url is ${BASE_URL}$url ');
    try {
      print('the trycatch is starting ');
      var authToken = await getAuthToken();
      var osType = await getOsType();
      print('the jwt token $authToken ');
      var header = <String, String>{
        'Content-Type': 'application/json',
        'device_type': osType ?? 'mobile',
        'Authorization': 'Bearer ${authToken ?? ""}',
      };

      final response = await http
          .get(Uri.parse(forLocation ? url : '$BASE_URL$url'), headers: header);
      print('api response is ${response.body}');
      log('Api Url : $BASE_URL$url');
      log("auth Token $authToken");
      log('Api header : $header');
      log('Api response >>> : ${response.body.toString()}');

      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      if (exception.message.toString().contains('jwt')) {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context!)!.sessionExpired,
            isSuccess: false);
        // logOut(context: context);
      } else {
        showSnackBar(
            context: context,
            isSuccess: false,
            message: exception.message.toString());

        // throw NoInternetException('No Internet');
      }
    } catch (e) {
      print('the exception is $e');
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      // showSnackBar(
      //     context: context,
      //     isSuccess: false,
      //     message: exceptionData['message'].toString());
      if (exceptionData['status'].toString() == '403') {
        //      logOut(context: context);
      }
      if (exceptionData['status'].toString() == '500') {
        //      logOut(context: context);
      }
      if (exceptionData['message'].toString().contains('jwt')) {
        // showSnackBar(
        //     context: context,
        //     message: AppLocalizations.of(context!)!.sessionExpired,
        //     isSuccess: false);
        // logOut(context: context);
      }
    }

    return responseJson;
  }

  Future<http.Response?> callMultipartApi({
    required BuildContext? context,
    required String url,
    required Map<String, String> requestBody,
    File? file,
    String? fileParamName,
    String? requestName,
  }) async {
    http.Response? responseJson;
    var authToken = await getAuthToken();
    var osType = await getOsType();
    var request =
        http.MultipartRequest(requestName ?? 'POST', Uri.parse(BASE_URL + url));
    request.headers.addAll(<String, String>{
      'Content-Type': 'multipart/form-data',
      'device_type': osType ?? 'mobile',
      'Authorization': 'Bearer ${authToken ?? ""}',
    });
    log("request Header ===$request");
    if (fileParamName != null && file != null) {
      request.files.add(http.MultipartFile(
          fileParamName, file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split("/").last));
    }
    request.fields.addAll(requestBody);
    try {
      final response = await http.Response.fromStream(await request.send());
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      showSnackBar(
          context: context,
          isSuccess: false,
          message: exception.message.toString());
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: context,
          isSuccess: false,
          message: exceptionData['message'].toString());
      if (exceptionData['status'].toString() == '403') {
        //       logOut(context: context);
      }
      if (exceptionData['status'].toString() == '500') {
        //      logOut(context: context);
      }
      if (exceptionData['message'].toString().contains('jwt')) {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context!)!.sessionExpired,
            isSuccess: false);
        // logOut(context: context);
      }
    }
    log('Api Url : $BASE_URL$url');
    return responseJson;
  }

  Future<http.Response?> callPostApi({
    required BuildContext? context,
    required String url,
    required Map<String, dynamic> jsonData,
    Map<String, dynamic>? jsonDataForStripe,
    bool isForStripe = false,
    String? urlForStripe,
  }) async {
    http.Response? responseJson;
    try {
      var authToken = await getAuthToken();
      log(authToken ?? "");
      var osType = await getOsType();
      final response = await http.post(
          Uri.parse(isForStripe ? '$urlForStripe' : '$BASE_URL$url'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'device_type': osType ?? 'mobile',
            'Authorization': 'Bearer ${authToken ?? ""}',
          },
          body: isForStripe ? jsonDataForStripe : jsonEncode(jsonData));
      log("$BASE_URL$url");

      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      if (exception.message.toString().contains('jwt')) {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context!)!.sessionExpired,
            isSuccess: false);
        // logOut(context: context);
      } else {
        showSnackBar(
            context: context,
            isSuccess: false,
            message: exception.message.toString());

        // throw NoInternetException('No Internet');
      }
    } catch (e) {
      /*log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: context,
          isSuccess: false,
          message:
              '${exceptionData['message'].toString()} ${exceptionData['status'].toString()}');
      if (exceptionData['message'].toString() == 'jwt expired') {
        logOut(context: context);
      }*/
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: context,
          isSuccess: false,
          message: exceptionData['message'].toString());
      if (exceptionData['status'].toString() == '403') {
        //       logOut(context: context);
      }
      if (exceptionData['status'].toString() == '500') {
        //       logOut(context: context);
      }

      if (exceptionData['message'].toString().contains('jwt')) {
        // showSnackBar(
        //     context: context,
        //     message: AppLocalizations.of(context!)!.sessionExpired,
        //     isSuccess: false);
        // logOut(context: context);
      }
    }
    log('Api Url : $BASE_URL$url');
    log('Api request : ${jsonData.toString()}');
    log('Api response : ${responseJson?.body.toString()}');
    return responseJson;
  }

  Future<http.Response?> callPutApi({
    required BuildContext? context,
    required String url,
    Map<String, dynamic>? jsonData,
  }) async {
    http.Response? responseJson;
    try {
      var authToken = await getAuthToken();
      var osType = await getOsType();
      var header = <String, String>{
        'Content-Type': 'application/json',
        'device_type': osType ?? 'mobile',
        'Authorization': 'Bearer ${authToken ?? ""}',
      };
      final response = await http.put(Uri.parse('$BASE_URL$url'),
          headers: header, body: jsonEncode(jsonData));
      responseJson = _returnResponse(response);
      log('Api header : $header');
    } on SocketException catch (exception) {
      if (exception.message.toString().contains('jwt')) {
        // showSnackBar(
        //     context: context,
        //     message: AppLocalizations.of(context!)!.sessionExpired,
        //     isSuccess: false);
        // logOut(context: context);
      } else {
        showSnackBar(
            context: context,
            isSuccess: false,
            message: exception.message.toString());

        throw NoInternetException('No Internet');
      }
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: context,
          isSuccess: false,
          message: exceptionData['message'].toString());
      if (exceptionData['status'].toString() == '403') {
        //  logOut(context: context);
      }
      if (exceptionData['status'].toString() == '500') {
        //  logOut(context: context);
      }
      if (exceptionData['message'].toString().contains('jwt')) {
        // showSnackBar(
        //     context: context,
        //     message: AppLocalizations.of(context!)!.sessionExpired,
        //     isSuccess: false);
        // logOut(context: context);
      }
    }
    log('Api Url : $BASE_URL$url');
    log('Api response >>> : ${responseJson?.body.toString()}');
    return responseJson;
  }

  Future<String?> getAuthToken() async {
    String? token = sharedPrefs?.getString(AppStrings.token);
    log('the jwt token is : $token');
    print('the jwt token is : $token');
    if (token == '') {
      return null;
    } else {
      return token;
    }
  }

  Future<String?> getOsType() async {
    String? os = sharedPrefs?.getString(AppStrings.deviceOs);
    if (os == '') {
      return null;
    } else {
      return os;
    }
  }

  Future<String?> getUserName() async {
    String? token = sharedPrefs?.getString(AppStrings.userName);
    if (token == '') {
      return null;
    } else {
      return token;
    }
  }

  dynamic _returnResponse(http.Response response) {
    print(response.body);
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        return response;
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        return response;
      case 406:
        return response;
      case 409:
        return response;
      case 500:
        throw FetchDataException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
