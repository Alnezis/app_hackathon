import 'dart:math';
import 'package:app_hackathon/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(40.0),
          children: [
            //todo
            Image.asset(
              "assets/images/logo.png",
              width: 120,
            ),
            SizedBox(
              height: 100,
            ),

            ElevatedButton(
              onPressed: () {
                //TODO
              },
              child: const Text("Регистрация",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(120, 44)),
                backgroundColor: MaterialStateProperty.all(
                  kAccentColor,
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
               // Navigator.replaceRouteBelow(context, AuthScreen.id);
                Navigator.of(context).pushNamed('auth_screen');
              },
              child: const Text("Авторизация",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(180, 44)),
                backgroundColor: MaterialStateProperty.all(
                   kAccentColor,
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
