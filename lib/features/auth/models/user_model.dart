class UserModel {
  const UserModel({this.fullName, required this.email, required this.password});

  final String? fullName;
  final String email;
  final String password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email, 'password': password};
  }

  UserModel copyWith({String? fullName, String? email, String? password}) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'UserModel(fullName: $fullName, email: $email)';
}
