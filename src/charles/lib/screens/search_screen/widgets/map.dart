import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(),
      layers: [
        MarkerLayerOptions(
          markers: [
            Marker(
              point: LatLng(30, 40),
              width: 80,
              height: 80,
              builder: (context) => const FlutterLogo(),
            ),
          ],
        ),
      ],
    );
  }
}
