
import 'package:taxi/Models/get_profile_model.dart';

class UpdateProfileModel {
  int? status;
  String? statusText;
  String? message;
  ProfileData? data;
  int? exeTime;

  UpdateProfileModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : ProfileData.fromJson(json["data"]);
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