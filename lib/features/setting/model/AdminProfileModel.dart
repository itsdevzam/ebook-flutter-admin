

class AdminProfileModel {
  String? adminUsername;
  String? adminEmail;
  String? adminTitle;

  AdminProfileModel({this.adminUsername, this.adminEmail, this.adminTitle});

  AdminProfileModel.fromJson(Map<String, dynamic> json) {
    adminUsername = json['admin_username'];
    adminEmail = json['admin_email'];
    adminTitle = json['admin_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_username'] = this.adminUsername;
    data['admin_email'] = this.adminEmail;
    data['admin_title'] = this.adminTitle;
    return data;
  }
}