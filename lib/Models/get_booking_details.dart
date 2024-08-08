/// status : 200
/// statusText : "SUCCESS"
/// message : "List"
/// data : {"data":[{"pickupLocation":{"type":"Point","coordinates":[77.86316849291325,26.69662928094025]},"dropLocation":{"type":"Point","coordinates":[77.8631685,26.6966293]},"pickupAddress":"2/325,R.H.B. Yojna,Dholpur,Rajasthan","destinationAddress":"Anand Heights, R.H.B. Yojna, Dholpur, Rajasthan, India","pickupLatitude":26.69662928094025,"pickupLongitude":77.86316849291325,"customerMidlocation":null,"customerMidLocationLat":null,"customerMidLocationLong":null,"destinationLatitude":26.6966293,"destinationLongitude":77.8631685,"city":null,"state":null,"country":null,"landmark":null,"house_no":null,"declineRideDriver":[],"notificationSendUser":[],"vehicleNumber":null,"vehicleColor":null,"amount":null,"status":"Arriving","rideType":"Now","book_for_self":true,"otp":null,"isPaid":false,"time":null,"perMileAmount":null,"carType":null,"seatCapacity":null,"customer_rating":0,"driver_rating":0,"start_ride_time":"2024-05-16 13:50","end_ride_time":null,"reason":null,"crnNumber":"CRN6154342","_id":"66460f0db1e99f423eaf11ce","customer":{"user_location":{"type":"Point","coordinates":[-122.084,37.4219983]},"gender":"Male","age":0,"is_active":true,"is_deleted":false,"otp":"8045","creditLimit":0,"language":"en","type":"User","profilePic":null,"description":null,"isProfileCompleted":true,"is_notification":true,"isApprove":true,"isSubscription":false,"experience":0,"loginType":"Email","deviceType":"Android","country":null,"endDate":null,"voipToken":"","isCar":false,"latitude":37.4219983,"longitude":37.4219983,"deviceToken":"cRh_Z6B1T_i3fHpWK-K894:APA91bEtCvqWsRD3P_1tpGpY8mIUVbFILE2z_azChFMSzmRgoDiOlOAFuxM2--0RVd1UBVl4D62nqMK06lFzxZPxwZhjLXXzTjP4Uy-TQ7IuaY6A7QSrp5DkT0jp5yqnqFbhC8PxR-o9","socialId":null,"myReferralCode":null,"referByCode":null,"accountId":null,"isVerify":true,"isOnline":false,"isActiveRide":false,"bankAccountDocument":null,"drivingLicence":null,"drivingLicenceBack":null,"govermentId":null,"_id":"66459f60c15af4355a9c3933","userId":"8763448","email":"sagar.shrivastava@inventcolab.com","password":"$2b$10$VW5DNJZV95PJecvQlCMxl.kJDAMyG35QrB1YqF9QVKkM5eexmiK5e","name":"sagar","created_at":"2024-05-16T05:53:36.566Z","updated_at":"2024-05-16T13:47:52.287Z","__v":0,"countryCode":"39","mobileNumber":"7014051723","address":"1600 Amphitheatre Pkwy Building 43, ,Santa Clara County, 94043","userName":"sagar"},"date":"2024-05-16T13:50:01.508Z","driver_gender":"Male","created_at":"2024-05-16T13:50:05.332Z","updated_at":"2024-05-16T13:50:59.557Z","__v":0,"driver":{"user_location":{"type":"Point","coordinates":[77.8621554,26.6971201]},"gender":"Male","age":0,"is_active":true,"is_deleted":false,"otp":null,"creditLimit":0,"language":"en","type":"Driver","profilePic":null,"description":null,"isProfileCompleted":true,"is_notification":true,"isApprove":true,"isSubscription":false,"experience":0,"loginType":"Email","deviceType":"Android","country":null,"endDate":null,"voipToken":"","isCar":true,"latitude":26.6971201,"longitude":77.8621554,"deviceToken":"cOzYucnZQH-l-T_P2R2nzr:APA91bHxtzhNT5UGqkhFlFyCdvHTHI6hjgVqcbokeLpp25WWxOBAiYEj-wsrMaDhZB_7W3Iwe-0kY1u5BWX8uF0Yd-zCWi9qmR1BZAO1xwxOiQsrsQ9hgiLHWxNA9HyCCh3l3MCkiM9P","socialId":null,"myReferralCode":null,"referByCode":null,"accountId":null,"isVerify":true,"isOnline":true,"isActiveRide":true,"bankAccountDocument":"taxi/profile/c7db830c-582c-4a7e-b086-583ee8a42c0d.jpg1715596790229.jpg","drivingLicence":"taxi/profile/dd07ae01-c388-4a2c-a765-739d3845330c.jpg1715596812904.jpg","drivingLicenceBack":null,"govermentId":"taxi/profile/image_1714469175109.png","_id":"6630b718c2d7c431646453d0","userId":"4114913","email":"kamal123@yopmail.com","password":"$2b$10$15n0Osbh7m4EBw88t56UC.Y32wy4qV0tu8K0R9Dk89plvPDBMOymK","name":"Kamal","created_at":"2024-04-30T09:17:12.713Z","updated_at":"2024-05-16T13:50:59.557Z","__v":0,"countryCode":"91","mobileNumber":"8561028424","profileImage":"taxi/profile/D88D80A6-1B02-4BEC-AF71-BC7BF6040FD4.jpg1715838763240.jpg","userName":"Kamal","city_id":132201}}]}
/// exeTime : 2765400

class GetBookingDetails {
  GetBookingDetails({
      num? status, 
      String? statusText, 
      String? message, 
      Data? data, 
      num? exeTime,}){
    _status = status;
    _statusText = statusText;
    _message = message;
    _data = data;
    _exeTime = exeTime;
}

  GetBookingDetails.fromJson(dynamic json) {
    _status = json['status'];
    _statusText = json['statusText'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _exeTime = json['exeTime'];
  }
  num? _status;
  String? _statusText;
  String? _message;
  Data? _data;
  num? _exeTime;
GetBookingDetails copyWith({  num? status,
  String? statusText,
  String? message,
  Data? data,
  num? exeTime,
}) => GetBookingDetails(  status: status ?? _status,
  statusText: statusText ?? _statusText,
  message: message ?? _message,
  data: data ?? _data,
  exeTime: exeTime ?? _exeTime,
);
  num? get status => _status;
  String? get statusText => _statusText;
  String? get message => _message;
  Data? get data => _data;
  num? get exeTime => _exeTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusText'] = _statusText;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['exeTime'] = _exeTime;
    return map;
  }

}

