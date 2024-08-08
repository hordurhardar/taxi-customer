
class GetDropPlacesModel {
  List<Predictions>? predictions;
  String? status;

  GetDropPlacesModel({this.predictions, this.status});

  GetDropPlacesModel.fromJson(Map<String, dynamic> json) {
    predictions = json["predictions"] == null ? null : (json["predictions"] as List).map((e) => Predictions.fromJson(e)).toList();
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(predictions != null) {
      _data["predictions"] = predictions?.map((e) => e.toJson()).toList();
    }
    _data["status"] = status;
    return _data;
  }
}

class Predictions {
  String? description;
  List<MatchedSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Terms>? terms;
  List<String>? types;

  Predictions({this.description, this.matchedSubstrings, this.placeId, this.reference, this.structuredFormatting, this.terms, this.types});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    matchedSubstrings = json["matched_substrings"] == null ? null : (json["matched_substrings"] as List).map((e) => MatchedSubstrings.fromJson(e)).toList();
    placeId = json["place_id"];
    reference = json["reference"];
    structuredFormatting = json["structured_formatting"] == null ? null : StructuredFormatting.fromJson(json["structured_formatting"]);
    terms = json["terms"] == null ? null : (json["terms"] as List).map((e) => Terms.fromJson(e)).toList();
    types = json["types"] == null ? null : List<String>.from(json["types"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["description"] = description;
    if(matchedSubstrings != null) {
      _data["matched_substrings"] = matchedSubstrings?.map((e) => e.toJson()).toList();
    }
    _data["place_id"] = placeId;
    _data["reference"] = reference;
    if(structuredFormatting != null) {
      _data["structured_formatting"] = structuredFormatting?.toJson();
    }
    if(terms != null) {
      _data["terms"] = terms?.map((e) => e.toJson()).toList();
    }
    if(types != null) {
      _data["types"] = types;
    }
    return _data;
  }
}

class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json["offset"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["offset"] = offset;
    _data["value"] = value;
    return _data;
  }
}

class StructuredFormatting {
  String? mainText;
  List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  StructuredFormatting({this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json["main_text"];
    mainTextMatchedSubstrings = json["main_text_matched_substrings"] == null ? null : (json["main_text_matched_substrings"] as List).map((e) => MainTextMatchedSubstrings.fromJson(e)).toList();
    secondaryText = json["secondary_text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["main_text"] = mainText;
    if(mainTextMatchedSubstrings != null) {
      _data["main_text_matched_substrings"] = mainTextMatchedSubstrings?.map((e) => e.toJson()).toList();
    }
    _data["secondary_text"] = secondaryText;
    return _data;
  }
}

class MainTextMatchedSubstrings {
  int? length;
  int? offset;

  MainTextMatchedSubstrings({this.length, this.offset});

  MainTextMatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json["length"];
    offset = json["offset"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["length"] = length;
    _data["offset"] = offset;
    return _data;
  }
}

class MatchedSubstrings {
  int? length;
  int? offset;

  MatchedSubstrings({this.length, this.offset});

  MatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json["length"];
    offset = json["offset"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["length"] = length;
    _data["offset"] = offset;
    return _data;
  }
}