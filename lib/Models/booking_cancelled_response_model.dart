class BookingCancelledResponseModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  BookingCancelledResponseModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  BookingCancelledResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    exeTime = json['exeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['exeTime'] = this.exeTime;
    return data;
  }
}

class Data {
  PickupLocation? pickupLocation;
  PickupLocation? dropLocation;
  String? pickupAddress;
  String? destinationAddress;
  double? pickupLatitude;
  double? pickupLongitude;
  Null? customerMidlocation;
  Null? customerMidLocationLat;
  Null? customerMidLocationLong;
  double? destinationLatitude;
  double? destinationLongitude;
  Null? city;
  Null? state;
  Null? country;
  Null? landmark;
  Null? houseNo;
  List<Null>? declineRideDriver;
  List<Null>? notificationSendUser;
  Null? vehicleNumber;
  Null? vehicleColor;
  Null? amount;
  String? status;
  String? rideType;
  bool? bookForSelf;
  Null? otp;
  bool? isPaid;
  Null? time;
  int? perMileAmount;
  Null? totalDistance;
  Null? totalAmount;
  String? carType;
  String? seatCapacity;
  int? customerRating;
  int? driverRating;
  String? startRideTime;
  Null? endRideTime;
  String? reason;
  String? crnNumber;
  Null? otherPersonName;
  Null? otherPersonContactNumber;
  bool? isSelf;
  Null? dateTimeStamp;
  String? sId;
  String? customer;
  String? date;
  String? driverGender;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? driver;

  Data(
      {this.pickupLocation,
        this.dropLocation,
        this.pickupAddress,
        this.destinationAddress,
        this.pickupLatitude,
        this.pickupLongitude,
        this.customerMidlocation,
        this.customerMidLocationLat,
        this.customerMidLocationLong,
        this.destinationLatitude,
        this.destinationLongitude,
        this.city,
        this.state,
        this.country,
        this.landmark,
        this.houseNo,
        this.declineRideDriver,
        this.notificationSendUser,
        this.vehicleNumber,
        this.vehicleColor,
        this.amount,
        this.status,
        this.rideType,
        this.bookForSelf,
        this.otp,
        this.isPaid,
        this.time,
        this.perMileAmount,
        this.totalDistance,
        this.totalAmount,
        this.carType,
        this.seatCapacity,
        this.customerRating,
        this.driverRating,
        this.startRideTime,
        this.endRideTime,
        this.reason,
        this.crnNumber,
        this.otherPersonName,
        this.otherPersonContactNumber,
        this.isSelf,
        this.dateTimeStamp,
        this.sId,
        this.customer,
        this.date,
        this.driverGender,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.driver});

  Data.fromJson(Map<String, dynamic> json) {
    pickupLocation = json['pickupLocation'] != null
        ? new PickupLocation.fromJson(json['pickupLocation'])
        : null;
    dropLocation = json['dropLocation'] != null
        ? new PickupLocation.fromJson(json['dropLocation'])
        : null;
    pickupAddress = json['pickupAddress'];
    destinationAddress = json['destinationAddress'];
    pickupLatitude = json['pickupLatitude'];
    pickupLongitude = json['pickupLongitude'];
    customerMidlocation = json['customerMidlocation'];
    customerMidLocationLat = json['customerMidLocationLat'];
    customerMidLocationLong = json['customerMidLocationLong'];
    destinationLatitude = json['destinationLatitude'];
    destinationLongitude = json['destinationLongitude'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    landmark = json['landmark'];
    houseNo = json['house_no'];
    vehicleNumber = json['vehicleNumber'];
    vehicleColor = json['vehicleColor'];
    amount = json['amount'];
    status = json['status'];
    rideType = json['rideType'];
    bookForSelf = json['book_for_self'];
    otp = json['otp'];
    isPaid = json['isPaid'];
    time = json['time'];
    perMileAmount = json['perMileAmount'];
    totalDistance = json['totalDistance'];
    totalAmount = json['totalAmount'];
    carType = json['carType'];
    seatCapacity = json['seatCapacity'];
    customerRating = json['customer_rating'];
    driverRating = json['driver_rating'];
    startRideTime = json['start_ride_time'];
    endRideTime = json['end_ride_time'];
    reason = json['reason'];
    crnNumber = json['crnNumber'];
    otherPersonName = json['otherPersonName'];
    otherPersonContactNumber = json['otherPersonContactNumber'];
    isSelf = json['isSelf'];
    dateTimeStamp = json['dateTimeStamp'];
    sId = json['_id'];
    customer = json['customer'];
    date = json['date'];
    driverGender = json['driver_gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickupLocation != null) {
      data['pickupLocation'] = this.pickupLocation!.toJson();
    }
    if (this.dropLocation != null) {
      data['dropLocation'] = this.dropLocation!.toJson();
    }
    data['pickupAddress'] = this.pickupAddress;
    data['destinationAddress'] = this.destinationAddress;
    data['pickupLatitude'] = this.pickupLatitude;
    data['pickupLongitude'] = this.pickupLongitude;
    data['customerMidlocation'] = this.customerMidlocation;
    data['customerMidLocationLat'] = this.customerMidLocationLat;
    data['customerMidLocationLong'] = this.customerMidLocationLong;
    data['destinationLatitude'] = this.destinationLatitude;
    data['destinationLongitude'] = this.destinationLongitude;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['landmark'] = this.landmark;
    data['house_no'] = this.houseNo;
    data['vehicleNumber'] = this.vehicleNumber;
    data['vehicleColor'] = this.vehicleColor;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['rideType'] = this.rideType;
    data['book_for_self'] = this.bookForSelf;
    data['otp'] = this.otp;
    data['isPaid'] = this.isPaid;
    data['time'] = this.time;
    data['perMileAmount'] = this.perMileAmount;
    data['totalDistance'] = this.totalDistance;
    data['totalAmount'] = this.totalAmount;
    data['carType'] = this.carType;
    data['seatCapacity'] = this.seatCapacity;
    data['customer_rating'] = this.customerRating;
    data['driver_rating'] = this.driverRating;
    data['start_ride_time'] = this.startRideTime;
    data['end_ride_time'] = this.endRideTime;
    data['reason'] = this.reason;
    data['crnNumber'] = this.crnNumber;
    data['otherPersonName'] = this.otherPersonName;
    data['otherPersonContactNumber'] = this.otherPersonContactNumber;
    data['isSelf'] = this.isSelf;
    data['dateTimeStamp'] = this.dateTimeStamp;
    data['_id'] = this.sId;
    data['customer'] = this.customer;
    data['date'] = this.date;
    data['driver_gender'] = this.driverGender;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['driver'] = this.driver;
    return data;
  }
}

class PickupLocation {
  String? type;
  List<double>? coordinates;

  PickupLocation({this.type, this.coordinates});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