/// data : [{"pickupLocation":{"type":"Point","coordinates":[77.86316849291325,26.69662928094025]},"dropLocation":{"type":"Point","coordinates":[77.8631685,26.6966293]},"pickupAddress":"2/325,R.H.B. Yojna,Dholpur,Rajasthan","destinationAddress":"Anand Heights, R.H.B. Yojna, Dholpur, Rajasthan, India","pickupLatitude":26.69662928094025,"pickupLongitude":77.86316849291325,"customerMidlocation":null,"customerMidLocationLat":null,"customerMidLocationLong":null,"destinationLatitude":26.6966293,"destinationLongitude":77.8631685,"city":null,"state":null,"country":null,"landmark":null,"house_no":null,"declineRideDriver":[],"notificationSendUser":[],"vehicleNumber":null,"vehicleColor":null,"amount":null,"status":"Arriving","rideType":"Now","book_for_self":true,"otp":null,"isPaid":false,"time":null,"perMileAmount":null,"carType":null,"seatCapacity":null,"customer_rating":0,"driver_rating":0,"start_ride_time":"2024-05-16 13:50","end_ride_time":null,"reason":null,"crnNumber":"CRN6154342","_id":"66460f0db1e99f423eaf11ce","customer":{"user_location":{"type":"Point","coordinates":[-122.084,37.4219983]},"gender":"Male","age":0,"is_active":true,"is_deleted":false,"otp":"8045","creditLimit":0,"language":"en","type":"User","profilePic":null,"description":null,"isProfileCompleted":true,"is_notification":true,"isApprove":true,"isSubscription":false,"experience":0,"loginType":"Email","deviceType":"Android","country":null,"endDate":null,"voipToken":"","isCar":false,"latitude":37.4219983,"longitude":37.4219983,"deviceToken":"cRh_Z6B1T_i3fHpWK-K894:APA91bEtCvqWsRD3P_1tpGpY8mIUVbFILE2z_azChFMSzmRgoDiOlOAFuxM2--0RVd1UBVl4D62nqMK06lFzxZPxwZhjLXXzTjP4Uy-TQ7IuaY6A7QSrp5DkT0jp5yqnqFbhC8PxR-o9","socialId":null,"myReferralCode":null,"referByCode":null,"accountId":null,"isVerify":true,"isOnline":false,"isActiveRide":false,"bankAccountDocument":null,"drivingLicence":null,"drivingLicenceBack":null,"govermentId":null,"_id":"66459f60c15af4355a9c3933","userId":"8763448","email":"sagar.shrivastava@inventcolab.com","password":"$2b$10$VW5DNJZV95PJecvQlCMxl.kJDAMyG35QrB1YqF9QVKkM5eexmiK5e","name":"sagar","created_at":"2024-05-16T05:53:36.566Z","updated_at":"2024-05-16T13:47:52.287Z","__v":0,"countryCode":"39","mobileNumber":"7014051723","address":"1600 Amphitheatre Pkwy Building 43, ,Santa Clara County, 94043","userName":"sagar"},"date":"2024-05-16T13:50:01.508Z","driver_gender":"Male","created_at":"2024-05-16T13:50:05.332Z","updated_at":"2024-05-16T13:50:59.557Z","__v":0,"driver":{"user_location":{"type":"Point","coordinates":[77.8621554,26.6971201]},"gender":"Male","age":0,"is_active":true,"is_deleted":false,"otp":null,"creditLimit":0,"language":"en","type":"Driver","profilePic":null,"description":null,"isProfileCompleted":true,"is_notification":true,"isApprove":true,"isSubscription":false,"experience":0,"loginType":"Email","deviceType":"Android","country":null,"endDate":null,"voipToken":"","isCar":true,"latitude":26.6971201,"longitude":77.8621554,"deviceToken":"cOzYucnZQH-l-T_P2R2nzr:APA91bHxtzhNT5UGqkhFlFyCdvHTHI6hjgVqcbokeLpp25WWxOBAiYEj-wsrMaDhZB_7W3Iwe-0kY1u5BWX8uF0Yd-zCWi9qmR1BZAO1xwxOiQsrsQ9hgiLHWxNA9HyCCh3l3MCkiM9P","socialId":null,"myReferralCode":null,"referByCode":null,"accountId":null,"isVerify":true,"isOnline":true,"isActiveRide":true,"bankAccountDocument":"taxi/profile/c7db830c-582c-4a7e-b086-583ee8a42c0d.jpg1715596790229.jpg","drivingLicence":"taxi/profile/dd07ae01-c388-4a2c-a765-739d3845330c.jpg1715596812904.jpg","drivingLicenceBack":null,"govermentId":"taxi/profile/image_1714469175109.png","_id":"6630b718c2d7c431646453d0","userId":"4114913","email":"kamal123@yopmail.com","password":"$2b$10$15n0Osbh7m4EBw88t56UC.Y32wy4qV0tu8K0R9Dk89plvPDBMOymK","name":"Kamal","created_at":"2024-04-30T09:17:12.713Z","updated_at":"2024-05-16T13:50:59.557Z","__v":0,"countryCode":"91","mobileNumber":"8561028424","profileImage":"taxi/profile/D88D80A6-1B02-4BEC-AF71-BC7BF6040FD4.jpg1715838763240.jpg","userName":"Kamal","city_id":132201}}]

class Data {
  Data({
      List<BookingData>? data,}){
    _data = data;
}

  Data.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BookingData.fromJson(v));
      });
    }
  }
  List<BookingData>? _data;

  List<BookingData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// pickupLocation : {"type":"Point","coordinates":[77.86316849291325,26.69662928094025]}
