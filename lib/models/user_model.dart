class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? createdDate;

  String get fullName {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.mobile,
      this.createdDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['createdDate'] = createdDate;
    return data;
  }
}
