class ContactRequest {
  String? name;
  String? phone;
  String? city;
  String? postalCode;
  String? country;
  String? relation;
  bool isSelected = false;

  ContactRequest({
    this.name,
    this.phone,
    this.city,
    this.postalCode,
    this.country,
    this.relation,
  });

  set setRelation(String newRelation) => relation = newRelation;

  set setSelected(bool newValue) => isSelected = newValue;

  ContactRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    postalCode = json['postalCode'];
    country = json['country'];
    relation = json["relation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['country'] = country;
    data['relation'] = relation;
    return data;
  }
}