/// dropLocation : {"type":"Point","coordinates":[77.8631685,26.6966293]}
/// pickupAddress : "2/325,R.H.B. Yojna,Dholpur,Rajasthan"
/// destinationAddress : "Anand Heights, R.H.B. Yojna, Dholpur, Rajasthan, India"
/// pickupLatitude : 26.69662928094025
/// pickupLongitude : 77.86316849291325
/// customerMidlocation : null
/// customerMidLocationLat : null
/// customerMidLocationLong : null
/// destinationLatitude : 26.6966293
/// destinationLongitude : 77.8631685
/// city : null
/// state : null
/// country : null
/// landmark : null
/// house_no : null
/// declineRideDriver : []
/// notificationSendUser : []
/// vehicleNumber : null
/// vehicleColor : null
/// amount : null
/// status : "Arriving"
/// rideType : "Now"
/// book_for_self : true
/// otp : null
/// isPaid : false
/// time : null
/// perMileAmount : null
/// carType : null
/// seatCapacity : null
/// customer_rating : 0
/// driver_rating : 0
/// start_ride_time : "2024-05-16 13:50"
/// end_ride_time : null
/// reason : null
/// crnNumber : "CRN6154342"
/// _id : "66460f0db1e99f423eaf11ce"
/// customer : {"user_location":{"type":"Point","coordinates":[-122.084,37.4219983]},"gender":"Male","age":0,"is_active":true,"is_deleted":false,"otp":"8045","creditLimit":0,"language":"en","type":"User","profilePic":null,"description":null,"isProfileCompleted":true,"is_notification":true,"isApprove":true,"isSubscription":false,"experience":0,"loginType":"Email","deviceType":"Android","country":null,"endDate":null,"voipToken":"","isCar":false,"latitude":37.4219983,"longitude":37.4219983,"deviceToken":"cRh_Z6B1T_i3fHpWK-K894:APA91bEtCvqWsRD3P_1tpGpY8mIUVbFILE2z_azChFMSzmRgoDiOlOAFuxM2--0RVd1UBVl4D62nqMK06lFzxZPxwZhjLXXzTjP4Uy-TQ7IuaY6A7QSrp5DkT0jp5yqnqFbhC8PxR-o9","socialId":null,"myReferralCode":null,"referByCode":null,"accountId":null,"isVerify":true,"isOnline":false,"isActiveRide":false,"bankAccountDocument":null,"drivingLicence":null,"drivingLicenceBack":null,"govermentId":null,"_id":"66459f60c15af4355a9c3933","userId":"8763448","email":"sagar.shrivastava@inventcolab.com","password":"$2b$10$VW5DNJZV95PJecvQlCMxl.kJDAMyG35QrB1YqF9QVKkM5eexmiK5e","name":"sagar","created_at":"2024-05-16T05:53:36.566Z","updated_at":"2024-05-16T13:47:52.287Z","__v":0,"countryCode":"39","mobileNumber":"7014051723","address":"1600 Amphitheatre Pkwy Building 43, ,Santa Clara County, 94043","userName":"sagar"}
/// date : "2024-05-16T13:50:01.508Z"
/// driver_gender : "Male"
/// created_at : "2024-05-16T13:50:05.332Z"
/// updated_at : "2024-05-16T13:50:59.557Z"
/// __v : 0
/// driver : {"user_location":{"type":"Point","coordinates":[77.8621554,26.6971201]},"gender":"Male","age":0,"is_active":true,"is_deleted":false,"otp":null,"creditLimit":0,"language":"en","type":"Driver","profilePic":null,"description":null,"isProfileCompleted":true,"is_notification":true,"isApprove":true,"isSubscription":false,"experience":0,"loginType":"Email","deviceType":"Android","country":null,"endDate":null,"voipToken":"","isCar":true,"latitude":26.6971201,"longitude":77.8621554,"deviceToken":"cOzYucnZQH-l-T_P2R2nzr:APA91bHxtzhNT5UGqkhFlFyCdvHTHI6hjgVqcbokeLpp25WWxOBAiYEj-wsrMaDhZB_7W3Iwe-0kY1u5BWX8uF0Yd-zCWi9qmR1BZAO1xwxOiQsrsQ9hgiLHWxNA9HyCCh3l3MCkiM9P","socialId":null,"myReferralCode":null,"referByCode":null,"accountId":null,"isVerify":true,"isOnline":true,"isActiveRide":true,"bankAccountDocument":"taxi/profile/c7db830c-582c-4a7e-b086-583ee8a42c0d.jpg1715596790229.jpg","drivingLicence":"taxi/profile/dd07ae01-c388-4a2c-a765-739d3845330c.jpg1715596812904.jpg","drivingLicenceBack":null,"govermentId":"taxi/profile/image_1714469175109.png","_id":"6630b718c2d7c431646453d0","userId":"4114913","email":"kamal123@yopmail.com","password":"$2b$10$15n0Osbh7m4EBw88t56UC.Y32wy4qV0tu8K0R9Dk89plvPDBMOymK","name":"Kamal","created_at":"2024-04-30T09:17:12.713Z","updated_at":"2024-05-16T13:50:59.557Z","__v":0,"countryCode":"91","mobileNumber":"8561028424","profileImage":"taxi/profile/D88D80A6-1B02-4BEC-AF71-BC7BF6040FD4.jpg1715838763240.jpg","userName":"Kamal","city_id":132201}

class BookingData {
  BookingData({
      PickupLocation? pickupLocation, 
      DropLocation? dropLocation, 
      String? pickupAddress, 
      String? destinationAddress, 
      num? pickupLatitude, 
      num? pickupLongitude, 
      dynamic customerMidlocation, 
      dynamic customerMidLocationLat, 
      dynamic customerMidLocationLong, 
      num? destinationLatitude, 
      num? destinationLongitude, 
      dynamic city, 
      dynamic state, 
      dynamic country, 
      dynamic landmark, 
      dynamic houseNo, 
      List<dynamic>? declineRideDriver, 
      List<dynamic>? notificationSendUser, 
      dynamic vehicleNumber, 
      dynamic vehicleColor, 
      dynamic amount, 
      String? status, 
      String? rideType, 
      bool? bookForSelf, 
      dynamic otp, 
      bool? isPaid, 
      dynamic time, 
      dynamic perMileAmount, 
      dynamic carType, 
      dynamic seatCapacity, 
      dynamic totalAmount,
      num? customerRating,
      num? driverRating, 
      String? startRideTime, 
      dynamic endRideTime, 
      dynamic reason, 
      String? crnNumber, 
      String? id, 
      Customer? customer, 
      String? date, 
      String? driverGender, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      Driver? driver,}){
    _pickupLocation = pickupLocation;
    _dropLocation = dropLocation;
    _pickupAddress = pickupAddress;
    _destinationAddress = destinationAddress;
    _pickupLatitude = pickupLatitude;
    _pickupLongitude = pickupLongitude;
    _customerMidlocation = customerMidlocation;
    _customerMidLocationLat = customerMidLocationLat;
    _customerMidLocationLong = customerMidLocationLong;
    _destinationLatitude = destinationLatitude;
    _destinationLongitude = destinationLongitude;
    _city = city;
    _state = state;
    _country = country;
    _landmark = landmark;
    _houseNo = houseNo;
    _declineRideDriver = declineRideDriver;
    _notificationSendUser = notificationSendUser;
    _vehicleNumber = vehicleNumber;
    _vehicleColor = vehicleColor;
    _amount = amount;
    _status = status;
    _rideType = rideType;
    _bookForSelf = bookForSelf;
    _otp = otp;
    _isPaid = isPaid;
    _time = time;
    _perMileAmount = perMileAmount;
    _carType = carType;
    _totalAmount = totalAmount;
    _seatCapacity = seatCapacity;
    _customerRating = customerRating;
    _driverRating = driverRating;
    _startRideTime = startRideTime;
    _endRideTime = endRideTime;
    _reason = reason;
    _crnNumber = crnNumber;
    _id = id;
    _customer = customer;
    _date = date;
    _driverGender = driverGender;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _driver = driver;
}

