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
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(40.0),
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text("Авторизация", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: const Key("email"),
                      onChanged: (value) {
                        model.email = value;
                      },
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (email) {
                        if (isEmailValid(email!)) {
                          return null;
                        } else {
                          return 'Введите действительный адрес электронной почты';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      key: const Key("password"),
                      onChanged: (value) {
                        model.password = value;
                      },
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Обязательное поле';
                        }
                        // if (password.length < 8) {
                        //   return 'Пароль не менее 8 символов';
                        // }
                        return null;
                      },
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                    ),
                    const SizedBox(height: 8),
                    //   Text(context.watch<MainModel>().authError, style: TextStyle(color: Colors.red),),
                  //  const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Consumer<MapNotifier>(
              builder: (_, notifier, __) {
                if (notifier.state == NotifierState.loading) {
                  return Column(
                    children: const [
                      SizedBox(height: 8),
                      SpinKitFadingCube(
                          color: kAccentColor,
                          size: 30.0
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else if (notifier.state != NotifierState.loaded) {
                  if (notifier.error != null) {
                    return Text(
                      notifier.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    );
                  }
                }
                return Container();
              },
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (formGlobalKey.currentState!.validate()) {
                    formGlobalKey.currentState!.save();
                    setState(() {
                      // userFuture = userRepository.getUsers();
                      context
                          .read<MapNotifier>()
                          .auth(model.email, model.password, context);
                    });
                  }
                },
                child: const Text("Войти",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(180, 44)),
                backgroundColor: MaterialStateProperty.all(
                  kAccentColor,
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
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
