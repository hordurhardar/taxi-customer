//  point nbr 6

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/get_cancel_reasons_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';

import '../../Models/get_booking_list_model.dart';

class BookingProvider with ChangeNotifier {
  bool isLoading = false;
  final reasonController = TextEditingController();
  List<CancelData> reasonsList = [];
  String selectedReason = '';
  List<BookingData> bookingList = [];

  Future<void> selectReason({required String reason}) async {
    selectedReason = reason;
    notifyListeners();
  }

  Future<void> getCancelReasons({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: tGetCancelReasons,
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final reasonsListResponse =
        GetCancelReasonsModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (reasonsListResponse.status == 200) {
        reasonsList = reasonsListResponse.data?.data ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: reasonsListResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> cancelRide({
    required BuildContext context,
    required String reason,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: 'tApplyPromo', jsonData: {
      "reason_id": reason,
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final cancelRideResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (cancelRideResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: cancelRideResponse.message,
            isSuccess: true);
      } else {
        showSnackBar(
            context: context,
            message: cancelRideResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  Future<void> getBookingList({
    required BuildContext context,
    required String status,
  }) async {
    isLoading = true;
    final data = await RemoteService().callGetApi(
      context: context,
      url: '$tGetBookingList/$status',
    );
    log("APIstatusv ========>$tGetBookingList/$status");
    if (data == null) {
      isLoading = false;
      return;
    }
    final bookingListResponse =
        GetBookingListModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (bookingListResponse.status == 200) {
        bookingList = bookingListResponse.data?.data ?? [];
        bookingList = bookingList.reversed.toList();

        ///TODO: check for the use case of it
        await Future.forEach(bookingList, (BookingData bookingData) async {
          bookingData.markers.add(Marker(
            markerId: const MarkerId('1'),
            position: LatLng(
                bookingData.pickupLatitude!, bookingData.pickupLongitude!),
            draggable: true,
            onDragEnd: (value) {},
            icon: BitmapDescriptor.bytes(
                await getBytesFromAsset(AppImages.locationPinIcon, 50)),
          ));

          bookingData.markers.add(Marker(
            markerId: const MarkerId('2'),
            position: LatLng(bookingData.destinationLatitude!,
                bookingData.destinationLongitude!),
            draggable: true,
            onDragEnd: (value) {},
            icon: BitmapDescriptor.bytes(
                await getBytesFromAsset(AppImages.locationPinIcon, 50)),
          ));

          List<LatLng> polylineCoordinates = [];
          try {
            var polylinePoints = PolylinePoints();
            PolylineResult result =
                await polylinePoints.getRouteBetweenCoordinates(
              googleApiKey: GOOGLE_API_KEY,
              request: PolylineRequest(
                destination: PointLatLng(bookingData.destinationLatitude!,
                    bookingData.destinationLongitude!),
                origin: PointLatLng(
                    bookingData.pickupLatitude!, bookingData.pickupLongitude!),
                mode: TravelMode.driving,
              ),
            );

            for (var element in result.points) {
              polylineCoordinates
                  .add(LatLng(element.latitude, element.longitude));
            }

            bookingData.polylines
                ?.add(addPolyLine(bookingData.id!, polylineCoordinates));
          } catch (e) {
            log('error while getting route => $e');
          }
        });
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: bookingListResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Polyline addPolyLine(String polyId, polylineCoordinates) {
    PolylineId id = PolylineId(polyId);
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.cyan,
        width: 7,
        points: polylineCoordinates);
    return polyline;
  }
}
