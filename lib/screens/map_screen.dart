import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:app_hackathon/provider/auth_notifer.dart';
import 'package:app_hackathon/provider/map_notifer.dart';
import 'package:app_hackathon/screens/widgets/control_button.dart';
import 'package:app_hackathon/screens/widgets/map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../main.dart';

// class MapScreen extends MapPage {
//   const MapScreen()
//       : super('ClusterizedPlacemarkCollection example');
//
//   @override
//   Widget build(BuildContext context) {
//     return _MapPage();
//   }
// }
//
// class _MapPage extends StatefulWidget {
//   @override
//   _MapState createState() =>
//       _MapState();
// }
//
// class _MapState
//     extends State<_MapPage>

class MapScreen extends StatefulWidget {
  static const String id = 'map_screen';

  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<MapObject> mapObjects = [];

  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  late Point userPosition = Point(latitude: 45.037458, longitude: 38.995687);

  late String category = 'all';

  update(category) async {
    final MapNotifier read = context.read<MapNotifier>();
    if (read.placeholder.isEmpty) {
      _showMessage(context, const Text('Загрузка данных...'));
      await read.initList();
    }

    if (mapObjects
        .any((el) => el.mapId == largeClusterizedPlacemarkCollectionId)) {
      _showMessage(context, const Text('return;'));
      return;
    }

    final data = read.placeholder;
    final growableList = List<Placemark>.empty(growable: true);

    data.forEach((key, value) {
      if (category != 'all' && !value['fractions'].contains(category)) {
        return;
      }

      late double x = double.parse(value['x']);
      final y = double.parse(value['y']);
      print("$x, $y");

      growableList.add(Placemark(
        onTap: (Placemark self, Point point) {
          _showModalBottomSheet(context, data['$key']);
          print('Tapped placemark at ' + self.mapId.value);
        },
        mapId: MapObjectId('$key'),
        point: Point(latitude: y, longitude: x),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/map/place.png'),
            scale: 1)),
      ));
    });

    final clusterizedPlacemarkCollection = ClusterizedPlacemarkCollection(
      mapId: largeClusterizedPlacemarkCollectionId,
      radius: 30,
      minZoom: 15,
      onClusterAdded:
          (ClusterizedPlacemarkCollection self, Cluster cluster) async {
        return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
                opacity: 0.75,
                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                    image: BitmapDescriptor.fromBytes(
                        await _buildClusterAppearance(cluster)),
                    scale: 1))));
      },
      onClusterTap: (ClusterizedPlacemarkCollection self, Cluster cluster) {
        print('Tapped cluster');
      },
      placemarks: growableList,
      onTap: (ClusterizedPlacemarkCollection self, Point point) =>
          print(self.props.reversed.first),
    );

    mapObjects.add(clusterizedPlacemarkCollection);
  }

  //45.037458, 38.995687

  final MapObjectId largeClusterizedPlacemarkCollectionId =
      MapObjectId('large_clusterized_placemark_collection');

  Future<Uint8List> _buildClusterAppearance(Cluster cluster) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(200, 200);
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final radius = 60.0;

    final textPainter = TextPainter(
        text: TextSpan(
            text: cluster.size.toString(),
            style: TextStyle(color: Colors.black, fontSize: 50)),
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset((size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  late YandexMapController controller;

  Future<bool> get locationPermissionNotGranted async =>
      !(await Permission.location.request().isGranted);

  void _showMessage(BuildContext context, Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }

  @override
  Widget build(BuildContext context) {
    final MapNotifier read = context.read<MapNotifier>();

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 20,
              right: 30,
              child: FloatingActionButton(
                heroTag: 'next',
                onPressed: () async {
                  if (await locationPermissionNotGranted) {
                    _showMessage(context,
                        const Text('Location permission was NOT granted'));
                    return;
                  }

                  await controller.toggleUserLayer(visible: true);

                  await controller.moveCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(target: userPosition)),
                      animation: animation);
                },
                child: const Icon(
                  Icons.my_location,
                  size: 25,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            // Add more floating buttons if you want
            // There is no limit
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  listCategories(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.account_box),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, 'auth_screen');
                },
              ),
            ],
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: YandexMap(
                      onMapCreated:
                          (YandexMapController yandexMapController) async {
                        controller = yandexMapController;
                      },
                      onUserLocationAdded: (UserLocationView view) async {
                        // userPosition = view.arrow.point;

                        return view.copyWith(
                            pin: view.pin.copyWith(
                                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                    image: BitmapDescriptor.fromAssetImage(
                                        'assets/map/user.png')))),
                            arrow: view.arrow.copyWith(
                                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                    image: BitmapDescriptor.fromAssetImage(
                                        'assets/map/arrow.png')))),
                            accuracyCircle: view.accuracyCircle.copyWith(
                                fillColor: Colors.green.withOpacity(0.5)));
                      },
                      mapObjects: mapObjects))
            ]));
  }

  _showModalBottomSheet(context, p) {
    print(p);
    //final p = MapNotifier().placeholder['$keyPlacesmark'];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          // child: ElevatedButton(
          //   child: Text(p['address'].toString()+p['colors'][0]),
          //   style: ElevatedButton.styleFrom(
          //     primary: HexColor(p['colors'][0]),
          //   ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(p['address']),
                    Text("\n" + p['fractions'].toString()),
                  ],
                ),
                FloatingActionButton(
                  heroTag: 'next',
                  onPressed: () async {
                    late String url =
                        'https://yandex.ru/maps?whatshere%5Bpoint%5D=' +
                            p['x'] +
                            '%2C' +
                            p['y'] +
                            '&whatshere%5Bzoom%5D=16.037464&ll=38.997331%2C45.03968899961266&z=16.037464';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }

                    //маршрут
                  },
                  child: Icon(Icons.map),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
          // onPressed: () {
          //   Navigator.of(context).pop();
          // },
        );
      },
    );
  }

  listCategories(context) {
    //final p = MapNotifier().placeholder['$keyPlacesmark'];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          // child: ElevatedButton(
          //   child: Text(p['address'].toString()+p['colors'][0]),
          //   style: ElevatedButton.styleFrom(
          //     primary: HexColor(p['colors'][0]),
          //   ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  setState(() {
                    mapObjects.removeWhere((el) =>
                        el.mapId == largeClusterizedPlacemarkCollectionId);
                    update('plastik');
                  });
                  Navigator.of(context).pop();
                },
                child: Text("plastik"),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  setState(() {
                    mapObjects.removeWhere((el) =>
                        el.mapId == largeClusterizedPlacemarkCollectionId);
                    update('gradusniki');
                  });
                  Navigator.of(context).pop();
                },
                child: Text("gradusniki"),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  setState(() {
                    mapObjects.removeWhere((el) =>
                        el.mapId == largeClusterizedPlacemarkCollectionId);
                    update('steklo');
                  });
                  Navigator.of(context).pop();
                },
                child: Text("steklo"),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  setState(() {
                    mapObjects.removeWhere((el) =>
                        el.mapId == largeClusterizedPlacemarkCollectionId);
                    update('bymaga');
                  });
                  Navigator.of(context).pop();
                },
                child: Text("bymaga"),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  setState(() {
                    mapObjects.removeWhere((el) =>
                        el.mapId == largeClusterizedPlacemarkCollectionId);
                    update('metal');
                  });
                  Navigator.of(context).pop();
                },
                child: Text("metal"),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
