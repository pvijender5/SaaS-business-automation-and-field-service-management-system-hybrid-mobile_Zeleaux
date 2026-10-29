// To parse this JSON data, do
//
//     final employeeListModel = employeeListModelFromJson(jsonString);

import 'dart:convert';

EmployeeListModel employeeListModelFromJson(String str) => EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) => json.encode(data.toJson());

class EmployeeListModel {
  int? status;
  String? message;
  List<EmployeeData>? data;

  EmployeeListModel({
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
    status: json["status"],
    message: json["message"],
    data: json.containsKey("data")?(json["data"]!=null)?List<EmployeeData>.from(json["data"].map((x) => EmployeeData.fromJson(x))):null:null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EmployeeData {
  dynamic id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? title;
  String? pic;

  EmployeeData({
     this.id,
     this.firstName,
     this.lastName,
     this.phoneNumber,
     this.title,
    this.pic
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    title: json["title"],
    pic: json["pic"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "title": title,
    "pic":pic
  };
}