  BookingData.fromJson(dynamic json) {
    _pickupLocation = json['pickupLocation'] != null ? PickupLocation.fromJson(json['pickupLocation']) : null;
    _dropLocation = json['dropLocation'] != null ? DropLocation.fromJson(json['dropLocation']) : null;
    _pickupAddress = json['pickupAddress'];
    _destinationAddress = json['destinationAddress'];
    _pickupLatitude = json['pickupLatitude'];
    _pickupLongitude = json['pickupLongitude'];
    _customerMidlocation = json['customerMidlocation'];
    _customerMidLocationLat = json['customerMidLocationLat'];
    _customerMidLocationLong = json['customerMidLocationLong'];
    _destinationLatitude = json['destinationLatitude'];
    _destinationLongitude = json['destinationLongitude'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _landmark = json['landmark'];
    _houseNo = json['house_no'];
    // if (json['declineRideDriver'] != null) {
    //   _declineRideDriver = [];
    //   json['declineRideDriver'].forEach((v) {
    //     _declineRideDriver?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['notificationSendUser'] != null) {
    //   _notificationSendUser = [];
    //   json['notificationSendUser'].forEach((v) {
    //     _notificationSendUser?.add(Dynamic.fromJson(v));
    //   });
    // }
    _vehicleNumber = json['vehicleNumber'];
    _vehicleColor = json['vehicleColor'];
    _amount = json['amount'];
    _status = json['status'];
    _rideType = json['rideType'];
    _bookForSelf = json['book_for_self'];
    _otp = json['otp'];
    _isPaid = json['isPaid'];
    _time = json['time'];
    _perMileAmount = json['perMileAmount'];
    _carType = json['carType'];
    _totalAmount = json['totalAmount'];
    _seatCapacity = json['seatCapacity'];
    _customerRating = json['customer_rating'];
    _driverRating = json['driver_rating'];
    _startRideTime = json['start_ride_time'];
    _endRideTime = json['end_ride_time'];
    _reason = json['reason'];
    _crnNumber = json['crnNumber'];
    _id = json['_id'];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _date = json['date'];
    _driverGender = json['driver_gender'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _v = json['__v'];
    _driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
  }
  PickupLocation? _pickupLocation;
  DropLocation? _dropLocation;
  String? _pickupAddress;
  String? _destinationAddress;
  num? _pickupLatitude;
  num? _pickupLongitude;
  dynamic _customerMidlocation;
  dynamic _customerMidLocationLat;
  dynamic _customerMidLocationLong;
  num? _destinationLatitude;
  num? _destinationLongitude;
  dynamic _city;
  dynamic _state;
  dynamic _country;
  dynamic _landmark;
  dynamic _houseNo;
  List<dynamic>? _declineRideDriver;
  List<dynamic>? _notificationSendUser;
  dynamic _vehicleNumber;
  dynamic _vehicleColor;
  dynamic _amount;
  String? _status;
  String? _rideType;
  bool? _bookForSelf;
  dynamic _otp;
  bool? _isPaid;
  dynamic _time;
  dynamic _perMileAmount;
  dynamic _carType;
  dynamic _totalAmount;
  dynamic _seatCapacity;
  num? _customerRating;
  num? _driverRating;
  String? _startRideTime;
  dynamic _endRideTime;
  dynamic _reason;
  String? _crnNumber;
  String? _id;
  Customer? _customer;
  String? _date;
  String? _driverGender;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  Driver? _driver;

  PickupLocation? get pickupLocation => _pickupLocation;
  DropLocation? get dropLocation => _dropLocation;
  String? get pickupAddress => _pickupAddress;
  String? get destinationAddress => _destinationAddress;
  num? get pickupLatitude => _pickupLatitude;
  num? get pickupLongitude => _pickupLongitude;
  dynamic get customerMidlocation => _customerMidlocation;
  dynamic get customerMidLocationLat => _customerMidLocationLat;
  dynamic get customerMidLocationLong => _customerMidLocationLong;
  num? get destinationLatitude => _destinationLatitude;
  num? get destinationLongitude => _destinationLongitude;
  dynamic get city => _city;
  dynamic get state => _state;
  dynamic get country => _country;
  dynamic get landmark => _landmark;
  dynamic get houseNo => _houseNo;
  dynamic get totalAmount => _totalAmount;
  List<dynamic>? get declineRideDriver => _declineRideDriver;
  List<dynamic>? get notificationSendUser => _notificationSendUser;
  dynamic get vehicleNumber => _vehicleNumber;
  dynamic get vehicleColor => _vehicleColor;
  dynamic get amount => _amount;
  String? get status => _status;
  String? get rideType => _rideType;
  bool? get bookForSelf => _bookForSelf;
  dynamic get otp => _otp;
  bool? get isPaid => _isPaid;
  dynamic get time => _time;
  dynamic get perMileAmount => _perMileAmount;
  dynamic get carType => _carType;
  dynamic get seatCapacity => _seatCapacity;
  num? get customerRating => _customerRating;
  num? get driverRating => _driverRating;
  String? get startRideTime => _startRideTime;
  dynamic get endRideTime => _endRideTime;
  dynamic get reason => _reason;
  String? get crnNumber => _crnNumber;
  String? get id => _id;
  Customer? get customer => _customer;
  String? get date => _date;
  String? get driverGender => _driverGender;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  Driver? get driver => _driver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pickupLocation != null) {
      map['pickupLocation'] = _pickupLocation?.toJson();
    }
    if (_dropLocation != null) {
      map['dropLocation'] = _dropLocation?.toJson();
    }
    map['pickupAddress'] = _pickupAddress;
    map['destinationAddress'] = _destinationAddress;
    map['pickupLatitude'] = _pickupLatitude;
    map['pickupLongitude'] = _pickupLongitude;
    map['customerMidlocation'] = _customerMidlocation;
    map['customerMidLocationLat'] = _customerMidLocationLat;
    map['customerMidLocationLong'] = _customerMidLocationLong;
    map['destinationLatitude'] = _destinationLatitude;
    map['destinationLongitude'] = _destinationLongitude;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['landmark'] = _landmark;
    map['house_no'] = _houseNo;
    if (_declineRideDriver != null) {
      map['declineRideDriver'] = _declineRideDriver?.map((v) => v.toJson()).toList();
    }
    if (_notificationSendUser != null) {
      map['notificationSendUser'] = _notificationSendUser?.map((v) => v.toJson()).toList();
    }
    map['vehicleNumber'] = _vehicleNumber;
    map['vehicleColor'] = _vehicleColor;
    map['amount'] = _amount;
    map['status'] = _status;
    map['rideType'] = _rideType;
    map['book_for_self'] = _bookForSelf;
    map['otp'] = _otp;
    map['isPaid'] = _isPaid;
    map['time'] = _time;
    map['perMileAmount'] = _perMileAmount;
    map['carType'] = _carType;
    map['totalAmount'] = _totalAmount;
    map['seatCapacity'] = _seatCapacity;
    map['customer_rating'] = _customerRating;
    map['driver_rating'] = _driverRating;
    map['start_ride_time'] = _startRideTime;
    map['end_ride_time'] = _endRideTime;
    map['reason'] = _reason;
    map['crnNumber'] = _crnNumber;
    map['_id'] = _id;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    map['date'] = _date;
    map['driver_gender'] = _driverGender;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['__v'] = _v;
    if (_driver != null) {
      map['driver'] = _driver?.toJson();
    }
    return map;
  }

}

