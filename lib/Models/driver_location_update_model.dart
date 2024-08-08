
class DriverLocationUpdateModel {
  int? status;
  String? message;
  Data? data;

  DriverLocationUpdateModel({this.status, this.message, this.data});

  DriverLocationUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  UserLocation? userLocation;
  String? gender;
  int? age;
  bool? isActive;
  bool? isDeleted;
  String? otp;
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
  String? voipToken;
  bool? isCar;
  dynamic latitude;
  dynamic longitude;
  String? deviceToken;
  dynamic socialId;
  dynamic myReferralCode;
  dynamic referByCode;
  dynamic accountId;
  bool? isVerify;
  bool? isOnline;
  String? bankAccountDocument;
  String? drivingLicence;
  dynamic drivingLicenceBack;
  String? govermentId;
  String? id;
  String? userId;
  String? email;
  String? password;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? cityId;
  String? countryCode;
  String? mobileNumber;
  String? profileImage;

  Data({this.userLocation, this.gender, this.age, this.isActive, this.isDeleted, this.otp, this.creditLimit, this.language, this.type, this.profilePic, this.description, this.isProfileCompleted, this.isNotification, this.isApprove, this.isSubscription, this.experience, this.loginType, this.deviceType, this.country, this.endDate, this.voipToken, this.isCar, this.latitude, this.longitude, this.deviceToken, this.socialId, this.myReferralCode, this.referByCode, this.accountId, this.isVerify, this.isOnline, this.bankAccountDocument, this.drivingLicence, this.drivingLicenceBack, this.govermentId, this.id, this.userId, this.email, this.password, this.name, this.createdAt, this.updatedAt, this.v, this.cityId, this.countryCode, this.mobileNumber, this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    userLocation = json["user_location"] == null ? null : UserLocation.fromJson(json["user_location"]);
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
    isCar = json["isCar"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    deviceToken = json["deviceToken"];
    socialId = json["socialId"];
    myReferralCode = json["myReferralCode"];
    referByCode = json["referByCode"];
    accountId = json["accountId"];
    isVerify = json["isVerify"];
    isOnline = json["isOnline"];
    bankAccountDocument = json["bankAccountDocument"];
    drivingLicence = json["drivingLicence"];
    drivingLicenceBack = json["drivingLicenceBack"];
    govermentId = json["govermentId"];
    id = json["_id"];
    userId = json["userId"];
    email = json["email"];
    password = json["password"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    cityId = json["city_id"];
    countryCode = json["countryCode"];
    mobileNumber = json["mobileNumber"];
    profileImage = json["profileImage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(userLocation != null) {
      _data["user_location"] = userLocation?.toJson();
    }
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
    _data["isCar"] = isCar;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["deviceToken"] = deviceToken;
    _data["socialId"] = socialId;
    _data["myReferralCode"] = myReferralCode;
    _data["referByCode"] = referByCode;
    _data["accountId"] = accountId;
    _data["isVerify"] = isVerify;
    _data["isOnline"] = isOnline;
    _data["bankAccountDocument"] = bankAccountDocument;
    _data["drivingLicence"] = drivingLicence;
    _data["drivingLicenceBack"] = drivingLicenceBack;
    _data["govermentId"] = govermentId;
    _data["_id"] = id;
    _data["userId"] = userId;
    _data["email"] = email;
    _data["password"] = password;
    _data["name"] = name;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["city_id"] = cityId;
    _data["countryCode"] = countryCode;
    _data["mobileNumber"] = mobileNumber;
    _data["profileImage"] = profileImage;
    return _data;
  }
}

class UserLocation {
  String? type;
  List<dynamic>? coordinates;

  UserLocation({this.type, this.coordinates});

  UserLocation.fromJson(Map<String, dynamic> json) {
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