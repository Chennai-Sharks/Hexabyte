import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final List prodData;
  final List myLocation;
  const MapWidget({Key? key, required this.prodData, required this.myLocation}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.myLocation[0], widget.myLocation[1]),
        zoom: 8,
        // interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayerOptions(markers: [
          Marker(
            width: 100,
            height: 100,
            point: LatLng(widget.myLocation[0], widget.myLocation[1]),
            builder: (context) => Column(
              children: const [
                Text(
                  'Me',
                  style: TextStyle(backgroundColor: Colors.white),
                ),
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 30,
                ),
              ],
            ),
          ),
          // Marker(
          //   point: LatLng(28.6138954, 77.2090057),
          //   builder: (context) => const Icon(
          //     Icons.location_on,
          //     color: Colors.red,
          //     size: 30,
          //   ),
          // )
          ...(widget.prodData)
              .map((item) => Marker(
                    width: 120,
                    height: 120,
                    point: LatLng(item['location'][0], item['location'][1]),
                    builder: (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['food_waste_title'],
                          style: const TextStyle(
                            backgroundColor: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 40,
                        ),
                      ],
                    ),
                  ))
              .toList()
        ]),
      ],
    );
  }
}
