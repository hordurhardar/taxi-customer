import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';

class GoogleMapWidget extends StatefulWidget {
  final double width;
  final double height;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final Function? onCameraMove;

  const GoogleMapWidget({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.markers,
    this.polylines,
    this.onCameraMove,
  });

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  // BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    //  addCustomIcon();
    super.initState();
  }

  /* void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), AppImages.carYellowImage)
        .then(
          (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, value, child) {
        return Scaffold(
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 100.0),
          //   child: FloatingActionButton.extended(
          //     onPressed: () async {
          //       await context.read<HomeProvider>().getCurrentPosition(context: context);
          //       await context.read<MapProvider>().moveCamera(context.read<HomeProvider>().currentPosition!, context.read<HomeProvider>().currentAddress ?? "");
          //     },
          //     label: Text('My Location'),
          //     icon: Icon(Icons.location_on),
          //   ),
          // ),
          body: SizedBox(
            width: widget.width,
            height: widget.height,
            child: GoogleMap(
              // myLocationButtonEnabled: true,
              // myLocationEnabled: true,
              zoomGesturesEnabled: true,
              // scrollGesturesEnabled: false,
              // tiltGesturesEnabled: false,
              // rotateGesturesEnabled: false,
              zoomControlsEnabled: true,

              mapType: MapType.normal,
              initialCameraPosition: value.cameraPosition ??
                  const CameraPosition(
                    target: LatLng(26.45, 75.80),
                    zoom: 16,
                  ),
              markers: widget.markers ?? {},
              polylines: widget.polylines ?? {},
              onCameraMove: (CameraPosition cameraPosition) async {
                await context
                    .read<MapProvider>()
                    .onCameraMove(cameraPosition: cameraPosition);
                if (widget.onCameraMove != null) {
                  widget.onCameraMove!(value.controller.text);
                }
                context.read<HomeProvider>().currentPosition =
                    cameraPosition.target;
              },
              onCameraIdle: () async {
                await context.read<MapProvider>().onCameraIdle();
              },
              onMapCreated: (GoogleMapController controller) async {
                await context
                    .read<MapProvider>()
                    .initController(controller, context);
              },
            ),
          ),
        );
      },
    );
  }

// Marker(
// markerId: const MarkerId("marker1"),
// position: const LatLng(37.422131, -122.084801),
// draggable: true,
// onDragEnd: (value) {
// // value is the new position
// },
// //icon: BitmapDescriptor.fromBytes(
// //await getBytesFromAsset(AppImages.carYellowImage, 50)),
// ),
}
