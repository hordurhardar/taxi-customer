import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Utils/helper_methods.dart';

class MapProvider with ChangeNotifier {
  CameraPosition? cameraPosition;
  String location = "Location Name:";
  final controller = TextEditingController();
  GoogleMapController? mapController;
  BuildContext? context;
  var msgShow = false;
  Future<void> moveCameraToCurrentLatLong({required LatLng latLng}) async {
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 16)));
    notifyListeners();
  }

  Future<void> setAutoCompleteFieldController({required String address}) async {
    controller.text = address;
    notifyListeners();
  }

  Future<void> setCameraPosition() async {
    if(context != null) {
      LatLng? latLng = context!.read<HomeProvider>().currentPosition;
      if (latLng != null) {
        cameraPosition = CameraPosition(
          target: latLng,
          zoom: 16,
        );

      } else {
        getCurrentPosition(context: context!);
      }
    }
    notifyListeners();
  }

  Future<void> initController(GoogleMapController controller, BuildContext context) async {
    mapController = controller;
    print(await mapController!.getZoomLevel());
    getCurrentPosition(context: context);
    notifyListeners();
  }

  Future<void> getCurrentPosition({required BuildContext context}) async {
    if (context.read<MapProvider>().cameraPosition == null) {
      showLoaderDialog(context);
      final hasPermission = await handleLocationPermission(context: context);

      if (!hasPermission) {
        hideLoader(context);
        return;
      }
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
       var currentPosition = LatLng(position.latitude, position.longitude);
       hideLoader(context);
       await getAddressFromCoordinates(currentPosition.latitude, currentPosition.longitude);

      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  Future<void> onCameraMove({required CameraPosition cameraPosition}) async {
    this.cameraPosition = cameraPosition;
    print("Position is ${cameraPosition.target}");
    //getAddressFromCoordinates(cameraPosition.target.latitude, cameraPosition.target.longitude);

    notifyListeners();
  }

  Future<void> onCameraIdle() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        cameraPosition?.target.latitude ?? 37.090240, cameraPosition?.target.longitude??-95.712891);
    location =
        "${placemarks.first.street},${placemarks.first.subLocality},${placemarks.first.locality},${placemarks.first.administrativeArea}";
    controller.text = location ;
    notifyListeners();
  }

  Future<void> updateMapLatLongFromAutoCompleteField(
      {required Prediction prediction}) async {
    cameraPosition = CameraPosition(
        target: LatLng(double.parse(prediction.lat ?? '0.00'),
            double.parse(prediction.lng ?? '0.00')), zoom: 16);
    await moveCamera(
        LatLng(double.parse(prediction.lat ?? '0.00'),
            double.parse(prediction.lng ?? '0.00')),
        prediction.description ?? '');
    notifyListeners();
  }

  Future<void> onItemClickFromAutoCompleteField(
      {required Prediction prediction}) async {
    controller.text = prediction.description ?? '';
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: prediction.description?.length ?? 0));
    notifyListeners();
  }

  Future<void> moveCamera(LatLng latLng, String? address) async {
    location = address ?? "";
    controller.text = address ?? '';
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 16)));
    notifyListeners();
  }


  Future cameraMovedToCurrentLocation() async {
    PermissionStatus permission = await Permission.locationWhenInUse.request();
    if (permission == PermissionStatus.granted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
       LatLng currentPosition = LatLng(position.latitude, position.longitude);


      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentPosition, zoom: 16, bearing: 0, tilt: 0),
          ),
        );
      }
      getAddressFromCoordinates(currentPosition.latitude, currentPosition.longitude);
    } else {
      // Handle permission denial
      print('Location permission denied');
    }
  }

  Future<void> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        controller.text = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        moveCamera(LatLng(latitude, longitude), controller.text);

      } else {


      }
    } catch (e) {

    }
  }

  Future<bool> handleLocationPermission(
      {required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(msgShow == false) {
        showSnackBar(
            context: context,
            message: 'Location services are disabled. Please enable the services',
            isSuccess: false);

      }
      await Geolocator.openLocationSettings().then((value) {
        msgShow = true;
        getCurrentPosition(context: context);
      });
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
        await Geolocator.openLocationSettings();
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
}
