import 'package:app_hackathon/provider/map_notifer.dart';
import 'package:app_hackathon/screens/home_screen.dart';
import 'package:app_hackathon/screens/main_screen.dart';
import 'package:app_hackathon/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final MapNotifier model = context.read<MapNotifier>();
    return Dialog(
      child: Container(
          width: 382,
          height: 300,

          child: Stack(
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 382,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                            bottomLeft: Radius.circular(28),
                            bottomRight: Radius.circular(28),
                          ),
                          color : Color.fromRGBO(255, 255, 255, 1),
                        )
                    )
                ),Positioned(
                    top: 33,
                    left: 35,
                    child: Container(
                        width: 312,
                        height: 234,

                        child: Stack(
                            children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 295,
                                      height: 189,

                                      child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                    width: 81,
                                                    height: 86,

                                                    child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                  width: 81,
                                                                  height: 86,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius : BorderRadius.only(
                                                                      topLeft: Radius.circular(11),
                                                                      topRight: Radius.circular(11),
                                                                      bottomLeft: Radius.circular(11),
                                                                      bottomRight: Radius.circular(11),
                                                                    ),
                                                                    color : Color.fromRGBO(59, 56, 56, 1),
                                                                  )
                                                              )
                                                          ),Positioned(
                                                              top: 9,
                                                              left: 11,
                                                              child: Container(
                                                                  width: 59,
                                                                  height: 63,

                                                                  child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                            top: 0,
                                                                            left: 10,
                                                                            child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius : BorderRadius.only(
                                                                                    topLeft: Radius.circular(50),
                                                                                    topRight: Radius.circular(50),
                                                                                    bottomLeft: Radius.circular(50),
                                                                                    bottomRight: Radius.circular(50),
                                                                                  ),
                                                                                  color : Color.fromRGBO(22, 224, 30, 1),
                                                                                )
                                                                            )
                                                                        ),Positioned(
                                                                            top: 50,
                                                                            left: 0,
                                                                            child: Text('Органика', textAlign: TextAlign.left, style: TextStyle(
                                                                                color: Color.fromRGBO(255, 255, 255, 1),
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 11,
                                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                fontWeight: FontWeight.normal,
                                                                                height: 1
                                                                            ),)
                                                                        ),
                                                                      ]
                                                                  )
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                )
                                            ),Positioned(
                                                top: 0,
                                                left: 107,
                                                child: Container(
                                                    width: 81,
                                                    height: 86,

                                                    child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                  width: 81,
                                                                  height: 86,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius : BorderRadius.only(
                                                                      topLeft: Radius.circular(11),
                                                                      topRight: Radius.circular(11),
                                                                      bottomLeft: Radius.circular(11),
                                                                      bottomRight: Radius.circular(11),
                                                                    ),
                                                                    color : Color.fromRGBO(59, 56, 56, 1),
                                                                  )
                                                              )
                                                          ),Positioned(
                                                              top: 9,
                                                              left: 4,
                                                              child: Container(
                                                                  width: 74,
                                                                  height: 63,

                                                                  child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                            top: 0,
                                                                            left: 17,
                                                                            child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius : BorderRadius.only(
                                                                                    topLeft: Radius.circular(50),
                                                                                    topRight: Radius.circular(50),
                                                                                    bottomLeft: Radius.circular(50),
                                                                                    bottomRight: Radius.circular(50),
                                                                                  ),
                                                                                  color : Color.fromRGBO(244, 255, 244, 1),
                                                                                )
                                                                            )
                                                                        ),Positioned(
                                                                            top: 50,
                                                                            left: 0,
                                                                            child: Text('Аллюминий', textAlign: TextAlign.left, style: TextStyle(
                                                                                color: Color.fromRGBO(255, 255, 255, 1),
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 11,
                                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                fontWeight: FontWeight.normal,
                                                                                height: 1
                                                                            ),)
                                                                        ),
                                                                      ]
                                                                  )
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                )
                                            ),Positioned(
                                                top: 103,
                                                left: 107,
                                                child: Container(
                                                    width: 81,
                                                    height: 86,

                                                    child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                  width: 81,
                                                                  height: 86,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius : BorderRadius.only(
                                                                      topLeft: Radius.circular(11),
                                                                      topRight: Radius.circular(11),
                                                                      bottomLeft: Radius.circular(11),
                                                                      bottomRight: Radius.circular(11),
                                                                    ),
                                                                    color : Color.fromRGBO(59, 56, 56, 1),
                                                                  )
                                                              )
                                                          ),Positioned(
                                                              top: 9,
                                                              left: 4,
                                                              child: Container(
                                                                  width: 74,
                                                                  height: 63,

                                                                  child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                            top: 0,
                                                                            left: 17,
                                                                            child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius : BorderRadius.only(
                                                                                    topLeft: Radius.circular(50),
                                                                                    topRight: Radius.circular(50),
                                                                                    bottomLeft: Radius.circular(50),
                                                                                    bottomRight: Radius.circular(50),
                                                                                  ),
                                                                                  color : Color.fromRGBO(244, 255, 244, 1),
                                                                                )
                                                                            )
                                                                        ),Positioned(
                                                                            top: 50,
                                                                            left: 0,
                                                                            child: Text('Аллюминий', textAlign: TextAlign.left, style: TextStyle(
                                                                                color: Color.fromRGBO(255, 255, 255, 1),
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 11,
                                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                fontWeight: FontWeight.normal,
                                                                                height: 1
                                                                            ),)
                                                                        ),
                                                                      ]
                                                                  )
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                )
                                            ),Positioned(
                                                top: 103,
                                                left: 214,
                                                child: Container(
                                                    width: 81,
                                                    height: 86,

                                                    child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                  width: 81,
                                                                  height: 86,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius : BorderRadius.only(
                                                                      topLeft: Radius.circular(11),
                                                                      topRight: Radius.circular(11),
                                                                      bottomLeft: Radius.circular(11),
                                                                      bottomRight: Radius.circular(11),
                                                                    ),
                                                                  )
                                                              )
                                                          ),Positioned(
                                                              top: 9,
                                                              left: 18,
                                                              child: Container(
                                                                  width: 46,
                                                                  height: 63,

                                                                  child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                            top: 0,
                                                                            left: 3,
                                                                            child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius : BorderRadius.only(
                                                                                    topLeft: Radius.circular(50),
                                                                                    topRight: Radius.circular(50),
                                                                                    bottomLeft: Radius.circular(50),
                                                                                    bottomRight: Radius.circular(50),
                                                                                  ),
                                                                                  color : Color.fromRGBO(2, 163, 255, 1),
                                                                                )
                                                                            )
                                                                        ),Positioned(
                                                                            top: 50,
                                                                            left: 0,
                                                                            child: Text('Фосфат', textAlign: TextAlign.left, style: TextStyle(
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 11,
                                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                fontWeight: FontWeight.normal,
                                                                                height: 1
                                                                            ),)
                                                                        ),
                                                                      ]
                                                                  )
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                )
                                            ),Positioned(
                                                top: 0,
                                                left: 214,
                                                child: Container(
                                                    width: 81,
                                                    height: 86,

                                                    child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                  width: 81,
                                                                  height: 86,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius : BorderRadius.only(
                                                                      topLeft: Radius.circular(11),
                                                                      topRight: Radius.circular(11),
                                                                      bottomLeft: Radius.circular(11),
                                                                      bottomRight: Radius.circular(11),
                                                                    ),
                                                                  )
                                                              )
                                                          ),Positioned(
                                                              top: 9,
                                                              left: 11,
                                                              child: Container(
                                                                  width: 59,
                                                                  height: 63,

                                                                  child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                            top: 0,
                                                                            left: 10,
                                                                            child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius : BorderRadius.only(
                                                                                    topLeft: Radius.circular(50),
                                                                                    topRight: Radius.circular(50),
                                                                                    bottomLeft: Radius.circular(50),
                                                                                    bottomRight: Radius.circular(50),
                                                                                  ),
                                                                                  color : Color.fromRGBO(235, 27, 240, 1),
                                                                                )
                                                                            )
                                                                        ),Positioned(
                                                                            top: 50,
                                                                            left: 0,
                                                                            child: Text('Органика', textAlign: TextAlign.left, style: TextStyle(
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 11,
                                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                fontWeight: FontWeight.normal,
                                                                                height: 1
                                                                            ),)
                                                                        ),
                                                                      ]
                                                                  )
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                )
                                            ),Positioned(
                                                top: 103,
                                                left: 0,
                                                child: Container(
                                                    width: 81,
                                                    height: 86,

                                                    child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                  width: 81,
                                                                  height: 86,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius : BorderRadius.only(
                                                                      topLeft: Radius.circular(11),
                                                                      topRight: Radius.circular(11),
                                                                      bottomLeft: Radius.circular(11),
                                                                      bottomRight: Radius.circular(11),
                                                                    ),
                                                                  )
                                                              )
                                                          ),Positioned(
                                                              top: 9,
                                                              left: 11,
                                                              child: Container(
                                                                  width: 59,
                                                                  height: 63,

                                                                  child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                            top: 0,
                                                                            left: 10,
                                                                            child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius : BorderRadius.only(
                                                                                    topLeft: Radius.circular(50),
                                                                                    topRight: Radius.circular(50),
                                                                                    bottomLeft: Radius.circular(50),
                                                                                    bottomRight: Radius.circular(50),
                                                                                  ),
                                                                                  color : Color.fromRGBO(22, 224, 30, 1),
                                                                                )
                                                                            )
                                                                        ),Positioned(
                                                                            top: 50,
                                                                            left: 0,
                                                                            child: Text('Органика', textAlign: TextAlign.left, style: TextStyle(
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontFamily: 'Montserrat',
                                                                                fontSize: 11,
                                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                fontWeight: FontWeight.normal,
                                                                                height: 1
                                                                            ),)
                                                                        ),
                                                                      ]
                                                                  )
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                )
                                            ),
                                          ]
                                      )
                                  )
                              ),Positioned(
                                  top: 206,
                                  left: 188,
                                  child: Container(
                                      width: 124,
                                      height: 28,

                                      child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                    width: 124,
                                                    height: 28,
                                                    decoration: BoxDecoration(
                                                      borderRadius : BorderRadius.only(
                                                        topLeft: Radius.circular(6),
                                                        topRight: Radius.circular(6),
                                                        bottomLeft: Radius.circular(6),
                                                        bottomRight: Radius.circular(6),
                                                      ),
                                                      color : Color.fromRGBO(70, 108, 241, 1),
                                                    )
                                                )
                                            ),Positioned(
                                                top: 8,
                                                left: 41,
                                                child: Text('Искать', textAlign: TextAlign.left, style: TextStyle(
                                                    color: Color.fromRGBO(255, 255, 255, 1),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 11,
                                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight: FontWeight.normal,
                                                    height: 1
                                                ),)
                                            ),
                                          ]
                                      )
                                  )
                              ),
                            ]
                        )
                    )
                ),
              ]
          )
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isEmailValid(String email) {
    String pattern =
        "^([a-z0-9_-]+.)*[a-z0-9_-]+@[a-z0-9_-]+(.[a-z0-9_-]+)*.[a-z]{2,6}\$";
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
