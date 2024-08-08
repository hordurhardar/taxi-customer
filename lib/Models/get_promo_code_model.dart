
class GetPromoCodeModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetPromoCodeModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  GetPromoCodeModel.fromJson(Map<String, dynamic> json) {
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
  List<PromoCodeData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => PromoCodeData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class PromoCodeData {
  String? type;
  int? noOfUse;
  int? noOfUser;
  bool? isActive;
  int? percentage;
  int? maxAmount;
  int? minAmount;
  String? id;
  String? promoCode;
  String? description;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? v;

  PromoCodeData({this.type, this.noOfUse, this.noOfUser, this.isActive, this.percentage, this.maxAmount, this.minAmount, this.id, this.promoCode, this.description, this.title, this.createdAt, this.updatedAt, this.v});

  PromoCodeData.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    noOfUse = json["noOfUse"];
    noOfUser = json["noOfUser"];
    isActive = json["is_active"];
    percentage = json["percentage"];
    maxAmount = json["maxAmount"];
    minAmount = json["minAmount"];
    id = json["_id"];
    promoCode = json["promoCode"];
    description = json["description"];
    title = json["title"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["noOfUse"] = noOfUse;
    _data["noOfUser"] = noOfUser;
    _data["is_active"] = isActive;
    _data["percentage"] = percentage;
    _data["maxAmount"] = maxAmount;
    _data["minAmount"] = minAmount;
    _data["_id"] = id;
    _data["promoCode"] = promoCode;
    _data["description"] = description;
    _data["title"] = title;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}