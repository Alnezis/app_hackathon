// To parse this JSON data, do
//
//     final manager = managerFromJson(jsonString);

import 'dart:convert';

User managerFromJson(String str) => User.fromJson(json.decode(str));

String managerToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.result,
    this.error,
  });

  dynamic result;
  dynamic error;

  factory User.fromJson(Map<String, dynamic> json) => User(
    result: json["result"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "error": error,
  };
}

class Result {
  Result({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String password;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
  };
}
