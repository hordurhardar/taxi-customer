class ContentList {
  bool? isStatus;
  String? sId;
  bool? isActive;
  bool? isDeleted;
  String? name;
  String? description;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Faq>? faq;

  ContentList(
      {this.isStatus,
        this.sId,
        this.isActive,
        this.isDeleted,
        this.name,
        this.description,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.faq,
        });

  ContentList.fromJson(Map<String, dynamic> json) {
    isStatus = json['is_status'];
    sId = json['_id'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(new Faq.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_status'] = this.isStatus;
    data['_id'] = this.sId;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['name'] = this.name;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.faq != null) {
      data['faq'] = this.faq!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Faq {
  String? answer;
  String? sId;
  String? question;

  Faq({this.answer, this.sId, this.question});

  Faq.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    sId = json['_id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['_id'] = this.sId;
    data['question'] = this.question;
    return data;
  }
}