/// user_location : {"type":"Point","coordinates":[77.8621554,26.6971201]}
/// gender : "Male"
/// age : 0
/// is_active : true
/// is_deleted : false
/// otp : null
/// creditLimit : 0
/// language : "en"
/// type : "Driver"
/// profilePic : null
/// description : null
/// isProfileCompleted : true
/// is_notification : true
/// isApprove : true
/// isSubscription : false
/// experience : 0
/// loginType : "Email"
/// deviceType : "Android"
/// country : null
/// endDate : null
/// voipToken : ""
/// isCar : true
/// latitude : 26.6971201
/// longitude : 77.8621554
/// deviceToken : "cOzYucnZQH-l-T_P2R2nzr:APA91bHxtzhNT5UGqkhFlFyCdvHTHI6hjgVqcbokeLpp25WWxOBAiYEj-wsrMaDhZB_7W3Iwe-0kY1u5BWX8uF0Yd-zCWi9qmR1BZAO1xwxOiQsrsQ9hgiLHWxNA9HyCCh3l3MCkiM9P"
/// socialId : null
/// myReferralCode : null
/// referByCode : null
/// accountId : null
/// isVerify : true
/// isOnline : true
/// isActiveRide : true
/// bankAccountDocument : "taxi/profile/c7db830c-582c-4a7e-b086-583ee8a42c0d.jpg1715596790229.jpg"
/// drivingLicence : "taxi/profile/dd07ae01-c388-4a2c-a765-739d3845330c.jpg1715596812904.jpg"
/// drivingLicenceBack : null
/// govermentId : "taxi/profile/image_1714469175109.png"
/// _id : "6630b718c2d7c431646453d0"
/// userId : "4114913"
/// email : "kamal123@yopmail.com"
/// password : "$2b$10$15n0Osbh7m4EBw88t56UC.Y32wy4qV0tu8K0R9Dk89plvPDBMOymK"
/// name : "Kamal"
/// created_at : "2024-04-30T09:17:12.713Z"
/// updated_at : "2024-05-16T13:50:59.557Z"
/// __v : 0
/// countryCode : "91"
/// mobileNumber : "8561028424"
/// profileImage : "taxi/profile/D88D80A6-1B02-4BEC-AF71-BC7BF6040FD4.jpg1715838763240.jpg"
/// userName : "Kamal"
/// city_id : 132201

class Driver {
  Driver({
      UserLocation? userLocation, 
      String? gender, 
      num? age, 
      bool? isActive, 
      bool? isDeleted, 
      dynamic otp, 
      num? creditLimit, 
      String? language, 
      String? type, 
      dynamic profilePic, 
      dynamic description, 
      bool? isProfileCompleted, 
      bool? isNotification, 
      bool? isApprove, 
      bool? isSubscription, 
      num? experience, 
      String? loginType, 
      String? deviceType, 
      dynamic country, 
      dynamic endDate, 
      String? voipToken, 
      bool? isCar, 
      num? latitude, 
      num? longitude, 
      String? deviceToken, 
      dynamic socialId, 
      dynamic myReferralCode, 
      dynamic referByCode, 
      dynamic accountId, 
      bool? isVerify, 
      bool? isOnline, 
      bool? isActiveRide, 
      String? bankAccountDocument, 
      String? drivingLicence, 
      dynamic drivingLicenceBack, 
      String? govermentId, 
      String? id, 
      String? userId, 
      String? email, 
      String? password, 
      String? name, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      String? countryCode, 
      String? mobileNumber, 
      String? profileImage, 
      String? userName, 
      num? cityId,}){
    _userLocation = userLocation;
    _gender = gender;
    _age = age;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _otp = otp;
    _creditLimit = creditLimit;
    _language = language;
    _type = type;
    _profilePic = profilePic;
    _description = description;
    _isProfileCompleted = isProfileCompleted;
    _isNotification = isNotification;
    _isApprove = isApprove;
    _isSubscription = isSubscription;
    _experience = experience;
    _loginType = loginType;
    _deviceType = deviceType;
    _country = country;
    _endDate = endDate;
    _voipToken = voipToken;
    _isCar = isCar;
    _latitude = latitude;
    _longitude = longitude;
    _deviceToken = deviceToken;
    _socialId = socialId;
    _myReferralCode = myReferralCode;
    _referByCode = referByCode;
    _accountId = accountId;
    _isVerify = isVerify;
    _isOnline = isOnline;
    _isActiveRide = isActiveRide;
    _bankAccountDocument = bankAccountDocument;
    _drivingLicence = drivingLicence;
    _drivingLicenceBack = drivingLicenceBack;
    _govermentId = govermentId;
    _id = id;
    _userId = userId;
    _email = email;
    _password = password;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _countryCode = countryCode;
    _mobileNumber = mobileNumber;
    _profileImage = profileImage;
    _userName = userName;
    _cityId = cityId;
}

