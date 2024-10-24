import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/driver_list_model.dart';
import 'package:taxi/Models/driver_location_update_model.dart';
import 'package:taxi/Models/get_booking_details.dart';
import 'package:taxi/Models/get_vehicle_list_model.dart';
import 'package:taxi/Models/message_model.dart';
import 'package:taxi/Models/pre_book_ridelist_resp_model.dart';
import 'package:taxi/Models/receive_status_update_model.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Chat/chat_screen.dart';
import 'package:taxi/Screens/Home/BookRide/search_ride_screen.dart';
import 'package:taxi/Screens/Home/DriverArrive/driver_arriving_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/constants.dart';
import 'package:taxi/main.dart';
import '../../Models/booking_cancelled_response_model.dart';
import '../../Models/get_promo_code_model.dart';
import '../../Utils/helper_methods.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Models/get_driver_details_model.dart' as driver;

var currentRoute = DriverArrivingScreen.routeName;
IO.Socket? socket;
List<MessageModel> messageList = [];

class BookRideProvider with ChangeNotifier {
  bool isLoading = false;
  String driverId = '';
  List<PromoCodeData>? promoList;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  DateTime? scheduleTime;
  Set<Marker> markers = {};
  List<VehicleData> vehicleList = [];
  List<DriverData>? allDriverList = [];
  String? couponId;
  String gender = 'Male';
  bool isRideNow = true;
  String paymentMethod = '';
  VehicleData? selectedVehicleType;
  int oneValue = -1;
  int paymentOptionsValue = -1;
  ReceiveStatusUpdateModel? receiveStatusUpdateModel;
  final yourLocationController = TextEditingController();
  final dropLocationController = TextEditingController();
  List<BookingData> bookingList = [];
  List<ListDocs> docs = [];
  PreBookRideListModel preBookRideListModel = PreBookRideListModel();
  driver.DriverData? driverData;

  Future<void> isRideNowUpdate({required bool value}) async {
    isRideNow = value;
    notifyListeners();
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }

  Future<void> selectGender({required String gender}) async {
    this.gender = gender;
    sharedPrefs?.setString(AppStrings.selectedGender, gender);
    notifyListeners();
  }

  Future<void> selectCoupon({required String id}) async {
    couponId = id;
    notifyListeners();
  }

  List<ListDocs> getRidesForDate(DateTime date) {
    final formattedDate = "${date.year}-${date.month}-${date.day}";
    return docs.where((ride) {
      final rideDate = DateTime.parse(ride.date ?? "");
      return rideDate.year == date.year &&
          rideDate.month == date.month &&
          rideDate.day == date.day;
    }).toList();
  }

  Future<void> getPreBookRideListApi({
    required BuildContext context,
  }) async {
    changeLoading(true);
    final data = await RemoteService().callGetApi(
      context: context,
      url:
          '$tPreBookList?lat=${context.read<HomeProvider>().currentPosition?.latitude}&long=${context.read<HomeProvider>().currentPosition?.longitude}',
    );
    if (data == null) {
      changeLoading(false);

      return;
    }
    final prebookRideListResponse =
        PreBookRideListModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (prebookRideListResponse.status == 200) {
        changeLoading(false);

        docs = prebookRideListResponse.data?.list?.docs ?? [];
        print(prebookRideListResponse);
      } else {
        changeLoading(false);
        showSnackBar(
            context: context,
            message: prebookRideListResponse.statusText,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.cyan,
        width: 7,
        points: polylineCoordinates);
    log("Poliline points ==> ${polylineCoordinates.length}");
    polylines[id] = polyline;
    notifyListeners();
  }

  void makeLines({
    required BuildContext context,
    required PointLatLng pickUpLatLng,
    required PointLatLng dropLatLng,
    bool updateCamera = true,
  }) async {
    polylinePoints = PolylinePoints();
    polylines.clear();
    polylineCoordinates = [];

    try {
      log("result======>");
      final result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: GOOGLE_API_KEY,
        request: PolylineRequest(
          origin: pickUpLatLng,
          destination: dropLatLng,
          mode: TravelMode.driving,
        ),
      );
      log("polylineCoordinates =====>${result.points.length}");
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));

