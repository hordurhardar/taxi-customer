import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Models/get_driver_details_model.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';

import '../../Remote/api_config.dart';

class DriverProvider with ChangeNotifier {
  bool isLoading = false;
  DriverData? driverData;

  Future<void> getDriverDetailApi({
    required BuildContext context,
    required String driverId,
  }) async {
    isLoading = true;
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getString('selectedVehicleId') ?? '0';
    final data = await RemoteService().callGetApi(
      context: context,
      url: '$tGetDriverDetails?driver_id=$driverId',
    );

    log("driverid ========>$tGetDriverDetails?driver_id=$driverId");
    if (data == null) {
      isLoading = false;
      return;
    }
    final driverDetailResponse =
        GetDriverDetailsModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (driverDetailResponse.status == 200) {
        //notificationList = driverDetailResponse.data?.docs  ?? [];
        driverData = driverDetailResponse.data;
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: driverDetailResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }
}
