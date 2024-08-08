
class ReceiveStatusUpdateModel {
  int? status;
  String? message;
  Data? data;

  ReceiveStatusUpdateModel({this.status, this.message, this.data});

  ReceiveStatusUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  PickupLocation? pickupLocation;
  DropLocation? dropLocation;
  String? pickupAddress;
  String? destinationAddress;
  double? pickupLatitude;
  double? pickupLongitude;
  double? destinationLatitude;
  double? destinationLongitude;
  String? status;
  String? rideType;
  bool? bookForSelf;
  String? id;
  String? otp;
  String? customer;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? driverGender;
  String? driver;

  Data({this.pickupLocation,this.otp, this.dropLocation, this.pickupAddress, this.destinationAddress, this.pickupLatitude, this.pickupLongitude, this.destinationLatitude, this.destinationLongitude, this.status, this.rideType, this.bookForSelf, this.id, this.customer, this.createdAt, this.updatedAt, this.v, this.driverGender, this.driver});

  Data.fromJson(Map<String, dynamic> json) {
    pickupLocation = json["pickupLocation"] == null ? null : PickupLocation.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null ? null : DropLocation.fromJson(json["dropLocation"]);
    pickupAddress = json["pickupAddress"];
    otp = json["otp"].toString();
    destinationAddress = json["destinationAddress"];
    pickupLatitude = json["pickupLatitude"];
    pickupLongitude = json["pickupLongitude"];
    destinationLatitude = json["destinationLatitude"];
    destinationLongitude = json["destinationLongitude"];
    status = json["status"];
    rideType = json["rideType"];
    bookForSelf = json["book_for_self"];
    id = json["_id"];
    customer = json["customer"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    driverGender = json["driver_gender"];
    driver = json["driver"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if(dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["otp"] = otp;
    _data["pickupAddress"] = pickupAddress;
    _data["destinationAddress"] = destinationAddress;
    _data["pickupLatitude"] = pickupLatitude;
    _data["pickupLongitude"] = pickupLongitude;
    _data["destinationLatitude"] = destinationLatitude;
    _data["destinationLongitude"] = destinationLongitude;
    _data["status"] = status;
    _data["rideType"] = rideType;
    _data["book_for_self"] = bookForSelf;
    _data["_id"] = id;
    _data["customer"] = customer;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["driver_gender"] = driverGender;
    _data["driver"] = driver;
    return _data;
  }
}

class DropLocation {
  String? type;
  List<double>? coordinates;

  DropLocation({this.type, this.coordinates});

  DropLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null ? null : List<double>.from(json["coordinates"]);
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
  List<double>? coordinates;

  PickupLocation({this.type, this.coordinates});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null ? null : List<double>.from(json["coordinates"]);
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