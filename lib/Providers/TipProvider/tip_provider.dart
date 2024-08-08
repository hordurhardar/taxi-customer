import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/get_tip_amount_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';

class TipProvider with ChangeNotifier {
  bool isLoading = false;
  final amountController = TextEditingController();
  List<TipData>? tipAmountList = [];

  Future<void> addManualTipAmount({required double tipAmount}) async {
    tipAmountList?.add(TipData(amount: tipAmount, isStatus: true));
    notifyListeners();
  }

  Future<void> getTipAmountApi({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: tGetTipAmount,
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final getTipApiResponse = GetTipAmountModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (getTipApiResponse.status == 200) {
        tipAmountList = getTipApiResponse.data?.data ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: getTipApiResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> payTipApi({
    required BuildContext context,
    required String amount,
    required String driverId,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tAddTip, jsonData: {
      "amount": amount,
      "driverId": driverId,
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final addTipResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (addTipResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context, message: addTipResponse.message, isSuccess: true);
      } else {
        showSnackBar(
            context: context,
            message: addTipResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }
}
