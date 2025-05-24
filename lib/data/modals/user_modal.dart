class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? address;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.address,
  });

  String get fullName => '$firstName $lastName';

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'] ?? json['firstName'];
    lastName = json['last_name'] ?? json['lastName'];
    mobile = json['mobile'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'address': address,
    };
  }
}
