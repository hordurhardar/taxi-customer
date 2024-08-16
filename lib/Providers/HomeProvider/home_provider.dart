import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/Models/driver_list_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';

class HomeProvider with ChangeNotifier {
  bool isLoading = false;
  //Position? currentPosition;
  LatLng? currentPosition;
  String? currentAddress;

  final homeSearchController = TextEditingController();
  List<DriverData>? allDriverList = [];
  Set<Marker> markers = {};

  Future<void> setHomeSearchController({required String text}) async {
    homeSearchController.text = text;
    notifyListeners();
  }

  Future<void> setCurrentPosition({required LatLng position}) async {
    currentPosition = position;
    notifyListeners();
  }

  Future<void> _getAddressFromLatLng(BuildContext context) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];
      currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      homeSearchController.text = currentAddress ?? '';

      await getAllDriverApi(
        context: context,
        lat: currentPosition!.latitude.toString(),
        long: currentPosition!.latitude.toString(),
      );

      hideLoader(context);
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getAllDriverApi({
    required BuildContext context,
    required String lat,
    required String long,
  }) async {
    print('call');
    log('call');
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: '$tGetAllDriver?lat=$lat&long=$long',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final driverListResponse = DriverListModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (driverListResponse.status == 200) {
        isLoading = false;
        allDriverList = driverListResponse.data?.data ?? [];

        allDriverList?.forEach((element) async {
          markers.add(
            Marker(
              markerId: MarkerId(element.id.toString()),
              // position:  LatLng(double.parse(element.latitude.toString()), double.parse(element.longitude.toString())),
              position:
                  LatLng(element.latitude ?? 0.0, element.longitude ?? 0.0),
              draggable: true,
              onDragEnd: (value) {
                // value is the new position
              },
              icon: BitmapDescriptor.fromBytes(
                  await getBytesFromAsset(AppImages.carYellowImage, 50)),
            ),
          );
        });
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: driverListResponse.statusText,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
