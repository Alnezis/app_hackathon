import 'package:app_hackathon/provider/auth_notifer.dart';
import 'package:app_hackathon/provider/map_notifer.dart';
import 'package:app_hackathon/screens/auth_screen.dart';
import 'package:app_hackathon/screens/home_screen.dart';
import 'package:app_hackathon/screens/main_screen.dart';
import 'package:app_hackathon/screens/loading_screen.dart';
import 'package:app_hackathon/screens/map_screen.dart';
import 'package:app_hackathon/screens/profile_screen.dart';
import 'package:app_hackathon/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapNotifier>(
        create: (context) => MapNotifier(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      title: 'ecoMEGA',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
       // ClusterizedPlacemarkCollectionPage
      home: MapScreen(),
        routes: {
          'auth_screen': (context) => AuthScreen(),
          'main_screen': (context) => MainScreen(),
          'loading_screen': (context) => LoadingScreen(),
          'map_screen': (context) => MapScreen(),
          'profile_screen': (context) => ProfileScreen(),
          'shop_screen': (context) => ShopScreen(),

        }
    )
    );
  }
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
