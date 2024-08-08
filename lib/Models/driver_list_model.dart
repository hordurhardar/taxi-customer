
class DriverListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  DriverListModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  DriverListModel.fromJson(Map<String, dynamic> json) {
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
  List<DriverData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => DriverData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class DriverData {
  String? gender;
  int? age;
  bool? isActive;
  bool? isDeleted;
  dynamic otp;
  int? creditLimit;
  String? language;
  String? type;
  dynamic profilePic;
  dynamic description;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isApprove;
  bool? isSubscription;
  int? experience;
  String? loginType;
  String? deviceType;
  dynamic country;
  dynamic endDate;
  dynamic voipToken;
  dynamic latitude;
  dynamic longitude;
  dynamic deviceToken;
  dynamic socialId;
  dynamic myReferralCode;
  dynamic referByCode;
  dynamic accountId;
  bool? isVerify;
  dynamic profileImage;
  dynamic bankAccountDocument;
  dynamic drivingLicence;
  dynamic govermentId;
  String? id;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? name;
  String? userName;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? v;

  DriverData({this.gender, this.age, this.isActive, this.isDeleted, this.otp, this.creditLimit, this.language, this.type, this.profilePic, this.description, this.isProfileCompleted, this.isNotification, this.isApprove, this.isSubscription, this.experience, this.loginType, this.deviceType, this.country, this.endDate, this.voipToken, this.latitude, this.longitude, this.deviceToken, this.socialId, this.myReferralCode, this.referByCode, this.accountId, this.isVerify, this.profileImage, this.bankAccountDocument, this.drivingLicence, this.govermentId, this.id, this.email, this.mobileNumber, this.countryCode, this.name, this.userName, this.password, this.createdAt, this.updatedAt, this.v});

  DriverData.fromJson(Map<String, dynamic> json) {
    gender = json["gender"];
    age = json["age"];
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    otp = json["otp"];
    creditLimit = json["creditLimit"];
    language = json["language"];
    type = json["type"];
    profilePic = json["profilePic"];
    description = json["description"];
    isProfileCompleted = json["isProfileCompleted"];
    isNotification = json["is_notification"];
    isApprove = json["isApprove"];
    isSubscription = json["isSubscription"];
    experience = json["experience"];
    loginType = json["loginType"];
    deviceType = json["deviceType"];
    country = json["country"];
    endDate = json["endDate"];
    voipToken = json["voipToken"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    deviceToken = json["deviceToken"];
    socialId = json["socialId"];
    myReferralCode = json["myReferralCode"];
    referByCode = json["referByCode"];
    accountId = json["accountId"];
    isVerify = json["isVerify"];
    profileImage = json["profileImage"];
    bankAccountDocument = json["bankAccountDocument"];
    drivingLicence = json["drivingLicence"];
    govermentId = json["govermentId"];
    id = json["_id"];
    email = json["email"];
    mobileNumber = json["mobileNumber"];
    countryCode = json["countryCode"];
    name = json["name"];
    userName = json["userName"];
    password = json["password"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["gender"] = gender;
    _data["age"] = age;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["otp"] = otp;
    _data["creditLimit"] = creditLimit;
    _data["language"] = language;
    _data["type"] = type;
    _data["profilePic"] = profilePic;
    _data["description"] = description;
    _data["isProfileCompleted"] = isProfileCompleted;
    _data["is_notification"] = isNotification;
    _data["isApprove"] = isApprove;
    _data["isSubscription"] = isSubscription;
    _data["experience"] = experience;
    _data["loginType"] = loginType;
    _data["deviceType"] = deviceType;
    _data["country"] = country;
    _data["endDate"] = endDate;
    _data["voipToken"] = voipToken;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["deviceToken"] = deviceToken;
    _data["socialId"] = socialId;
    _data["myReferralCode"] = myReferralCode;
    _data["referByCode"] = referByCode;
    _data["accountId"] = accountId;
    _data["isVerify"] = isVerify;
    _data["profileImage"] = profileImage;
    _data["bankAccountDocument"] = bankAccountDocument;
    _data["drivingLicence"] = drivingLicence;
    _data["govermentId"] = govermentId;
    _data["_id"] = id;
    _data["email"] = email;
    _data["mobileNumber"] = mobileNumber;
    _data["countryCode"] = countryCode;
    _data["name"] = name;
    _data["userName"] = userName;
    _data["password"] = password;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}