          log("polylineCoordinates =====>${point.latitude}");
        }
        addPolyLine();
        if (updateCamera) {
          moveCamera(
            context,
            LatLng(
              context.read<HomeProvider>().currentPosition?.latitude ?? 0.0,
              context.read<HomeProvider>().currentPosition?.longitude ?? 0.0,
            ),
          );
        }
      } else {
        print('No route found');
      }
    } catch (e) {
      print('Error fetching route: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> moveCamera(BuildContext context, LatLng pickUpLatLng) async {
    context.read<MapProvider>().moveCamera(
        pickUpLatLng,
        context.read<DestinationProvider>().selectedPrediction?.description ??
            '');
  }

  Future<void> addMarkers({required BuildContext context}) async {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
            context.read<HomeProvider>().currentPosition?.latitude ?? 0.0,
            context.read<HomeProvider>().currentPosition?.longitude ?? 0.0),
        draggable: true,
        onDragEnd: (value) {},
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(AppImages.locationPinIcon, 50)),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: LatLng(
            context
                    .read<DestinationProvider>()
                    .selectedPredictionLatLong
                    ?.latitude ??
                0.0,
            context
                    .read<DestinationProvider>()
                    .selectedPredictionLatLong
                    ?.longitude ??
                0.0),
        draggable: true,
        onDragEnd: (value) {},
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(AppImages.carYellowImage, 50)),
      ),
    );
    notifyListeners();
  }

  Future<void> selectScheduleTimeInUtc({required DateTime time}) async {
    scheduleTime = time.toUtc();
    notifyListeners();
  }

  Future<void> getPromoCodeApi({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi(
      context: context,
      url: tGetPromoCode,
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final getPromoResponse = GetPromoCodeModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (getPromoResponse.status == 200) {
        promoList = getPromoResponse.data?.data ?? [];

        log("promocard ========>${data.body}");
        isLoading = false;
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: getPromoResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> getVehicleListApi(
      {required BuildContext context,
      required double latitude,
      required double longitude}) async {
    isLoading = true;
    print('the current latitude $latitude and longitude $longitude');
    final data = await RemoteService().callGetApi(
      context: context,
      url:
          '$tGetVehicleList?lat=${context.read<HomeProvider>().currentPosition?.latitude}&long=${context.read<HomeProvider>().currentPosition?.longitude}',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final getVehicleListResponse =
        GetVehicleListModel.fromJson(jsonDecode(data.body));
    log('vewhicle list resp => ${getVehicleListResponse.toJson()}');
    if (context.mounted) {
      if (getVehicleListResponse.status == 200) {
        isLoading = false;
        vehicleList = getVehicleListResponse.data?.data ?? [];
        // for (var a in vehicleList) {
        //   a.isSelected = true;
        // }
        // if (vehicleList.isNotEmpty) {
        //   vehicleList[0].isSelected = true;
        // }
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: getVehicleListResponse.message,
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

  Future<void> getAllDriverApi({
    required BuildContext context,
  }) async {
    isLoading = true;
    final data = await RemoteService().callGetApi(
      context: context,
      url:
          '$tGetAllDriver?lat=${context.read<HomeProvider>().currentPosition?.latitude}&long=${context.read<HomeProvider>().currentPosition?.longitude}',
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
              position:
                  LatLng(element.latitude ?? 0.0, element.longitude ?? 0.0),
              draggable: true,
              onDragEnd: (value) {},
            ),
          );
        });

        print("allDriverList==========>${allDriverList!.length}");
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

  Future<void> applyPromoCode({
    required BuildContext context,
    required String couponId,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tApplyPromo, jsonData: {
      "coupon_id": couponId,
    });
    if (data == null) {
      hideLoader(context);
      return;
    }
    final applyPromoCodeResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (applyPromoCodeResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: applyPromoCodeResponse.message,
            isSuccess: true);
      } else {
        showSnackBar(
            context: context,
            message: applyPromoCodeResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }

  /* Future<void> cancelRide({
    required BuildContext context,
    required String bookingId,
    required String reason,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callPostApi(
        context:context, url: tCancelBooking, jsonData: {
      "bookingId": bookingId,
      "reason": reason,
    });
    hideLoader(context);
    if (data == null) {

      return;
    }
    final applyPromoCodeResponse = BookingCancelledResponseModel.fromJson(jsonDecode(data.body));

    if (context.mounted) {
      if (applyPromoCodeResponse.status == 200) {
        closeSocket();
        bottomSheet(context: context, content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.greyBorder,
                ),
              ),
            ),
            heightGap(20),
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.primary,
                ),
                child: const Icon(Icons.close,size: 30,),
              ),
            ),
            heightGap(20),
            Center(
              child: TextWidget(
                text: AppLocalizations.of(context)!.bookingCancelledSuccessfully,
                fontSize: 20,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightGap(20),
            Center(
              child: TextWidget(
                text: 'Your booking with CRN : #$bookingId has been cancelled successfully.',
                fontSize: 16,
                color: AppColors.greyHint,
                fontWeight: FontWeight.w500,
              ),
            ),
            heightGap(20),
            ElevatedButtonWidget(
              onPressed: () {

                Navigator.pushNamedAndRemoveUntil(context, BottomBarScreen.routeName, (route) => false);
              },
              text: 'Got it',
            ),
          ],
        ),);

      } else {
        showSnackBar(
            context: context,
            message: applyPromoCodeResponse.message,
            isSuccess: false);
        Navigator.of(context).pop();
      }
    }
    notifyListeners();
  }*/

  Future<void> cancelRide({
    required BuildContext context,
    required String bookingId,
    required String reason,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService()
        .callPostApi(context: context, url: tCancelBooking, jsonData: {
      "bookingId": bookingId,
      "reason": reason,
    });
    hideLoader(context);

    if (data == null) {
      return;
    }

    final applyPromoCodeResponse =
        BookingCancelledResponseModel.fromJson(jsonDecode(data.body));

    if (context.mounted) {
      if (applyPromoCodeResponse.status == 200) {
        closeSocket();
        bottomSheet(
          context: context,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.greyBorder,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextWidget(
                  text: AppLocalizations.of(context)!
                      .bookingCancelledSuccessfully,
                  fontSize: 20,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextWidget(
                  // Use the CRN from the API response here
                  text:
                      'Your booking with CRN : #${applyPromoCodeResponse.data?.crnNumber} has been cancelled successfully.',
                  fontSize: 16,
                  color: AppColors.greyHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButtonWidget(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, BottomBarScreen.routeName, (route) => false);
                },
                text: 'Got it',
              ),
            ],
          ),
        );
      } else {
        showSnackBar(
          context: context,
          message: applyPromoCodeResponse.message,
          isSuccess: false,
        );
        Navigator.of(context).pop();
      }
    }
    notifyListeners();
  }

  /* Future<void> bookRideApi({
    required BuildContext context,
    required double pickUpLat,
    required double pickUpLong,
    required double destinationLat,
    required double destinationLong,
    required String gender,
    required String vehicleType,
    required String amount,
    required String pickUpAddress,
    required String destinationAddress,
    required bool bookForSelf,
    required String rideType,
    required String paymentType,
    required String bookingDate,
  }) async {
    receiveStatusUpdateModel = null;
    showLoaderDialog(context);

    var perMileAmount;
    String? carType;
    int? seatCapacity;
    for (var a in vehicleList) {
      if (a.isSelected) {
        carType = a.vehicleType;
        seatCapacity = a.seatCapacity;
        perMileAmount = a.vehiclePrice;
      }
    }
    Map<String, dynamic> body = {};
    body = {
      "pickup_lat": pickUpLat.toString(),
      "pickup_long": pickUpLong.toString(),
      "driver_gender": gender,
      "vehicle_type": vehicleType,
      "total_amount": amount,
      "pickup_address": pickUpAddress,
      "destination_address": destinationAddress,
      "book_for_self": bookForSelf,
      "destination_lat": destinationLat.toString(),
      "destination_long": destinationLong.toString(),
      "rideType": rideType,
      "paymentType": paymentType,
      "booking_date": bookingDate,
      "perMileAmount": perMileAmount,
      "carType": carType,
      "seatCapacity": seatCapacity,
      "discountCoupon": couponId,
    };
    final data = await RemoteService()
        .callPostApi(context: context, url: tBookRide, jsonData: body);
    if (data == null) {
      hideLoader(context);
      return;
    }
    log("Book Response = ${data.body}");
    final bookResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (bookResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context, message: bookResponse.message, isSuccess: true);
        if (context.read<BookRideProvider>().isRideNow == "Now") {
          Navigator.of(context).pushNamed(SearchRideScreen.routeName);
        } else {
          Navigator.pop(context);
        }
      } else {
        showSnackBar(
            context: context,
            duration: 2,
            message: bookResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }*/

  Future<void> bookRideApi({
    required BuildContext context,
    required double pickUpLat,
    required double pickUpLong,
    required double destinationLat,
    required double destinationLong,
    required String gender,
    required String vehicleType,
    required String amount,
    required String pickUpAddress,
    required String destinationAddress,
    required bool bookForSelf,
    required String rideType,
    required String paymentType,
    required String bookingDate,
  }) async {
    receiveStatusUpdateModel = null;
    showLoaderDialog(context);

    var perMileAmount;
    String? carType;
    int? seatCapacity;

    for (var a in vehicleList) {
      if (a.isSelected) {
        carType = a.vehicleType;
        seatCapacity = a.seatCapacity;
        perMileAmount = a.vehiclePrice;

        log("selectedvehicales======>${a.vehicleType}");
        log("selectedvehicales======>${a.seatCapacity}");
      }
    }

    Map<String, dynamic> body = {
      "pickup_lat": pickUpLat.toString(),
      "pickup_long": pickUpLong.toString(),
      "driver_gender": gender,
      "vehicle_type": vehicleType,
      "total_amount": amount,
      "pickup_address": pickUpAddress,
      "destination_address": destinationAddress,
      "book_for_self": bookForSelf,
      "destination_lat": destinationLat.toString(),
      "destination_long": destinationLong.toString(),
      "rideType": rideType,
      "paymentType": paymentType,
      "booking_date": bookingDate,
      "perMileAmount": perMileAmount,
      "carType": carType,
      "seatCapacity": seatCapacity,
      "discountCoupon": couponId,
    };
    log("data ==========> ${body}");
    final data = await RemoteService()
        .callPostApi(context: context, url: tBookRide, jsonData: body);

    if (data == null) {
      hideLoader(context);
      return;
    }

    log("Booked Response = ${data.body}");
    final bookResponse = CommonModel.fromJson(jsonDecode(data.body));

    if (context.mounted) {
      if (bookResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
          context: context,
          message: bookResponse.message,
          isSuccess: true,
        );

        if (rideType == "Now") {
          Navigator.of(context).pushNamed(SearchRideScreen.routeName,
              arguments: {'booking_id': 'bookResponse.data'});
        } else {
          showSnackBar(
              context: context,
              message: "Booking Scheduled Successfully",
              isSuccess: true);
          Navigator.pop(context);
        }
      } else {
        showSnackBar(
          context: context,
          duration: 2,
          message: bookResponse.message,
          isSuccess: false,
        );
        hideLoader(context);
      }
    }

    notifyListeners();
  }

  Future<void> selectPaymentMethod({
    required String type,
  }) async {
    paymentMethod = type;
    notifyListeners();
  }

  Future<void> selectPayment({
    required int type,
  }) async {
    oneValue = type;
    paymentOptionsValue = -1;
    notifyListeners();
  }

  Future<void> selectCar({
    required int index,
  }) async {
    // for (var a in vehicleList) {
    //   a.isSelected = true;
    // }
    if (vehicleList.isNotEmpty) {
      for (var e in vehicleList) {
        e.isSelected = false;
      }
      vehicleList[index].isSelected = true;
      selectedVehicleType = vehicleList[index];
    }

    notifyListeners();
  }

  Future<void> selectMorePaymentOptions({
    required int type,
  }) async {
    paymentOptionsValue = type;
    oneValue = -1;
    notifyListeners();
  }

  Future<void> receivedStatusUpdate(
      {required dynamic value,
      required BuildContext context,
      bool callDriverDetailsApi = false}) async {
    ReceiveStatusUpdateModel model = ReceiveStatusUpdateModel.fromJson(value);
    print("Status is ${model.data?.status}");
    if (model.data?.status == 'Arriving' || model.data?.status == 'Drop') {
      receiveStatusUpdateModel = model;
      await context.read<BookRideProvider>().getBookingDetails(
          context: context,
          id: context
                  .read<BookRideProvider>()
                  .receiveStatusUpdateModel
                  ?.data
                  ?.id ??
              '');
      log("getalldriversapi========>${receiveStatusUpdateModel?.data?.id}");
      if (callDriverDetailsApi) {
        await context.read<DriverProvider>().getDriverDetailApi(
            context: context,
            driverId: context
                    .read<BookRideProvider>().driverId
                    // .receiveStatusUpdateModel
                    // ?.data
                    // ?.driver
                    .toString() ??
                '');
        //await context.read<BookRideProvider>().getBookingDetails(context: context, id: context.read<BookRideProvider>().receiveStatusUpdateModel?.data?.id ?? '');
        Navigator.of(context)
            .pushReplacementNamed(DriverArrivingScreen.routeName);
      }

      notifyListeners();
    } else {
      receiveStatusUpdateModel = model;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> initSocket(BuildContext context) async {
    gender = sharedPrefs?.getString(AppStrings.selectedGender) ?? "Male";
    if (context.read<MapProvider>().cameraPosition != null) {
      await context.read<HomeProvider>().setCurrentPosition(
          position: LatLng(
              context.read<MapProvider>().cameraPosition?.target.latitude ??
                  0.0,
              context.read<MapProvider>().cameraPosition?.target.longitude ??
                  0.0));
    }
    socket = IO.io(
      socketUrl,
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'token': '${sharedPrefs?.getString(AppStrings.token)}'}).build(),
    );

    log("socketdata==========>${socketUrl.length}");
    socket?.connect();

    socket?.onConnect((data) {
      log('connected');
    });
    receivedUpdateLocationEvent(context);
    receivedCancelRideEvent(context);
    receivedStatusUpdateEvent(context);
    receivedIncomingMessageEvent(context);
    socket?.onDisconnect((_) => log('disconnect'));
  }

  void receivedIncomingMessageEvent(context) {
    socket?.on('receiveMessage', (data) async {
      log('receiveMessage event received: $data');
      var dateTime = data["data"]["created_at"].toString();
      DateTime dateTimeParsed = DateTime.parse(dateTime).toLocal();
      String dateFormat = DateFormat('hh:mm a').format(dateTimeParsed);
      var isAlreadyContains = false;
      await Future.forEach(messageList, (MessageModel element) {
        if (element.message == data["data"]["message"] &&
            element.dateTime == dateTimeParsed) {
          isAlreadyContains = true;
        }
      });
      if (!isAlreadyContains) {
        messageList.add(MessageModel(data["data"]["message"],
            data["data"]["sender_id"]["userName"], dateFormat, dateTimeParsed));
      }
      print("Message list ${messageList.length}");
      messageList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      if (currentRoute != ChatScreen.routeName) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => ChatScreen(
                    driverData: driverData, bookingData: bookingList.first)));
        currentRoute = ChatScreen.routeName;
      }
      notifyListeners();
    });
  }

  Future<void> receivedStatusUpdateEvent(BuildContext context) async {
    socket?.on('receiveStatusUpdate', (data) async {
      log('acceptRide event received: $data');
      await receivedStatusUpdate(value: data, context: context);
      notifyListeners();
    });
  }

  Future<void> receivedCancelRideEvent(BuildContext context) async {
    socket?.on('cancelRide', (data) async {
      log('cancelRide event received: $data');
      await receivedStatusUpdate(value: data, context: context);
      closeSocket();
      Navigator.pushNamedAndRemoveUntil(
          context, BottomBarScreen.routeName, (route) => false);
      notifyListeners();
    });
  }

  Future<void> receivedUpdateLocationEvent(BuildContext context) async {
    markers.clear();
    polylines.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
            context.read<HomeProvider>().currentPosition?.latitude ?? 0.0,
            context.read<HomeProvider>().currentPosition?.longitude ?? 0.0),
        draggable: true,
        onDragEnd: (value) {
          // value is the new position
        },
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(AppImages.locationPinIcon, 50)),
      ),
    );
    notifyListeners();
    socket?.on('receiveupdatedLocation', (data) async {
      DriverLocationUpdateModel model =
          DriverLocationUpdateModel.fromJson(data);
      // polylines.clear();
      // makeLines(
      //   context: context,
      //   pickUpLatLng: PointLatLng(
      //     context.read<HomeProvider>().currentPosition?.latitude ?? 0.0,
      //     context.read<HomeProvider>().currentPosition?.longitude ?? 0.0,
      //   ),
      //   dropLatLng: PointLatLng(
      //     double.parse(model.data?.latitude.toString() ?? '0.0'),
      //     double.parse(model.data?.longitude.toString() ?? '0.0'),
      //   ),
      //   updateCamera: false,
      // );
      await addDriverMarker(
        id: model.data?.id.toString() ?? '',
        latLngDriver: LatLng(
          double.parse(model.data?.latitude.toString() ?? '0.0'),
          double.parse(model.data?.longitude.toString() ?? '0.0'),
        ),
      );
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> addDriverMarker({
    required String id,
    required LatLng latLngDriver,
  }) async {
    Marker? updatedDriverMarker;
    for (var element in markers) {
      print(element.markerId);
      if (element.markerId == MarkerId(id)) {
        updatedDriverMarker = element;
      }
    }
    if (updatedDriverMarker != null) {
      markers.remove(updatedDriverMarker);
      markers.add(
        updatedDriverMarker.copyWith(
          positionParam: latLngDriver, // New position
        ),
      );
      notifyListeners();
    } else {
      markers.add(Marker(
        markerId: MarkerId(id),
        position: latLngDriver,
        draggable: true,
        onDragEnd: (value) {},
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(AppImages.locationPinIcon, 50)),
      ));
      notifyListeners();
    }
  }

  Future<void> closeSocket() async {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
      socket!.close();
    }
  }

  String getToolBarTitle(
      {required String status, required BuildContext context}) {
    if (status == 'Arrived') {
      return AppLocalizations.of(context)!.driverArrived;
    } else if (status == 'Arriving') {
      return AppLocalizations.of(context)!.driverArriving;
    } else if (status == 'InProgress') {
      return AppLocalizations.of(context)!.activeRideLiveLocation;
    } else if (status == 'Completed') {
      return AppLocalizations.of(context)!.activeAtDestination;
    } else {
      return '';
    }
  }

  Future<void> getBookingDetails({
    required BuildContext context,
    required String id,
  }) async {
    isLoading = true;
    final data = await RemoteService().callGetApi(
      context: context,
      url: '$tGetBooking/$id',
    );
    if (data == null) {
      isLoading = false;
      return;
    }

    final bookingListResponse =
        GetBookingDetails.fromJson(jsonDecode(data.body));
    log("bookinglistResponse=======>${bookingListResponse.data}");
    if (context.mounted) {
      if (bookingListResponse.status == 200) {
        bookingList = bookingListResponse.data?.data ?? [];
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
}
