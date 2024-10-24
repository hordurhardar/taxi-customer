import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/get_all_address_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';

class ManageAddressProvider with ChangeNotifier {
  bool isLoading = false;
  List<ManageAddressData>? manageAddressList = [];
  List<String> addressType = ['Home', 'Office', 'Other'];
  String selectedType = 'Home';
  ManageAddressData? selectedAddress;
  bool isEdit = false;
  final addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  Future<void> changeType({required String type}) async {
    selectedType = type;
    notifyListeners();
  }

  Future<void> setAddress({required String address}) async {
    addressController.text = address;
    notifyListeners();
  }

  Future<void> getAllAddressApi({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: tGetAllAddress,
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final getAllAddressModel =
        GetAllAddressModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (getAllAddressModel.status == 200) {
        isLoading = false;
        manageAddressList = getAllAddressModel.data?.data ?? [];
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: getAllAddressModel.statusText,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> addAddressApi({
    required BuildContext context,
    String? lat,
    String? long,
    String? address,
    String? addressType,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tAddAddress, jsonData: {
      "address": address,
      "latitude": lat,
      "longitude": long,
      "addressType": addressType,
      "landmark": landmarkController.text.trim(),
      "floor": floorController.text.trim(),
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final addAddressResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (addAddressResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: addAddressResponse.message,
            isSuccess: true);
      } else {
        showSnackBar(
            context: context,
            message: addAddressResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> deleteAddressApi({
    required BuildContext context,
    required String id,
    required int index,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callDeleteApi(
      url: '$tRemoveAddress/$id',
    );
    if (data == null) {
      hideLoader(context);
      return;
    }
    final removeAddressResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (removeAddressResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: removeAddressResponse.message,
            isSuccess: true);
        manageAddressList?.removeAt(index);
      } else {
        showSnackBar(
            context: context,
            message: removeAddressResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> editAddressApi({
    required BuildContext context,
    String? lat,
    String? long,
    String? address,
    String? addressType,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callPostApi(
        context: context,
        url: "$tEditAddress${selectedAddress!.id}",
        jsonData: {
          "address": address,
          "latitude": lat,
          "longitude": long,
          "addressType": addressType,
          "landmark": landmarkController.text.trim(),
          "floor": floorController.text.trim(),
        });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final editAddressApi = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (editAddressApi.status == 200) {
        hideLoader(context);
        if (editAddressApi.message.toString().trim() == "") {
          showSnackBar(
              context: context,
              message: editAddressApi.message,
              isSuccess: true);
        } else {
          showSnackBar(
              context: context,
              message: "Address Updated Successfully",
              isSuccess: true);
        }
      } else {
        showSnackBar(
            context: context,
            message: editAddressApi.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }
}