  Driver.fromJson(dynamic json) {
    _userLocation = json['user_location'] != null ? UserLocation.fromJson(json['user_location']) : null;
    _gender = json['gender'];
    _age = json['age'];
    _isActive = json['is_active'];
    _isDeleted = json['is_deleted'];
    _otp = json['otp'];
    _creditLimit = json['creditLimit'];
    _language = json['language'];
    _type = json['type'];
    _profilePic = json['profilePic'];
    _description = json['description'];
    _isProfileCompleted = json['isProfileCompleted'];
    _isNotification = json['is_notification'];
    _isApprove = json['isApprove'];
    _isSubscription = json['isSubscription'];
    _experience = json['experience'];
    _loginType = json['loginType'];
    _deviceType = json['deviceType'];
    _country = json['country'];
    _endDate = json['endDate'];
    _voipToken = json['voipToken'];
    _isCar = json['isCar'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deviceToken = json['deviceToken'];
    _socialId = json['socialId'];
    _myReferralCode = json['myReferralCode'];
    _referByCode = json['referByCode'];
    _accountId = json['accountId'];
    _isVerify = json['isVerify'];
    _isOnline = json['isOnline'];
    _isActiveRide = json['isActiveRide'];
    _bankAccountDocument = json['bankAccountDocument'];
    _drivingLicence = json['drivingLicence'];
    _drivingLicenceBack = json['drivingLicenceBack'];
    _govermentId = json['govermentId'];
    _id = json['_id'];
    _userId = json['userId'];
    _email = json['email'];
    _password = json['password'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _v = json['__v'];
    _countryCode = json['countryCode'];
    _mobileNumber = json['mobileNumber'];
    _profileImage = json['profileImage'];
    _userName = json['userName'];
    _cityId = json['city_id'];
  }
  UserLocation? _userLocation;
  String? _gender;
  num? _age;
  bool? _isActive;
  bool? _isDeleted;
  dynamic _otp;
  num? _creditLimit;
  String? _language;
  String? _type;
  dynamic _profilePic;
  dynamic _description;
  bool? _isProfileCompleted;
  bool? _isNotification;
  bool? _isApprove;
  bool? _isSubscription;
  num? _experience;
  String? _loginType;
  String? _deviceType;
  dynamic _country;
  dynamic _endDate;
  String? _voipToken;
  bool? _isCar;
  num? _latitude;
  num? _longitude;
  String? _deviceToken;
  dynamic _socialId;
  dynamic _myReferralCode;
  dynamic _referByCode;
  dynamic _accountId;
  bool? _isVerify;
  bool? _isOnline;
  bool? _isActiveRide;
  String? _bankAccountDocument;
  String? _drivingLicence;
  dynamic _drivingLicenceBack;
  String? _govermentId;
  String? _id;
  String? _userId;
  String? _email;
  String? _password;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _countryCode;
  String? _mobileNumber;
  String? _profileImage;
  String? _userName;
  num? _cityId;
Driver copyWith({  UserLocation? userLocation,
  String? gender,
  num? age,
  bool? isActive,
  bool? isDeleted,
  dynamic otp,
  num? creditLimit,
  String? language,
  String? type,
  dynamic profilePic,
  dynamic description,
  bool? isProfileCompleted,
  bool? isNotification,
  bool? isApprove,
  bool? isSubscription,
  num? experience,
  String? loginType,
  String? deviceType,
  dynamic country,
  dynamic endDate,
  String? voipToken,
  bool? isCar,
  num? latitude,
  num? longitude,
  String? deviceToken,
  dynamic socialId,
  dynamic myReferralCode,
  dynamic referByCode,
  dynamic accountId,
  bool? isVerify,
  bool? isOnline,
  bool? isActiveRide,
  String? bankAccountDocument,
  String? drivingLicence,
  dynamic drivingLicenceBack,
  String? govermentId,
  String? id,
  String? userId,
  String? email,
  String? password,
  String? name,
  String? createdAt,
  String? updatedAt,
  num? v,
  String? countryCode,
  String? mobileNumber,
  String? profileImage,
  String? userName,
  num? cityId,
}) => Driver(  userLocation: userLocation ?? _userLocation,
  gender: gender ?? _gender,
  age: age ?? _age,
  isActive: isActive ?? _isActive,
  isDeleted: isDeleted ?? _isDeleted,
  otp: otp ?? _otp,
  creditLimit: creditLimit ?? _creditLimit,
  language: language ?? _language,
  type: type ?? _type,
  profilePic: profilePic ?? _profilePic,
  description: description ?? _description,
  isProfileCompleted: isProfileCompleted ?? _isProfileCompleted,
  isNotification: isNotification ?? _isNotification,
  isApprove: isApprove ?? _isApprove,
  isSubscription: isSubscription ?? _isSubscription,
  experience: experience ?? _experience,
  loginType: loginType ?? _loginType,
  deviceType: deviceType ?? _deviceType,
  country: country ?? _country,
  endDate: endDate ?? _endDate,
  voipToken: voipToken ?? _voipToken,
  isCar: isCar ?? _isCar,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  deviceToken: deviceToken ?? _deviceToken,
  socialId: socialId ?? _socialId,
  myReferralCode: myReferralCode ?? _myReferralCode,
  referByCode: referByCode ?? _referByCode,
  accountId: accountId ?? _accountId,
  isVerify: isVerify ?? _isVerify,
  isOnline: isOnline ?? _isOnline,
  isActiveRide: isActiveRide ?? _isActiveRide,
  bankAccountDocument: bankAccountDocument ?? _bankAccountDocument,
  drivingLicence: drivingLicence ?? _drivingLicence,
  drivingLicenceBack: drivingLicenceBack ?? _drivingLicenceBack,
  govermentId: govermentId ?? _govermentId,
  id: id ?? _id,
  userId: userId ?? _userId,
  email: email ?? _email,
  password: password ?? _password,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  countryCode: countryCode ?? _countryCode,
  mobileNumber: mobileNumber ?? _mobileNumber,
  profileImage: profileImage ?? _profileImage,
  userName: userName ?? _userName,
  cityId: cityId ?? _cityId,
);
  UserLocation? get userLocation => _userLocation;
  String? get gender => _gender;
  num? get age => _age;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  dynamic get otp => _otp;
  num? get creditLimit => _creditLimit;
  String? get language => _language;
  String? get type => _type;
  dynamic get profilePic => _profilePic;
  dynamic get description => _description;
  bool? get isProfileCompleted => _isProfileCompleted;
  bool? get isNotification => _isNotification;
  bool? get isApprove => _isApprove;
  bool? get isSubscription => _isSubscription;
  num? get experience => _experience;
  String? get loginType => _loginType;
  String? get deviceType => _deviceType;
  dynamic get country => _country;
  dynamic get endDate => _endDate;
  String? get voipToken => _voipToken;
  bool? get isCar => _isCar;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get deviceToken => _deviceToken;
  dynamic get socialId => _socialId;
  dynamic get myReferralCode => _myReferralCode;
  dynamic get referByCode => _referByCode;
  dynamic get accountId => _accountId;
  bool? get isVerify => _isVerify;
  bool? get isOnline => _isOnline;
  bool? get isActiveRide => _isActiveRide;
  String? get bankAccountDocument => _bankAccountDocument;
  String? get drivingLicence => _drivingLicence;
  dynamic get drivingLicenceBack => _drivingLicenceBack;
  String? get govermentId => _govermentId;
  String? get id => _id;
  String? get userId => _userId;
  String? get email => _email;
  String? get password => _password;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  String? get countryCode => _countryCode;
  String? get mobileNumber => _mobileNumber;
  String? get profileImage => _profileImage;
  String? get userName => _userName;
  num? get cityId => _cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userLocation != null) {
      map['user_location'] = _userLocation?.toJson();
    }
    map['gender'] = _gender;
    map['age'] = _age;
    map['is_active'] = _isActive;
    map['is_deleted'] = _isDeleted;
    map['otp'] = _otp;
    map['creditLimit'] = _creditLimit;
    map['language'] = _language;
    map['type'] = _type;
    map['profilePic'] = _profilePic;
    map['description'] = _description;
    map['isProfileCompleted'] = _isProfileCompleted;
    map['is_notification'] = _isNotification;
    map['isApprove'] = _isApprove;
    map['isSubscription'] = _isSubscription;
    map['experience'] = _experience;
    map['loginType'] = _loginType;
    map['deviceType'] = _deviceType;
    map['country'] = _country;
    map['endDate'] = _endDate;
    map['voipToken'] = _voipToken;
    map['isCar'] = _isCar;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['deviceToken'] = _deviceToken;
    map['socialId'] = _socialId;
    map['myReferralCode'] = _myReferralCode;
    map['referByCode'] = _referByCode;
    map['accountId'] = _accountId;
    map['isVerify'] = _isVerify;
    map['isOnline'] = _isOnline;
    map['isActiveRide'] = _isActiveRide;
    map['bankAccountDocument'] = _bankAccountDocument;
    map['drivingLicence'] = _drivingLicence;
    map['drivingLicenceBack'] = _drivingLicenceBack;
    map['govermentId'] = _govermentId;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['email'] = _email;
    map['password'] = _password;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['__v'] = _v;
    map['countryCode'] = _countryCode;
    map['mobileNumber'] = _mobileNumber;
    map['profileImage'] = _profileImage;
    map['userName'] = _userName;
    map['city_id'] = _cityId;
    return map;
  }

}

