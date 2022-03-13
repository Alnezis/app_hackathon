import 'dart:convert';
import 'dart:io';

import 'package:app_hackathon/screens/home_screen.dart';
import 'package:app_hackathon/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_hackathon/api_clients/api_client.dart';
import 'package:flutter/services.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../failure.dart';
import 'package:get/get.dart';

import '../screens/widgets/control_button.dart';

enum NotifierState { initial, loading, loaded }

class MapNotifier extends ChangeNotifier {
//  final _userRepository = ApiClient();

//  NotifierState _state = NotifierState.initial;
//  NotifierState get state => _state;

  late Map<String, dynamic> placeholder = {};

  void setPlaceholder(value) {
    placeholder = value;
    notifyListeners();
  }

  late String password = '';

  void setPassword(value) {
    password = value;
    notifyListeners();
  }

  late List<Placemark> placemark = [];
  void setPlacemark(value) {
    placemark = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> initList() async {
    try {
      final data = await ApiClient().placeholders();
      if (data != null) {
        setPlaceholder(data);
        print(data["1500"]);

        // final growableList = List<Placemark>.generate(data.length, (index) {
        //   late double x = double.parse(data['$index']['x']);
        //   final y = double.parse(data['$index']['y']);
        //   print("$x, $y");
        //
        //   return Placemark(
        //       onTap: (Placemark self, Point point) {
        //         print('Tapped placemark at ' + placeholder[self.mapId.value].toString());
        //       },
        //       mapId: MapObjectId('$index'),
        //       point: Point(latitude: y, longitude: x),
        //       icon: PlacemarkIcon.single(
        //           PlacemarkIconStyle(
        //           image:
        //               BitmapDescriptor.fromAssetImage('assets/map/place.png'),
        //           scale: 1)),);
        // });
      //  setPlacemark(growableList);
        return data;
      }
    } on Failure catch (f) {
      //_setFailure(f);
    }
    return {};
    //   _setState(NotifierState.loaded);
  }

// Future<String> placemarks(context) async {
//   String data = await DefaultAssetBundle.of(context).loadString("assets/output.json");
//   return data;
// }


  final _userRepository = ApiClient();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  late String email = '';
  void setEmail(value) {
    email = value;
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
            builder: (BuildContext context) => MapScreen(),
          ),
              (route) => false,
        );
      }
    } on Failure catch (f) {
      _setFailure(f);
    }
  }
}

