import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/get_drop_places_model.dart';
import 'package:taxi/Models/get_lat_long_from_place_id_model.dart';
import 'package:taxi/Models/get_saved_address_model.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Providers/Type/from_destination_type.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/main.dart';

class DestinationProvider with ChangeNotifier {
  bool isLoading = false;
  List<SavedAddressData> savedAddressList = [];
  final yourLocationController = TextEditingController();
  final dropLocationController = TextEditingController();
  List<Predictions>? predictionsList = [];
  Predictions? selectedPrediction;
  LatLng? selectedPredictionLatLong;
  bool disableDropField = false;

  late BuildContext _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  BuildContext get context => _context;

  FromDestinationType? _fromDestinationType;

  FromDestinationType? get getFromDestinationType => _fromDestinationType;

  set setFromDestinationType(FromDestinationType? value) {
    _fromDestinationType = value;
  }

  set setSelectedPredictionLatLong(LatLng? value) {
    selectedPredictionLatLong = value;
  }

  Future<void> clearDropController() async {
    dropLocationController.clear();
    predictionsList?.clear();
    notifyListeners();
  }

  Future<void> disableDropFieldCall({required bool value}) async {
    disableDropField = value;
    notifyListeners();
  }

  Future<void> setDestinationYourLocationController() async {
    if (context.mounted) {
      yourLocationController.text = context.read<MapProvider>().controller.text;
    }
  }

  Future<void> setDropLocationController({required String text}) async {
    dropLocationController.text = text;
    notifyListeners();
  }

  Future<void> selectPredictionLocation(
      {required Predictions prediction}) async {
    selectedPrediction = prediction;
    setDropLocationController(text: selectedPrediction?.description ?? '');
    notifyListeners();
  }

  Future<void> getSavedPlacesListApi({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: tSavedAddress,
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final savedAddressResponse =
        GetSavedAddressModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (savedAddressResponse.status == 200) {
        savedAddressList = savedAddressResponse.data?.data ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: savedAddressResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> clearPredictionList() async {
    predictionsList?.clear();

    notifyListeners();
  }

  Future<void> getDropPlacesListApi({
    required BuildContext context,
    required String input,
  }) async {
    isLoading = true;
    print("Langguage Code ${languageSelected}");
    final data = await RemoteService().callGetApi(
      context: context,
      forLocation: true,
      url:
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$GOOGLE_API_KEY&language=is',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final getDropPlacesResponse =
        GetDropPlacesModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (getDropPlacesResponse.status == 'OK') {
        predictionsList = getDropPlacesResponse.predictions ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context, message: 'Something wrong', isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> getPlaceFromLatLngApi({
    required BuildContext context,
    required String lat,
    required String lng,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      forLocation: true,
      url:
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    log("Body ${data.body}");
    final getDropPlacesResponse =
        GetLatLongFromPlaceIdModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (getDropPlacesResponse.status == 'OK') {
        selectedPredictionLatLong = LatLng(
            getDropPlacesResponse.result?.geometry?.location?.lat ?? 0.0,
            getDropPlacesResponse.result?.geometry?.location?.lng ?? 0.0);
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context, message: 'Something wrong', isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> getLatLongFromPlaceIdApi({
    required BuildContext context,
    required String placeID,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      forLocation: true,
      url:
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$GOOGLE_API_KEY',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final getDropPlacesResponse =
        GetLatLongFromPlaceIdModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (getDropPlacesResponse.status == 'OK') {
        selectedPredictionLatLong = LatLng(
            getDropPlacesResponse.result?.geometry?.location?.lat ?? 0.0,
            getDropPlacesResponse.result?.geometry?.location?.lng ?? 0.0);
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context, message: 'Something wrong', isSuccess: false);
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
        savedAddressList.removeAt(index);
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
}
