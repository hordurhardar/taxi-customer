class ImageUploadModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  ImageUploadModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  ImageUploadModel.fromJson(Map<String, dynamic> json) {
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
  String? upload;

  Data({this.upload});

  Data.fromJson(Map<String, dynamic> json) {
    upload = json["upload"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["upload"] = upload;
    return _data;
  }
}
