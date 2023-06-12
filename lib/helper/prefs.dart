import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class Prefs {
  final String _USER_KEY = "USER";
  late final GetStorage _storage;
  Prefs() {
    _storage = GetStorage();
  }

  Future<void> saveUser(UserModel userModel) async {
    await _storage.write(_USER_KEY, jsonEncode(userModel));
  }

  Future<UserModel> getUser() async {
    var jsonStr = _storage.read<String>(_USER_KEY);
    if (jsonStr != null) {
      return UserModel.fromJson(jsonDecode(jsonStr));
    } else {
      return UserModel();
    }
  }

  Future<void> clearUser() async {
    await _storage.remove(_USER_KEY);
  }
}

class UserModel {
  String? email;
  String? password;
  String? type;

  UserModel({this.email, this.password, this.type});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['type'] = type;
    return data;
  }
}
