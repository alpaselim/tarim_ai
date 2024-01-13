// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? name;
  String? email;
  String? password;
  String? uid;
  String? profilePicture;
  int? status;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.uid,
    this.profilePicture,
    this.status = 0,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
    profilePicture = json['profilePicture'];
    status = json['status'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['uid'] = uid;
    data['profilePicture'] = profilePicture;
    data['status'] = status ?? 0;
    return data;
  }
}