/// user_location : {"type":"Point","coordinates":[-122.084,37.4219983]}
/// gender : "Male"
/// age : 0
/// is_active : true
/// is_deleted : false
/// otp : "8045"
/// creditLimit : 0
/// language : "en"
/// type : "User"
/// profilePic : null
/// description : null
/// isProfileCompleted : true
/// is_notification : true
/// isApprove : true
/// isSubscription : false
/// experience : 0
/// loginType : "Email"
/// deviceType : "Android"
/// country : null
/// endDate : null
/// voipToken : ""
/// isCar : false
/// latitude : 37.4219983
/// longitude : 37.4219983
/// deviceToken : "cRh_Z6B1T_i3fHpWK-K894:APA91bEtCvqWsRD3P_1tpGpY8mIUVbFILE2z_azChFMSzmRgoDiOlOAFuxM2--0RVd1UBVl4D62nqMK06lFzxZPxwZhjLXXzTjP4Uy-TQ7IuaY6A7QSrp5DkT0jp5yqnqFbhC8PxR-o9"
/// socialId : null
/// myReferralCode : null
/// referByCode : null
/// accountId : null
/// isVerify : true
/// isOnline : false
/// isActiveRide : false
/// bankAccountDocument : null
/// drivingLicence : null
/// drivingLicenceBack : null
/// govermentId : null
/// _id : "66459f60c15af4355a9c3933"
/// userId : "8763448"
/// email : "sagar.shrivastava@inventcolab.com"
/// password : "$2b$10$VW5DNJZV95PJecvQlCMxl.kJDAMyG35QrB1YqF9QVKkM5eexmiK5e"
/// name : "sagar"
/// created_at : "2024-05-16T05:53:36.566Z"
/// updated_at : "2024-05-16T13:47:52.287Z"
/// __v : 0
/// countryCode : "39"
/// mobileNumber : "7014051723"
/// address : "1600 Amphitheatre Pkwy Building 43, ,Santa Clara County, 94043"
/// userName : "sagar"

class Customer {
  Customer({
      UserLocation? userLocation, 
      String? gender, 
      num? age, 
      bool? isActive, 
      bool? isDeleted, 
      String? otp, 
      num? creditLimit, 
      String? language, 
      String? type, 
      dynamic profilePic, 
      dynamic description, 
      bool? isProfileCompleted, 
      bool? isNotification, 
      bool? isApprove, 
      bool? isSubscription, 
      num? experience, 
      String? loginType, 
      String? deviceType, 
      dynamic country, 
      dynamic endDate, 
      String? voipToken, 
      bool? isCar, 
      num? latitude, 
      num? longitude, 
      String? deviceToken, 
      dynamic socialId, 
      dynamic myReferralCode, 
      dynamic referByCode, 
      dynamic accountId, 
      bool? isVerify, 
      bool? isOnline, 
      bool? isActiveRide, 
      dynamic bankAccountDocument, 
      dynamic drivingLicence, 
      dynamic drivingLicenceBack, 
      dynamic govermentId, 
      String? id, 
      String? userId, 
      String? email, 
      String? password, 
      String? name, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      String? countryCode, 
      String? mobileNumber, 
      String? address, 
      String? userName,}){
    _userLocation = userLocation;
    _gender = gender;
    _age = age;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _otp = otp;
    _creditLimit = creditLimit;
    _language = language;
    _type = type;
    _profilePic = profilePic;
    _description = description;
    _isProfileCompleted = isProfileCompleted;
    _isNotification = isNotification;
    _isApprove = isApprove;
    _isSubscription = isSubscription;
    _experience = experience;
    _loginType = loginType;
    _deviceType = deviceType;
    _country = country;
    _endDate = endDate;
    _voipToken = voipToken;
    _isCar = isCar;
    _latitude = latitude;
    _longitude = longitude;
    _deviceToken = deviceToken;
    _socialId = socialId;
    _myReferralCode = myReferralCode;
    _referByCode = referByCode;
    _accountId = accountId;
    _isVerify = isVerify;
    _isOnline = isOnline;
    _isActiveRide = isActiveRide;
    _bankAccountDocument = bankAccountDocument;
    _drivingLicence = drivingLicence;
    _drivingLicenceBack = drivingLicenceBack;
    _govermentId = govermentId;
    _id = id;
    _userId = userId;
    _email = email;
    _password = password;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _countryCode = countryCode;
    _mobileNumber = mobileNumber;
    _address = address;
    _userName = userName;
}

