
class GetLatLongFromPlaceIdModel {
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  GetLatLongFromPlaceIdModel({this.htmlAttributions, this.result, this.status});

  GetLatLongFromPlaceIdModel.fromJson(Map<String, dynamic> json) {
    htmlAttributions = json["html_attributions"] ?? [];
    result = json["result"] == null ? null : Result.fromJson(json["result"]);
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(htmlAttributions != null) {
      _data["html_attributions"] = htmlAttributions;
    }
    if(result != null) {
      _data["result"] = result?.toJson();
    }
    _data["status"] = status;
    return _data;
  }
}

class Result {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  int? utcOffset;
  String? vicinity;
  String? website;

  Result({this.addressComponents, this.adrAddress, this.formattedAddress, this.geometry, this.icon, this.iconBackgroundColor, this.iconMaskBaseUri, this.name, this.photos, this.placeId, this.reference, this.types, this.url, this.utcOffset, this.vicinity, this.website});

  Result.fromJson(Map<String, dynamic> json) {
    addressComponents = json["address_components"] == null ? null : (json["address_components"] as List).map((e) => AddressComponents.fromJson(e)).toList();
    adrAddress = json["adr_address"];
    formattedAddress = json["formatted_address"];
    geometry = json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]);
    icon = json["icon"];
    iconBackgroundColor = json["icon_background_color"];
    iconMaskBaseUri = json["icon_mask_base_uri"];
    name = json["name"];
    photos = json["photos"] == null ? null : (json["photos"] as List).map((e) => Photos.fromJson(e)).toList();
    placeId = json["place_id"];
    reference = json["reference"];
    types = json["types"] == null ? null : List<String>.from(json["types"]);
    url = json["url"];
    utcOffset = json["utc_offset"];
    vicinity = json["vicinity"];
    website = json["website"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(addressComponents != null) {
      _data["address_components"] = addressComponents?.map((e) => e.toJson()).toList();
    }
    _data["adr_address"] = adrAddress;
    _data["formatted_address"] = formattedAddress;
    if(geometry != null) {
      _data["geometry"] = geometry?.toJson();
    }
    _data["icon"] = icon;
    _data["icon_background_color"] = iconBackgroundColor;
    _data["icon_mask_base_uri"] = iconMaskBaseUri;
    _data["name"] = name;
    if(photos != null) {
      _data["photos"] = photos?.map((e) => e.toJson()).toList();
    }
    _data["place_id"] = placeId;
    _data["reference"] = reference;
    if(types != null) {
      _data["types"] = types;
    }
    _data["url"] = url;
    _data["utc_offset"] = utcOffset;
    _data["vicinity"] = vicinity;
    _data["website"] = website;
    return _data;
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json["height"];
    htmlAttributions = json["html_attributions"] == null ? null : List<String>.from(json["html_attributions"]);
    photoReference = json["photo_reference"];
    width = json["width"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["height"] = height;
    if(htmlAttributions != null) {
      _data["html_attributions"] = htmlAttributions;
    }
    _data["photo_reference"] = photoReference;
    _data["width"] = width;
    return _data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json["location"] == null ? null : Location.fromJson(json["location"]);
    viewport = json["viewport"] == null ? null : Viewport.fromJson(json["viewport"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    if(viewport != null) {
      _data["viewport"] = viewport?.toJson();
    }
    return _data;
  }
}

class Viewport {
  Northeast? northeast;
  Southwest? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json["northeast"] == null ? null : Northeast.fromJson(json["northeast"]);
    southwest = json["southwest"] == null ? null : Southwest.fromJson(json["southwest"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(northeast != null) {
      _data["northeast"] = northeast?.toJson();
    }
    if(southwest != null) {
      _data["southwest"] = southwest?.toJson();
    }
    return _data;
  }
}

class Southwest {
  double? lat;
  double? lng;

  Southwest({this.lat, this.lng});

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lat"] = lat;
    _data["lng"] = lng;
    return _data;
  }
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lat"] = lat;
    _data["lng"] = lng;
    return _data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lat"] = lat;
    _data["lng"] = lng;
    return _data;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json["long_name"];
    shortName = json["short_name"];
    types = json["types"] == null ? null : List<String>.from(json["types"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["long_name"] = longName;
    _data["short_name"] = shortName;
    if(types != null) {
      _data["types"] = types;
    }
    return _data;
  }
}