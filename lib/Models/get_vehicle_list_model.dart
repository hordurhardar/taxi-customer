
class GetVehicleListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetVehicleListModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  GetVehicleListModel.fromJson(Map<String, dynamic> json) {
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
  List<VehicleData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => VehicleData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class VehicleData {
  String? id;
  String? userId;
  String? vehicleId;
  int? seatCapacity;
  String? vehicleType;
  String? vehicleImage;
  dynamic vehiclePrice;
  bool isSelected = false;

  VehicleData({this.id, this.userId, this.vehicleId, this.seatCapacity, this.vehicleType, this.vehicleImage, this.vehiclePrice});

  VehicleData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["user_id"];
    vehicleId = json["vehicle_id"];
    seatCapacity = json["seat_capacity"];
    vehicleType = json["vehicle_type"];
    vehicleImage = json["vehicle_image"];
    vehiclePrice = json["vehicle_price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["user_id"] = userId;
    _data["vehicle_id"] = vehicleId;
    _data["seat_capacity"] = seatCapacity;
    _data["vehicle_type"] = vehicleType;
    _data["vehicle_image"] = vehicleImage;
    _data["vehicle_price"] = vehiclePrice;
    return _data;
  }
}