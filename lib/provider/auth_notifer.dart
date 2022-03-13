import 'package:app_hackathon/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_hackathon/api_clients/api_client.dart';
import '../failure.dart';
import 'package:get/get.dart';

enum NotifierState { initial, loading, loaded }

class AuthNotifier extends ChangeNotifier {
  final _userRepository = ApiClient();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

 late String email = '';
 void setEmail(value) {
   email = value;
   notifyListeners();
 }

  late String password = '';
  void setPassword(value) {
    password = value;
    notifyListeners();
  }

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }


  Failure? _failure;
  Failure? get error => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  void auth(email, password, context) async {
    _setState(NotifierState.loading);

    try {
      final auth = await ApiClient().auth(email, password);
      if(auth.error != null) {
        _setState(NotifierState.initial);
        throw const Failure("Неверный пароль!");
      } else {
        _setState(NotifierState.loaded);
        //Get.offAllNamed(HomeScreen.id);
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => HomeScreen(),
          ),
              (route) => false,
        );
    }
    } on Failure catch (f) {
      _setFailure(f);
    }
  }
}