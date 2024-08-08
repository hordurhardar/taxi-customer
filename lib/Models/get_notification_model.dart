
class GetNotificationModel {
  int? status;
  String? statusText;
  String? message;
  NotificationData? data;
  int? exeTime;

  GetNotificationModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : NotificationData.fromJson(json["data"]);
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

class NotificationData {
  List<NotificationListDocs>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  NotificationData({this.docs, this.totalDocs, this.limit, this.page, this.totalPages, this.pagingCounter, this.hasPrevPage, this.hasNextPage, this.prevPage, this.nextPage});

  NotificationData.fromJson(Map<String, dynamic> json) {
    docs = json["docs"] == null ? null : (json["docs"] as List).map((e) => NotificationListDocs.fromJson(e)).toList();
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

class NotificationListDocs {
  String? id;
  String? type;
  dynamic image;
  bool? allUser;
  bool? isRead;
  String? user;
  String? title;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? v;

  NotificationListDocs({this.id, this.type, this.image, this.allUser, this.isRead, this.user, this.title, this.message, this.createdAt, this.updatedAt, this.v});

  NotificationListDocs.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    type = json["type"];
    image = json["image"];
    allUser = json["allUser"];
    isRead = json["is_read"];
    user = json["user"];
    title = json["title"];
    message = json["message"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["type"] = type;
    _data["image"] = image;
    _data["allUser"] = allUser;
    _data["is_read"] = isRead;
    _data["user"] = user;
    _data["title"] = title;
    _data["message"] = message;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}