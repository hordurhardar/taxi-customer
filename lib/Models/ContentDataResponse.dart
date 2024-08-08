import 'content_response.dart';

class ContentDataResponse {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  ContentDataResponse(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  ContentDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    exeTime = json['exeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['exeTime'] = this.exeTime;
    return data;
  }
}

class Data {
  List<ContentList>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ContentList>[];
      json['data'].forEach((v) {
        data!.add(new ContentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


