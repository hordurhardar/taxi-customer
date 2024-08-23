import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetBookingListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetBookingListModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  GetBookingListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    exeTime = json["exeTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["statusText"] = statusText;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["exeTime"] = exeTime;
    return _data;
  }
}

class Data {
  List<BookingData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => BookingData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class BookingData {
  PickupLocation? pickupLocation;
  DropLocation? dropLocation;
  String? pickupAddress;
  String? destinationAddress;
  double? pickupLatitude;
  double? pickupLongitude;
  double? destinationLatitude;
  double? destinationLongitude;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic landmark;
  dynamic houseNo;
  dynamic vehicleNumber;
  dynamic vehicleColor;
  dynamic amount;
  String? status;
  String? rideType;
  String? carType;
  String? perMileAmount;
  String? seatCapacity;
  bool? bookForSelf;
  int? otp;
  String? id;
  Customer? customer;
  String? date;
  String? driverGender;
  num? driverRating;
  String? startRideTime;
  String? totalDistance;
  String? endRideTime;
  String? createdAt;
  String? updatedAt;
  int? v;
  Driver? driver;
  Set<Marker> markers = {};
  Set<Polyline>? polylines;

  BookingData({
    this.pickupLocation,
    this.dropLocation,
    this.pickupAddress,
    this.destinationAddress,
    this.pickupLatitude,
    this.pickupLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.city,
    this.state,
    this.country,
    this.landmark,
    this.houseNo,
    this.vehicleNumber,
    this.vehicleColor,
    this.amount,
    this.status,
    this.rideType,
    this.bookForSelf,
    this.otp,
    this.id,
    this.customer,
    this.date,
    this.driverGender,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.driver,
  });

  BookingData.fromJson(Map<String, dynamic> json) {
    pickupLocation = json["pickupLocation"] == null
        ? null
        : PickupLocation.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null
        ? null
        : DropLocation.fromJson(json["dropLocation"]);
    pickupAddress = json["pickupAddress"];
    destinationAddress = json["destinationAddress"];
    pickupLatitude = json["pickupLatitude"] is int
        ? json['pickupLatitude'].toDouble()
        : json['pickupLatitude'];
    pickupLongitude = json["pickupLongitude"] is int
        ? json['pickupLongitude'].toDouble()
        : json['pickupLongitude'];
    destinationLatitude = json["destinationLatitude"] is int
        ? json['destinationLatitude'].toDouble()
        : json['destinationLatitude'];
    destinationLongitude = json["destinationLongitude"] is int
        ? json['destinationLongitude'].toDouble()
        : json['destinationLongitude'];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    landmark = json["landmark"];
    houseNo = json["house_no"];
    vehicleNumber = json["vehicleNumber"];
    vehicleColor = json["vehicleColor"];
    amount = json["amount"];
    status = json["status"];
    rideType = json["rideType"];
    carType = json["carType"] == null ? "" : json["carType"].toString();
    perMileAmount =
        json["perMileAmount"] == null ? "0" : json["perMileAmount"].toString();
    seatCapacity = json["seatCapacity"].toString();
    bookForSelf = json["book_for_self"];
    otp = json["otp"];
    id = json["_id"];
    customer =
        json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    date = json["date"];
    driverGender = json["driver_gender"];
    driverRating = json["driver_rating"];
    totalDistance =
        json["totalDistance"] == null ? "0" : json["totalDistance"].toString();
    startRideTime = json["start_ride_time"];
    endRideTime = json["end_ride_time"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if (dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["pickupAddress"] = pickupAddress;
    _data["destinationAddress"] = destinationAddress;
    _data["pickupLatitude"] = pickupLatitude;
    _data["pickupLongitude"] = pickupLongitude;
    _data["destinationLatitude"] = destinationLatitude;
    _data["destinationLongitude"] = destinationLongitude;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["landmark"] = landmark;
    _data["house_no"] = houseNo;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleColor"] = vehicleColor;
    _data["amount"] = amount;
    _data["status"] = status;
    _data["rideType"] = rideType;
    _data["book_for_self"] = bookForSelf;
    _data["otp"] = otp;
    _data["_id"] = id;
    if (customer != null) {
      _data["customer"] = customer?.toJson();
    }
    _data["date"] = date;
    _data["driver_gender"] = driverGender;
    _data["driver_rating"] = driverRating;
    _data["totalDistance"] = totalDistance;
    _data["start_ride_time"] = startRideTime;
    _data["end_ride_time"] = endRideTime;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    if (driver != null) {
      _data["driver"] = driver?.toJson();
    }
    return _data;
  }
}

class Driver {
  UserLocation1? userLocation;
  String? gender;
  int? age;
  bool? isActive;
  bool? isDeleted;
  String? otp;
  int? creditLimit;
  String? language;
  String? type;
  dynamic profilePic;
  dynamic description;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isApprove;
  bool? isSubscription;
  int? experience;
  String? loginType;
  String? deviceType;
  dynamic country;
  dynamic endDate;
  String? voipToken;
  bool? isCar;
  double? latitude;
  double? longitude;
  String? deviceToken;
  dynamic socialId;
  dynamic myReferralCode;
  dynamic referByCode;
  dynamic accountId;
  bool? isVerify;
  bool? isOnline;
  String? bankAccountDocument;
  String? drivingLicence;
  dynamic drivingLicenceBack;
  String? govermentId;
  String? id;
  String? userId;
  String? email;
  String? password;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? countryCode;
  String? mobileNumber;
  String? profileImage;
  String? userName;
  int? cityId;

  Driver(
      {this.userLocation,
      this.gender,
      this.age,
      this.isActive,
      this.isDeleted,
      this.otp,
      this.creditLimit,
      this.language,
      this.type,
      this.profilePic,
      this.description,
      this.isProfileCompleted,
      this.isNotification,
      this.isApprove,
      this.isSubscription,
      this.experience,
      this.loginType,
      this.deviceType,
      this.country,
      this.endDate,
      this.voipToken,
      this.isCar,
      this.latitude,
      this.longitude,
      this.deviceToken,
      this.socialId,
      this.myReferralCode,
      this.referByCode,
      this.accountId,
      this.isVerify,
      this.isOnline,
      this.bankAccountDocument,
      this.drivingLicence,
      this.drivingLicenceBack,
      this.govermentId,
      this.id,
      this.userId,
      this.email,
      this.password,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.countryCode,
      this.mobileNumber,
      this.profileImage,
      this.userName,
      this.cityId});

  Driver.fromJson(Map<String, dynamic> json) {
    userLocation = json["user_location"] == null
        ? null
        : UserLocation1.fromJson(json["user_location"]);
    gender = json["gender"];
    age = json["age"];
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    otp = json["otp"];
    creditLimit = json["creditLimit"];
    language = json["language"];
    type = json["type"];
    profilePic = json["profilePic"];
    description = json["description"];
    isProfileCompleted = json["isProfileCompleted"];
    isNotification = json["is_notification"];
    isApprove = json["isApprove"];
    isSubscription = json["isSubscription"];
    experience = json["experience"];
    loginType = json["loginType"];
    deviceType = json["deviceType"];
    country = json["country"];
    endDate = json["endDate"];
    voipToken = json["voipToken"];
    isCar = json["isCar"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    deviceToken = json["deviceToken"];
    socialId = json["socialId"];
    myReferralCode = json["myReferralCode"];
    referByCode = json["referByCode"];
    accountId = json["accountId"];
    isVerify = json["isVerify"];
    isOnline = json["isOnline"];
    bankAccountDocument = json["bankAccountDocument"];
    drivingLicence = json["drivingLicence"];
    drivingLicenceBack = json["drivingLicenceBack"];
    govermentId = json["govermentId"];
    id = json["_id"];
    userId = json["userId"];
    email = json["email"];
    password = json["password"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    countryCode = json["countryCode"];
    mobileNumber = json["mobileNumber"];
    profileImage = json["profileImage"];
    userName = json["userName"];
    cityId = json["city_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (userLocation != null) {
      _data["user_location"] = userLocation?.toJson();
    }
    _data["gender"] = gender;
    _data["age"] = age;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["otp"] = otp;
    _data["creditLimit"] = creditLimit;
    _data["language"] = language;
    _data["type"] = type;
    _data["profilePic"] = profilePic;
    _data["description"] = description;
    _data["isProfileCompleted"] = isProfileCompleted;
    _data["is_notification"] = isNotification;
    _data["isApprove"] = isApprove;
    _data["isSubscription"] = isSubscription;
    _data["experience"] = experience;
    _data["loginType"] = loginType;
    _data["deviceType"] = deviceType;
    _data["country"] = country;
    _data["endDate"] = endDate;
    _data["voipToken"] = voipToken;
    _data["isCar"] = isCar;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["deviceToken"] = deviceToken;
    _data["socialId"] = socialId;
    _data["myReferralCode"] = myReferralCode;
    _data["referByCode"] = referByCode;
    _data["accountId"] = accountId;
    _data["isVerify"] = isVerify;
    _data["isOnline"] = isOnline;
    _data["bankAccountDocument"] = bankAccountDocument;
    _data["drivingLicence"] = drivingLicence;
    _data["drivingLicenceBack"] = drivingLicenceBack;
    _data["govermentId"] = govermentId;
    _data["_id"] = id;
    _data["userId"] = userId;
    _data["email"] = email;
    _data["password"] = password;
    _data["name"] = name;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["countryCode"] = countryCode;
    _data["mobileNumber"] = mobileNumber;
    _data["profileImage"] = profileImage;
    _data["userName"] = userName;
    _data["city_id"] = cityId;
    return _data;
  }
}

class UserLocation1 {
  String? type;
  List<double>? coordinates;

  UserLocation1({this.type, this.coordinates});

  UserLocation1.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null
        ? null
        : List<double>.from(json["coordinates"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if (coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}

class Customer {
  UserLocation? userLocation;
  String? gender;
  int? age;
  bool? isActive;
  bool? isDeleted;
  String? otp;
  int? creditLimit;
  String? language;
  String? type;
  dynamic profilePic;
  dynamic description;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isApprove;
  bool? isSubscription;
  int? experience;
  String? loginType;
  String? deviceType;
  dynamic country;
  dynamic endDate;
  String? voipToken;
  bool? isCar;
  dynamic latitude;
  dynamic longitude;
  String? deviceToken;
  dynamic socialId;
  dynamic myReferralCode;
  dynamic referByCode;
  dynamic accountId;
  bool? isVerify;
  bool? isOnline;
  dynamic bankAccountDocument;
  dynamic drivingLicence;
  dynamic drivingLicenceBack;
  dynamic govermentId;
  String? id;
  String? profileImage;
  String? userId;
  String? email;
  String? password;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? countryCode;
  String? mobileNumber;
  String? address;
  String? userName;

  Customer(
      {this.userLocation,
      this.gender,
      this.age,
      this.isActive,
      this.isDeleted,
      this.otp,
      this.creditLimit,
      this.language,
      this.type,
      this.profilePic,
      this.description,
      this.isProfileCompleted,
      this.isNotification,
      this.isApprove,
      this.isSubscription,
      this.experience,
      this.loginType,
      this.deviceType,
      this.country,
      this.endDate,
      this.voipToken,
      this.isCar,
      this.latitude,
      this.longitude,
      this.deviceToken,
      this.socialId,
      this.myReferralCode,
      this.referByCode,
      this.accountId,
      this.isVerify,
      this.isOnline,
      this.bankAccountDocument,
      this.drivingLicence,
      this.drivingLicenceBack,
      this.govermentId,
      this.id,
      this.profileImage,
      this.userId,
      this.email,
      this.password,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.countryCode,
      this.mobileNumber,
      this.address,
      this.userName});

  Customer.fromJson(Map<String, dynamic> json) {
    userLocation = json["user_location"] == null
        ? null
        : UserLocation.fromJson(json["user_location"]);
    gender = json["gender"];
    age = json["age"];
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    otp = json["otp"];
    creditLimit = json["creditLimit"];
    language = json["language"];
    type = json["type"];
    profilePic = json["profilePic"];
    description = json["description"];
    isProfileCompleted = json["isProfileCompleted"];
    isNotification = json["is_notification"];
    isApprove = json["isApprove"];
    isSubscription = json["isSubscription"];
    experience = json["experience"];
    loginType = json["loginType"];
    deviceType = json["deviceType"];
    country = json["country"];
    endDate = json["endDate"];
    voipToken = json["voipToken"];
    isCar = json["isCar"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    deviceToken = json["deviceToken"];
    socialId = json["socialId"];
    myReferralCode = json["myReferralCode"];
    referByCode = json["referByCode"];
    accountId = json["accountId"];
    isVerify = json["isVerify"];
    isOnline = json["isOnline"];
    bankAccountDocument = json["bankAccountDocument"];
    drivingLicence = json["drivingLicence"];
    drivingLicenceBack = json["drivingLicenceBack"];
    govermentId = json["govermentId"];
    id = json["_id"];
    profileImage = json["profileImage"];
    userId = json["userId"];
    email = json["email"];
    password = json["password"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    countryCode = json["countryCode"];
    mobileNumber = json["mobileNumber"];
    address = json["address"];
    userName = json["userName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (userLocation != null) {
      _data["user_location"] = userLocation?.toJson();
    }
    _data["gender"] = gender;
    _data["age"] = age;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["otp"] = otp;
    _data["creditLimit"] = creditLimit;
    _data["language"] = language;
    _data["type"] = type;
    _data["profilePic"] = profilePic;
    _data["description"] = description;
    _data["isProfileCompleted"] = isProfileCompleted;
    _data["is_notification"] = isNotification;
    _data["isApprove"] = isApprove;
    _data["isSubscription"] = isSubscription;
    _data["experience"] = experience;
    _data["loginType"] = loginType;
    _data["deviceType"] = deviceType;
    _data["country"] = country;
    _data["endDate"] = endDate;
    _data["voipToken"] = voipToken;
    _data["isCar"] = isCar;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["deviceToken"] = deviceToken;
    _data["socialId"] = socialId;
    _data["myReferralCode"] = myReferralCode;
    _data["referByCode"] = referByCode;
    _data["accountId"] = accountId;
    _data["isVerify"] = isVerify;
    _data["isOnline"] = isOnline;
    _data["bankAccountDocument"] = bankAccountDocument;
    _data["drivingLicence"] = drivingLicence;
    _data["drivingLicenceBack"] = drivingLicenceBack;
    _data["govermentId"] = govermentId;
    _data["_id"] = id;
    _data["profileImage"] = profileImage;
    _data["userId"] = userId;
    _data["email"] = email;
    _data["password"] = password;
    _data["name"] = name;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["countryCode"] = countryCode;
    _data["mobileNumber"] = mobileNumber;
    _data["address"] = address;
    _data["userName"] = userName;
    return _data;
  }
}

class UserLocation {
  String? type;
  List<double>? coordinates;

  UserLocation({this.type, this.coordinates});

  UserLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null
        ? null
        : (json['coordinates'] as List)
            .map<double>((e) => double.parse(e.toString()))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if (coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}

class DropLocation {
  String? type;
  List<double>? coordinates;

  DropLocation({this.type, this.coordinates});

  DropLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null
        ? null
        : (json['coordinates'] as List)
            .map<double>((e) => double.parse(e.toString()))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if (coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}

class PickupLocation {
  String? type;
  List<double>? coordinates;

  PickupLocation({this.type, this.coordinates});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null
        ? null
        : (json['coordinates'] as List)
            .map<double>((e) => double.parse(e.toString()))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if (coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}
