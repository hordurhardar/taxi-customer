
class GetSavedAddressModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetSavedAddressModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  GetSavedAddressModel.fromJson(Map<String, dynamic> json) {
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
  List<SavedAddressData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => SavedAddressData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class SavedAddressData {
  Location? location;
  String? address;
  double? latitude;
  double? longitude;
  String? type;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic landmark;
  dynamic houseNo;
  dynamic street;
  String? addressType;
  bool? isDefault;
  String? id;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? v;

  SavedAddressData({this.location, this.address, this.latitude, this.longitude, this.type, this.city, this.state, this.country, this.landmark, this.houseNo, this.street, this.addressType, this.isDefault, this.id, this.user, this.createdAt, this.updatedAt, this.v});

  SavedAddressData.fromJson(Map<String, dynamic> json) {
    location = json["location"] == null ? null : Location.fromJson(json["location"]);
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    type = json["type"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    landmark = json["landmark"];
    houseNo = json["house_no"];
    street = json["street"];
    addressType = json["addressType"];
    isDefault = json["isDefault"];
    id = json["_id"];
    user = json["user"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    _data["address"] = address;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["type"] = type;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["landmark"] = landmark;
    _data["house_no"] = houseNo;
    _data["street"] = street;
    _data["addressType"] = addressType;
    _data["isDefault"] = isDefault;
    _data["_id"] = id;
    _data["user"] = user;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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