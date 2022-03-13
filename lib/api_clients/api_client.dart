

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../failure.dart';
import '../models/user.dart';

class ApiClient {
  Future<User> auth(email, password) async {
    String url = 'https://alnezis.qweri-craft.ru:1920/manager/' + email + '/' +
        password;

    try {
      var response = await Dio().get(url);
      print('Response status: ${response.statusCode}');
      print(response.data);
      return User.fromJson(response.data);
    } on SocketException catch (_) {
      throw const Failure('No Internet connection 😑');
    } on DioError catch (e) {
      print(e.type);
      print(e.message);
      throw Failure('Unknown ' + e.message);
    }
  }

  Future<Map<String, dynamic>> placeholders() async {
    String url = 'https://alnezis.qweri-craft.ru:1920/placeholders';
    try {
      var response = await Dio().get(url);
      print('Response status: ${response.statusCode}');
      print(response.data[0]);
      return response.data;
    } on SocketException catch (_) {
      throw const Failure('No Internet connection 😑');
    } on DioError catch (e) {
      print(e.type);
      print(e.message);
      throw Failure('Unknown ' + e.message);
    }
  }
}



