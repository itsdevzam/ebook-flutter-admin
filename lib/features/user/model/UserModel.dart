
class UserModel {
  String? uid;
  String? name;
  String? email;
  String? isPro;
  DateTime? expiryDate;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.uid,
        this.name,
        this.email,
        this.isPro,
        this.expiryDate,
        this.createdAt,
        this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    isPro = json['is_pro']==0?"No":"Yes";
    expiryDate = json['expiry_date']!=null?DateTime.parse(json['expiry_date']).toLocal():null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['is_pro'] = this.isPro=="Yes"?1:0;
    data['expiry_date'] = this.expiryDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}