import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/app_bar_with_navigate_back.dart';
import '../widgets/tab_Bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../viewmodels/map_view_model.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}
bool showCircles = false;

class _MapState extends State<Map> {

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBarNavigateBack(title: localizations!.map),
      body: Column(
        children: [
          Expanded(
            child: content(),
          ),
          CheckboxListTile(
            title: Text(localizations.showNearPalce),
            value: showCircles,
            onChanged: (value) {
              setState(() {
                showCircles = value!;
              });
            },
          ),
          SizedBox(
            height: 60,
            child: NavigationExample(),
          ),

        ],
      ),
    );
  }
}


Widget content() {

  return FlutterMap(

    options: MapOptions(
        initialCenter: LatLng(31.9464, 35.3027),
        initialZoom: 6,
        interactionOptions: const InteractionOptions(flags: InteractiveFlag.doubleTapZoom | InteractiveFlag.drag)),



    children: [
      openStreetMapTileLayer,
      MarkerLayer(markers:[

        Marker(point: LatLng(32.2221, 35.2545),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,


            child: Icon(

              Icons.location_pin,
              size: 60,
              color: Colors.red ,

            )),
        Marker(point:  LatLng(31.7767, 35.2355),
          width: 60,
          height: 60,
          alignment: Alignment.centerLeft,

          child: Icon(

            Icons.location_pin,
            size: 60,
            color: Colors.red ,

          ),

        ),
        Marker(point:  LatLng(31.8564,35.4597),
          width: 60,
          height: 60,
          alignment: Alignment.centerLeft,

          child: Icon(

            Icons.location_pin,
            size: 60,
            color: Colors.red ,

          ),


        )
      ]),
      if (showCircles)
        CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(32.225358, 35.252100),
              color: Colors.blue.withOpacity(0.3),
              borderColor: Colors.blue,
              borderStrokeWidth: 2,
              useRadiusInMeter: true,
              radius: 1000,
            ),
            CircleMarker(
              point: LatLng(31.7767, 35.2390),
              color: Colors.blue.withOpacity(0.3),
              borderColor: Colors.blue,
              borderStrokeWidth: 2,
              useRadiusInMeter: true,
              radius: 10000,
            ),
            CircleMarker(
              point: LatLng(31.8564, 35.4597),
              color: Colors.blue.withOpacity(0.3),
              borderColor: Colors.blue,
              borderStrokeWidth: 2,
              useRadiusInMeter: true,
              radius: 10000,
            ),
          ],
        ),
    ],
  );
}


