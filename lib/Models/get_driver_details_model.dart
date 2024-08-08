
class GetDriverDetailsModel {
  int? status;
  String? statusText;
  String? message;
  DriverData? data;
  int? exeTime;

  GetDriverDetailsModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  GetDriverDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : DriverData.fromJson(json["data"]);
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

class DriverData {
  String? id;
  String? driverId;
  String? name;
  String? email;
  String? image;
  String? address;
  dynamic longitude;
  dynamic latitude;
  bool? isVerify;
  String? contact;
  String? about;
  CarDetails? carDetails;
  List<Review>? review;
  double? avgRating;
  int? totalReview;
  int? totalExp;
  int? totalCustomerRide;

  DriverData({this.id, this.name, this.email, this.image, this.address, this.longitude, this.latitude, this.isVerify, this.contact, this.about, this.carDetails, this.review, this.avgRating, this.totalReview, this.totalExp, this.totalCustomerRide});

  DriverData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    driverId = json["driverId"];
    name = json["name"];
    email = json["email"];
    image = json["image"];
    address = json["address"];
    longitude = json["longitude"];
    latitude = json["latitude"];
    isVerify = json["isVerify"];
    contact = json["contact"];
    about = json["about"];
    carDetails = json["carDetails"] == null ? null : CarDetails.fromJson(json["carDetails"]);
    review = json["review"] == null ? null : (json["review"] as List).map((e) => Review.fromJson(e)).toList();
    avgRating = json["avg_rating"];
    totalReview = json["total_review"];
    totalExp = json["total_exp"];
    totalCustomerRide = json["total_customer_ride"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["image"] = image;
    _data["address"] = address;
    _data["longitude"] = longitude;
    _data["latitude"] = latitude;
    _data["isVerify"] = isVerify;
    _data["contact"] = contact;
    _data["about"] = about;
    if(carDetails != null) {
      _data["carDetails"] = carDetails?.toJson();
    }
    if(review != null) {
      _data["review"] = review?.map((e) => e.toJson()).toList();
    }
    _data["avg_rating"] = avgRating;
    _data["total_review"] = totalReview;
    _data["total_exp"] = totalExp;
    _data["total_customer_ride"] = totalCustomerRide;
    return _data;
  }
}

class Review {
  String? userName;
  String? userImage;
  String? rating;
  String? isVerify;
  String? description;
  String? reviewDate;

  Review({this.userName, this.userImage, this.rating, this.isVerify, this.description, this.reviewDate});

  Review.fromJson(Map<String, dynamic> json) {
    userName = json["userName"];
    userImage = json["user_image"];
    rating = json["rating"];
    isVerify = json["is_verify"];
    description = json["description"];
    reviewDate = json["review_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userName"] = userName;
    _data["user_image"] = userImage;
    _data["rating"] = rating;
    _data["is_verify"] = isVerify;
    _data["description"] = description;
    _data["review_date"] = reviewDate;
    return _data;
  }
}

class CarDetails {
  String? carModel;
  String? carNumber;
  String? carColor;

  CarDetails({this.carModel, this.carNumber, this.carColor});

  CarDetails.fromJson(Map<String, dynamic> json) {
    carModel = json["carModel"];
    carNumber = json["carNumber"];
    carColor = json["carColor"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["carModel"] = carModel;
    _data["carNumber"] = carNumber;
    _data["carColor"] = carColor;
    return _data;
  }
}