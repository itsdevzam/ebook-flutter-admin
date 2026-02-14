
class EbookModel {
  int? id;
  String? title;
  String? image;
  String? url;
  int? isPaid;
  String? description;
  int? categoryId;

  EbookModel(
      {this.id,
        this.title,
        this.image,
        this.url,
        this.isPaid,
        this.description,
        this.categoryId});

  EbookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
    isPaid = json['is_paid'];
    description = json["description"];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['url'] = this.url;
    data['is_paid'] = this.isPaid;
    data["description"] = this.description;
    data['category_id'] = this.categoryId;
    return data;
  }
}