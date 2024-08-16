import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';

class RatingProvider with ChangeNotifier {
  String rating = '5';

  Future<void> changeRating({required String rating}) async {
    this.rating = rating;
    notifyListeners();
  }

  Future<void> addRatingApi({
    required BuildContext context,
    required String bookingId,
    required String driverId,
    required String rideId,
    required String rating,
    required String description,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callPostApi(
        context: context,
        url: tAddRating, jsonData: {
      "to_user_id": driverId,
      "booking_id": bookingId,
      "rideId": rideId,
      "rating_type": "Driver",
      "rating": rating,
      "description": description,
    });
    if (data == null) {
      hideLoader(context);
      showSnackBar(
          context: context,
          message: "Something went wrong ! Please try later",
          isSuccess: false);
      return;
    }
    final addRatingResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (addRatingResponse.status == 200) {
        hideLoader(context);
        if(addRatingResponse.message!=null) {
          showSnackBar(
              context: context,
              message: addRatingResponse.message,
              isSuccess: true);
        }

      } else {
        if(addRatingResponse.message!=null) {
          showSnackBar(
              context: context,
              message: addRatingResponse.message,
              isSuccess: true);
        }
        hideLoader(context);
      }
    }
    notifyListeners();
  }
}
