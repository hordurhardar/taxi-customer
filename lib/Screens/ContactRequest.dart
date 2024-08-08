class ContactRequest {
  String? name;
  String? phone;
  String? city;
  String? postalCode;
  String? country;
  bool isSelected = false;

  ContactRequest(
      {this.name, this.phone, this.city, this.postalCode, this.country,});

  ContactRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}
