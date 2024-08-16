
class PreBookRideListModel {
  dynamic status;
  String? statusText;
  String? message;
  Data? data;
  dynamic exeTime;

  PreBookRideListModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  PreBookRideListModel.fromJson(Map<String, dynamic> json) {
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
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["exeTime"] = exeTime;
    return _data;
  }
}

class Data {
  ListData? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : ListData.fromJson(json["list"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(list != null) {
      _data["list"] = list?.toJson();
    }
    return _data;
  }
}

class ListData {
  List<ListDocs>? docs;
  dynamic totalDocs;
  dynamic limit;
  dynamic page;
  dynamic totalPages;
  dynamic pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  ListData({this.docs, this.totalDocs, this.limit, this.page, this.totalPages, this.pagingCounter, this.hasPrevPage, this.hasNextPage, this.prevPage, this.nextPage});

  ListData.fromJson(Map<String, dynamic> json) {
    docs = json["docs"] == null ? null : (json["docs"] as List).map((e) => ListDocs.fromJson(e)).toList();
    totalDocs = json["totalDocs"];
    limit = json["limit"];
    page = json["page"];
    totalPages = json["totalPages"];
    pagingCounter = json["pagingCounter"];
    hasPrevPage = json["hasPrevPage"];
    hasNextPage = json["hasNextPage"];
    prevPage = json["prevPage"];
    nextPage = json["nextPage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(docs != null) {
      _data["docs"] = docs?.map((e) => e.toJson()).toList();
    }
    _data["totalDocs"] = totalDocs;
    _data["limit"] = limit;
    _data["page"] = page;
    _data["totalPages"] = totalPages;
    _data["pagingCounter"] = pagingCounter;
    _data["hasPrevPage"] = hasPrevPage;
    _data["hasNextPage"] = hasNextPage;
    _data["prevPage"] = prevPage;
    _data["nextPage"] = nextPage;
    return _data;
  }
}

class ListDocs {
  String? id;
  String? pickupAddress;
  String? destinationAddress;
  dynamic pickupLatitude;
  dynamic pickupLongitude;
  dynamic customerMidlocation;
  dynamic customerMidLocationLat;
  dynamic customerMidLocationLong;
  dynamic destinationLatitude;
  dynamic destinationLongitude;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic landmark;
  dynamic houseNo;
  List<dynamic>? declineRideDriver;
  List<dynamic>? notificationSendUser;
  dynamic vehicleNumber;
  dynamic vehicleColor;
  dynamic amount;
  String? status;
  String? rideType;
  bool? bookForSelf;
  dynamic otp;
  bool? isPaid;
  dynamic time;
  dynamic perMileAmount;
  dynamic totalDistance;
  dynamic totalAmount;
  String? carType;
  String? seatCapacity;
  dynamic customerRating;
  dynamic driverRating;
  dynamic startRideTime;
  dynamic endRideTime;
  String? reason;
  String? crnNumber;
  dynamic otherPersonName;
  dynamic otherPersonContactNumber;
  bool? isSelf;
  dynamic dateTimeStamp;
  Customer? customer;
  String? date;
  String? driverGender;
  PickupLocation? pickupLocation;
  DropLocation? dropLocation;
  String? createdAt;
  String? updatedAt;
  dynamic v;

  ListDocs({this.id, this.pickupAddress, this.destinationAddress, this.pickupLatitude, this.pickupLongitude, this.customerMidlocation, this.customerMidLocationLat, this.customerMidLocationLong, this.destinationLatitude, this.destinationLongitude, this.city, this.state, this.country, this.landmark, this.houseNo, this.declineRideDriver, this.notificationSendUser, this.vehicleNumber, this.vehicleColor, this.amount, this.status, this.rideType, this.bookForSelf, this.otp, this.isPaid, this.time, this.perMileAmount, this.totalDistance, this.totalAmount, this.carType, this.seatCapacity, this.customerRating, this.driverRating, this.startRideTime, this.endRideTime, this.reason, this.crnNumber, this.otherPersonName, this.otherPersonContactNumber, this.isSelf, this.dateTimeStamp, this.customer, this.date, this.driverGender, this.pickupLocation, this.dropLocation, this.createdAt, this.updatedAt, this.v});

