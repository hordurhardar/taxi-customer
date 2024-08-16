
class CommonModel {
  int? status;
  String? statusText;
  String? message;
  dynamic data;
  int? exeTime;

  CommonModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  CommonModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"];
    exeTime = json["exeTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["statusText"] = statusText;
    _data["message"] = message;
    _data["data"] = data;
    _data["exeTime"] = exeTime;
    return _data;
  }
}