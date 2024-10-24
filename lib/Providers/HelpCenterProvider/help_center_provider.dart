import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';

import '../../Models/ContentDataResponse.dart';
import '../../Models/content_response.dart';
import '../../Remote/api_config.dart';

class HelpCenterProvider with ChangeNotifier {
  bool isLoading = false;
  bool termsConditionCheck = false;
  // List<ContentList>? faqList = [];
  List<ContentList>? content = [];

  Future<void> getFaqApi({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: '',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final faqListResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (faqListResponse.status == 200) {
        //faqList = faqListResponse.data?.docs  ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: faqListResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> updateTermsConditionCheckBoxValue({required bool value}) async {
    termsConditionCheck = value;
    notifyListeners();
  }

  Future<void> getContentApi(
      {required BuildContext context, String? slug}) async {
    isLoading = true;

    print('api is starts');
    final data = await RemoteService().callGetApi(
      context: context,
      url: "$tGetContent/$slug",
    );
    isLoading = false;
    print('api is calling done${data?.body}');
    if (data == null) {
      isLoading = false;
      return;
    }
    final faqListResponse = ContentDataResponse.fromJson(jsonDecode(data.body));
    log("faqListResponse=========>${faqListResponse.data}");
    if (context.mounted) {
      if (faqListResponse.status == 200) {
        content = faqListResponse.data?.data ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: faqListResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }
}