  ListDocs.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    pickupAddress = json["pickupAddress"];
    destinationAddress = json["destinationAddress"];
    pickupLatitude = json["pickupLatitude"];
    pickupLongitude = json["pickupLongitude"];
    customerMidlocation = json["customerMidlocation"];
    customerMidLocationLat = json["customerMidLocationLat"];
    customerMidLocationLong = json["customerMidLocationLong"];
    destinationLatitude = json["destinationLatitude"];
    destinationLongitude = json["destinationLongitude"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    landmark = json["landmark"];
    houseNo = json["house_no"];
    declineRideDriver = json["declineRideDriver"] ?? [];
    notificationSendUser = json["notificationSendUser"] ?? [];
    vehicleNumber = json["vehicleNumber"];
    vehicleColor = json["vehicleColor"];
    amount = json["amount"];
    status = json["status"];
    rideType = json["rideType"];
    bookForSelf = json["book_for_self"];
    otp = json["otp"];
    isPaid = json["isPaid"];
    time = json["time"];
    perMileAmount = json["perMileAmount"];
    totalDistance = json["totalDistance"];
    totalAmount = json["totalAmount"];
    carType = json["carType"];
    seatCapacity = json["seatCapacity"];
    customerRating = json["customer_rating"];
    driverRating = json["driver_rating"];
    startRideTime = json["start_ride_time"];
    endRideTime = json["end_ride_time"];
    reason = json["reason"];
    crnNumber = json["crnNumber"];
    otherPersonName = json["otherPersonName"];
    otherPersonContactNumber = json["otherPersonContactNumber"];
    isSelf = json["isSelf"];
    dateTimeStamp = json["dateTimeStamp"];
    customer = json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    date = json["date"];
    driverGender = json["driver_gender"];
    pickupLocation = json["pickupLocation"] == null ? null : PickupLocation.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null ? null : DropLocation.fromJson(json["dropLocation"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["pickupAddress"] = pickupAddress;
    _data["destinationAddress"] = destinationAddress;
    _data["pickupLatitude"] = pickupLatitude;
    _data["pickupLongitude"] = pickupLongitude;
    _data["customerMidlocation"] = customerMidlocation;
    _data["customerMidLocationLat"] = customerMidLocationLat;
    _data["customerMidLocationLong"] = customerMidLocationLong;
    _data["destinationLatitude"] = destinationLatitude;
    _data["destinationLongitude"] = destinationLongitude;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["landmark"] = landmark;
    _data["house_no"] = houseNo;
    if(declineRideDriver != null) {
      _data["declineRideDriver"] = declineRideDriver;
    }
    if(notificationSendUser != null) {
      _data["notificationSendUser"] = notificationSendUser;
    }
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleColor"] = vehicleColor;
    _data["amount"] = amount;
    _data["status"] = status;
    _data["rideType"] = rideType;
    _data["book_for_self"] = bookForSelf;
    _data["otp"] = otp;
    _data["isPaid"] = isPaid;
    _data["time"] = time;
    _data["perMileAmount"] = perMileAmount;
    _data["totalDistance"] = totalDistance;
    _data["totalAmount"] = totalAmount;
    _data["carType"] = carType;
    _data["seatCapacity"] = seatCapacity;
    _data["customer_rating"] = customerRating;
    _data["driver_rating"] = driverRating;
    _data["start_ride_time"] = startRideTime;
    _data["end_ride_time"] = endRideTime;
    _data["reason"] = reason;
    _data["crnNumber"] = crnNumber;
    _data["otherPersonName"] = otherPersonName;
    _data["otherPersonContactNumber"] = otherPersonContactNumber;
    _data["isSelf"] = isSelf;
    _data["dateTimeStamp"] = dateTimeStamp;
    if(customer != null) {
      _data["customer"] = customer?.toJson();
    }
    _data["date"] = date;
    _data["driver_gender"] = driverGender;
    if(pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if(dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class DropLocation {
  String? type;
  List<dynamic>? coordinates;

  DropLocation({this.type, this.coordinates});

  DropLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null ? null : List<dynamic>.from(json["coordinates"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if(coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}

class PickupLocation {
  String? type;
  List<dynamic>? coordinates;

  PickupLocation({this.type, this.coordinates});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null ? null : List<dynamic>.from(json["coordinates"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if(coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}

class Customer {
  String? id;
  UserLocation? userLocation;
  String? gender;
  dynamic age;
  bool? isActive;
  bool? isDeleted;
  String? otp;
  dynamic creditLimit;
  String? language;
  String? type;
  dynamic description;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isApprove;
  bool? isSubscription;
  dynamic experience;
  String? loginType;
  String? deviceType;
  dynamic country;
  dynamic endDate;
  String? voipToken;
  bool? isCar;
  bool? isCarAdded;
  dynamic latitude;
  dynamic longitude;
  String? deviceToken;
  dynamic socialId;
  dynamic myReferralCode;
  dynamic referByCode;
  dynamic accountId;
  dynamic socialSecurityNumber;
  bool? isVerify;
  bool? isOnline;
  bool? isActiveRide;
  dynamic bankAccountDocument;
  dynamic drivingLicence;
  dynamic drivingLicenceBack;
  dynamic govermentId;
  String? userId;
  String? email;
  String? password;
  String? name;
  String? countryCode;
  String? mobileNumber;
  String? createdAt;
  String? updatedAt;
  dynamic v;
  String? address;
  String? userName;

  Customer({this.id, this.userLocation, this.gender, this.age, this.isActive, this.isDeleted, this.otp, this.creditLimit, this.language, this.type, this.description, this.isProfileCompleted, this.isNotification, this.isApprove, this.isSubscription, this.experience, this.loginType, this.deviceType, this.country, this.endDate, this.voipToken, this.isCar, this.isCarAdded, this.latitude, this.longitude, this.deviceToken, this.socialId, this.myReferralCode, this.referByCode, this.accountId, this.socialSecurityNumber, this.isVerify, this.isOnline, this.isActiveRide, this.bankAccountDocument, this.drivingLicence, this.drivingLicenceBack, this.govermentId, this.userId, this.email, this.password, this.name, this.countryCode, this.mobileNumber, this.createdAt, this.updatedAt, this.v, this.address, this.userName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userLocation = json["user_location"] == null ? null : UserLocation.fromJson(json["user_location"]);
    gender = json["gender"];
    age = json["age"];
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    otp = json["otp"];
    creditLimit = json["creditLimit"];
    language = json["language"];
    type = json["type"];
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
    isCarAdded = json["isCarAdded"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    deviceToken = json["deviceToken"];
    socialId = json["socialId"];
    myReferralCode = json["myReferralCode"];
    referByCode = json["referByCode"];
    accountId = json["accountId"];
    socialSecurityNumber = json["socialSecurityNumber"];
    isVerify = json["isVerify"];
    isOnline = json["isOnline"];
    isActiveRide = json["isActiveRide"];
    bankAccountDocument = json["bankAccountDocument"];
    drivingLicence = json["drivingLicence"];
    drivingLicenceBack = json["drivingLicenceBack"];
    govermentId = json["govermentId"];
    userId = json["userId"];
    email = json["email"];
    password = json["password"];
    name = json["name"];
    countryCode = json["countryCode"];
    mobileNumber = json["mobileNumber"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    address = json["address"];
    userName = json["userName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if(userLocation != null) {
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
    _data["isCarAdded"] = isCarAdded;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["deviceToken"] = deviceToken;
    _data["socialId"] = socialId;
    _data["myReferralCode"] = myReferralCode;
    _data["referByCode"] = referByCode;
    _data["accountId"] = accountId;
    _data["socialSecurityNumber"] = socialSecurityNumber;
    _data["isVerify"] = isVerify;
    _data["isOnline"] = isOnline;
    _data["isActiveRide"] = isActiveRide;
    _data["bankAccountDocument"] = bankAccountDocument;
    _data["drivingLicence"] = drivingLicence;
    _data["drivingLicenceBack"] = drivingLicenceBack;
    _data["govermentId"] = govermentId;
    _data["userId"] = userId;
    _data["email"] = email;
    _data["password"] = password;
    _data["name"] = name;
    _data["countryCode"] = countryCode;
    _data["mobileNumber"] = mobileNumber;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["address"] = address;
    _data["userName"] = userName;
    return _data;
  }
}

class UserLocation {
  String? type;
  List<dynamic>? coordinates;

  UserLocation({this.type, this.coordinates});

  UserLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null ? null : List<dynamic>.from(json["coordinates"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if(coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}