  Customer.fromJson(dynamic json) {
    _userLocation = json['user_location'] != null ? UserLocation.fromJson(json['user_location']) : null;
    _gender = json['gender'];
    _age = json['age'];
    _isActive = json['is_active'];
    _isDeleted = json['is_deleted'];
    _otp = json['otp'];
    _creditLimit = json['creditLimit'];
    _language = json['language'];
    _type = json['type'];
    _profilePic = json['profilePic'];
    _description = json['description'];
    _isProfileCompleted = json['isProfileCompleted'];
    _isNotification = json['is_notification'];
    _isApprove = json['isApprove'];
    _isSubscription = json['isSubscription'];
    _experience = json['experience'];
    _loginType = json['loginType'];
    _deviceType = json['deviceType'];
    _country = json['country'];
    _endDate = json['endDate'];
    _voipToken = json['voipToken'];
    _isCar = json['isCar'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deviceToken = json['deviceToken'];
    _socialId = json['socialId'];
    _myReferralCode = json['myReferralCode'];
    _referByCode = json['referByCode'];
    _accountId = json['accountId'];
    _isVerify = json['isVerify'];
    _isOnline = json['isOnline'];
    _isActiveRide = json['isActiveRide'];
    _bankAccountDocument = json['bankAccountDocument'];
    _drivingLicence = json['drivingLicence'];
    _drivingLicenceBack = json['drivingLicenceBack'];
    _govermentId = json['govermentId'];
    _id = json['_id'];
    _userId = json['userId'];
    _email = json['email'];
    _password = json['password'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _v = json['__v'];
    _countryCode = json['countryCode'];
    _mobileNumber = json['mobileNumber'];
    _address = json['address'];
    _userName = json['userName'];
  }
  UserLocation? _userLocation;
  String? _gender;
  num? _age;
  bool? _isActive;
  bool? _isDeleted;
  String? _otp;
  num? _creditLimit;
  String? _language;
  String? _type;
  dynamic _profilePic;
  dynamic _description;
  bool? _isProfileCompleted;
  bool? _isNotification;
  bool? _isApprove;
  bool? _isSubscription;
  num? _experience;
  String? _loginType;
  String? _deviceType;
  dynamic _country;
  dynamic _endDate;
  String? _voipToken;
  bool? _isCar;
  num? _latitude;
  num? _longitude;
  String? _deviceToken;
  dynamic _socialId;
  dynamic _myReferralCode;
  dynamic _referByCode;
  dynamic _accountId;
  bool? _isVerify;
  bool? _isOnline;
  bool? _isActiveRide;
  dynamic _bankAccountDocument;
  dynamic _drivingLicence;
  dynamic _drivingLicenceBack;
  dynamic _govermentId;
  String? _id;
  String? _userId;
  String? _email;
  String? _password;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _countryCode;
  String? _mobileNumber;
  String? _address;
  String? _userName;
Customer copyWith({  UserLocation? userLocation,
  String? gender,
  num? age,
  bool? isActive,
  bool? isDeleted,
  String? otp,
  num? creditLimit,
  String? language,
  String? type,
  dynamic profilePic,
  dynamic description,
  bool? isProfileCompleted,
  bool? isNotification,
  bool? isApprove,
  bool? isSubscription,
  num? experience,
  String? loginType,
  String? deviceType,
  dynamic country,
  dynamic endDate,
  String? voipToken,
  bool? isCar,
  num? latitude,
  num? longitude,
  String? deviceToken,
  dynamic socialId,
  dynamic myReferralCode,
  dynamic referByCode,
  dynamic accountId,
  bool? isVerify,
  bool? isOnline,
  bool? isActiveRide,
  dynamic bankAccountDocument,
  dynamic drivingLicence,
  dynamic drivingLicenceBack,
  dynamic govermentId,
  String? id,
  String? userId,
  String? email,
  String? password,
  String? name,
  String? createdAt,
  String? updatedAt,
  num? v,
  String? countryCode,
  String? mobileNumber,
  String? address,
  String? userName,
}) => Customer(  userLocation: userLocation ?? _userLocation,
  gender: gender ?? _gender,
  age: age ?? _age,
  isActive: isActive ?? _isActive,
  isDeleted: isDeleted ?? _isDeleted,
  otp: otp ?? _otp,
  creditLimit: creditLimit ?? _creditLimit,
  language: language ?? _language,
  type: type ?? _type,
  profilePic: profilePic ?? _profilePic,
  description: description ?? _description,
  isProfileCompleted: isProfileCompleted ?? _isProfileCompleted,
  isNotification: isNotification ?? _isNotification,
  isApprove: isApprove ?? _isApprove,
  isSubscription: isSubscription ?? _isSubscription,
  experience: experience ?? _experience,
  loginType: loginType ?? _loginType,
  deviceType: deviceType ?? _deviceType,
  country: country ?? _country,
  endDate: endDate ?? _endDate,
  voipToken: voipToken ?? _voipToken,
  isCar: isCar ?? _isCar,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  deviceToken: deviceToken ?? _deviceToken,
  socialId: socialId ?? _socialId,
  myReferralCode: myReferralCode ?? _myReferralCode,
  referByCode: referByCode ?? _referByCode,
  accountId: accountId ?? _accountId,
  isVerify: isVerify ?? _isVerify,
  isOnline: isOnline ?? _isOnline,
  isActiveRide: isActiveRide ?? _isActiveRide,
  bankAccountDocument: bankAccountDocument ?? _bankAccountDocument,
  drivingLicence: drivingLicence ?? _drivingLicence,
  drivingLicenceBack: drivingLicenceBack ?? _drivingLicenceBack,
  govermentId: govermentId ?? _govermentId,
  id: id ?? _id,
  userId: userId ?? _userId,
  email: email ?? _email,
  password: password ?? _password,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  countryCode: countryCode ?? _countryCode,
  mobileNumber: mobileNumber ?? _mobileNumber,
  address: address ?? _address,
  userName: userName ?? _userName,
);
  UserLocation? get userLocation => _userLocation;
  String? get gender => _gender;
  num? get age => _age;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  String? get otp => _otp;
  num? get creditLimit => _creditLimit;
  String? get language => _language;
  String? get type => _type;
  dynamic get profilePic => _profilePic;
  dynamic get description => _description;
  bool? get isProfileCompleted => _isProfileCompleted;
  bool? get isNotification => _isNotification;
  bool? get isApprove => _isApprove;
  bool? get isSubscription => _isSubscription;
  num? get experience => _experience;
  String? get loginType => _loginType;
  String? get deviceType => _deviceType;
  dynamic get country => _country;
  dynamic get endDate => _endDate;
  String? get voipToken => _voipToken;
  bool? get isCar => _isCar;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get deviceToken => _deviceToken;
  dynamic get socialId => _socialId;
  dynamic get myReferralCode => _myReferralCode;
  dynamic get referByCode => _referByCode;
  dynamic get accountId => _accountId;
  bool? get isVerify => _isVerify;
  bool? get isOnline => _isOnline;
  bool? get isActiveRide => _isActiveRide;
  dynamic get bankAccountDocument => _bankAccountDocument;
  dynamic get drivingLicence => _drivingLicence;
  dynamic get drivingLicenceBack => _drivingLicenceBack;
  dynamic get govermentId => _govermentId;
  String? get id => _id;
  String? get userId => _userId;
  String? get email => _email;
  String? get password => _password;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  String? get countryCode => _countryCode;
  String? get mobileNumber => _mobileNumber;
  String? get address => _address;
  String? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userLocation != null) {
      map['user_location'] = _userLocation?.toJson();
    }
    map['gender'] = _gender;
    map['age'] = _age;
    map['is_active'] = _isActive;
    map['is_deleted'] = _isDeleted;
    map['otp'] = _otp;
    map['creditLimit'] = _creditLimit;
    map['language'] = _language;
    map['type'] = _type;
    map['profilePic'] = _profilePic;
    map['description'] = _description;
    map['isProfileCompleted'] = _isProfileCompleted;
    map['is_notification'] = _isNotification;
    map['isApprove'] = _isApprove;
    map['isSubscription'] = _isSubscription;
    map['experience'] = _experience;
    map['loginType'] = _loginType;
    map['deviceType'] = _deviceType;
    map['country'] = _country;
    map['endDate'] = _endDate;
    map['voipToken'] = _voipToken;
    map['isCar'] = _isCar;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['deviceToken'] = _deviceToken;
    map['socialId'] = _socialId;
    map['myReferralCode'] = _myReferralCode;
    map['referByCode'] = _referByCode;
    map['accountId'] = _accountId;
    map['isVerify'] = _isVerify;
    map['isOnline'] = _isOnline;
    map['isActiveRide'] = _isActiveRide;
    map['bankAccountDocument'] = _bankAccountDocument;
    map['drivingLicence'] = _drivingLicence;
    map['drivingLicenceBack'] = _drivingLicenceBack;
    map['govermentId'] = _govermentId;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['email'] = _email;
    map['password'] = _password;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['__v'] = _v;
    map['countryCode'] = _countryCode;
    map['mobileNumber'] = _mobileNumber;
    map['address'] = _address;
    map['userName'] = _userName;
    return map;
  }

}

/// type : "Point"
/// coordinates : [-122.084,37.4219983]

class UserLocation {
  UserLocation({
      String? type, 
      List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
}

  UserLocation.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
UserLocation copyWith({  String? type,
  List<num>? coordinates,
}) => UserLocation(  type: type ?? _type,
  coordinates: coordinates ?? _coordinates,
);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}

/// type : "Point"
/// coordinates : [77.8631685,26.6966293]

class DropLocation {
  DropLocation({
      String? type, 
      List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
}

  DropLocation.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
DropLocation copyWith({  String? type,
  List<num>? coordinates,
}) => DropLocation(  type: type ?? _type,
  coordinates: coordinates ?? _coordinates,
);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}

/// type : "Point"
/// coordinates : [77.86316849291325,26.69662928094025]

class PickupLocation {
  PickupLocation({
      String? type, 
      List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
}

  PickupLocation.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
PickupLocation copyWith({  String? type,
  List<num>? coordinates,
}) => PickupLocation(  type: type ?? _type,
  coordinates: coordinates ?? _coordinates,
);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}