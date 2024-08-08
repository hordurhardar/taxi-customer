
class GetTipAmountModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetTipAmountModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  GetTipAmountModel.fromJson(Map<String, dynamic> json) {
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
  List<TipData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => TipData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class TipData {
  bool? isStatus;
  String? id;
  dynamic amount;
  String? createdAt;
  String? updatedAt;
  int? v;

  TipData({this.isStatus, this.id, this.amount, this.createdAt, this.updatedAt, this.v});

  TipData.fromJson(Map<String, dynamic> json) {
    isStatus = json["is_status"];
    id = json["_id"];
    amount = json["amount"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_status"] = isStatus;
    _data["_id"] = id;
    _data["amount"] = amount;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}