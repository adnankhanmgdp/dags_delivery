import 'dart:math';

import 'package:dags_delivery_app/Common/utils/LogisticModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Common/widgets/app_bar.dart';
import '../../../Features/MapScreen/view/widgets/map_wdts.dart';
import '../Provider/map_notifier.dart';

class MapScreen extends ConsumerStatefulWidget {
  final LatLng initialLocation;
  final bool showGeoAndPoly;
  final String orderStatus;
  Map<String, dynamic> user;
  Map<String, dynamic> vendor;
  final String orderLocation;

  MapScreen(
      {Key? key,
      required this.initialLocation,
      this.showGeoAndPoly = false,
      this.user = const {"user": null},
      this.vendor = const {"vendor": null},
      this.orderLocation = "",
      required this.orderStatus})
      : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  LatLng? _currentLocation;
  bool _locationEnabled = false;
  bool reachedPickupLocation = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
    print(widget.user);
    print(widget.vendor);
  }

  Future<void> _checkPermissionsAndGetLocation() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || status.isRestricted) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.locationWhenInUse].request();

      if (statuses[Permission.locationWhenInUse]?.isGranted ?? false) {
        await _getCurrentLocation();
      } else {
        await _getCurrentLocation();
        if (kDebugMode) {
          print("Location permission denied");
        }
      }
    } else if (status.isGranted) {
      await _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _locationEnabled = true;
    });
  }

  List<LatLng> _calculateBezierPoints(LatLng start, LatLng end) {
    double distance = sqrt(pow(end.latitude - start.latitude, 2) +
        pow(end.longitude - start.longitude, 2));
    distance = double.parse(distance.toStringAsFixed(2));
    List<LatLng> points = [];
    print("---->$distance");
    if (distance > 0) {
      double curveHeight = max(0.01, distance * 0.3);
      double controlX = (start.latitude + end.latitude) / 2;
      double controlY = (start.longitude + end.longitude) / 2 - curveHeight;
      LatLng controlPoint = LatLng(controlX, controlY);

      int segments = 100; // Increase for a smoother curve
      for (int i = 0; i <= segments; i++) {
        double t = i / segments;
        double x = (1 - t) * (1 - t) * start.latitude +
            2 * (1 - t) * t * controlPoint.latitude +
            t * t * end.latitude;
        double y = (1 - t) * (1 - t) * start.longitude +
            2 * (1 - t) * t * controlPoint.longitude +
            t * t * end.longitude;
        points.add(LatLng(x, y));
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    bool isOnline = ref.watch(mapNotifierProvider);
    if (kDebugMode) {
      print("location is -> ${widget.initialLocation}");
      print("curr: ->$_currentLocation");
    }
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child:
                isOnline ? _buildOnlineMapContent() : _buildOfflineMapContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineMapContent() {
    LatLng centerPoint;

    if (_currentLocation != null) {
      centerPoint = LatLng(
        (_currentLocation!.latitude + widget.initialLocation.latitude) / 2,
        (_currentLocation!.longitude + widget.initialLocation.longitude) / 2,
      );
    } else if (_currentLocation != null) {
      centerPoint = _currentLocation!;
    } else {
      centerPoint = widget.initialLocation;
    }

    LatLngBounds bounds;

    if (_currentLocation != null && widget.initialLocation != null) {
      bounds = LatLngBounds(_currentLocation!, widget.initialLocation);
    } else if (_currentLocation != null) {
      bounds = LatLngBounds(_currentLocation!, _currentLocation!);
    } else if (widget.initialLocation != null) {
      bounds = LatLngBounds(widget.initialLocation, widget.initialLocation);
    } else {
      bounds = LatLngBounds(
          const LatLng(0, 0), const LatLng(0, 0)); // Default bounds
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_currentLocation == null)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else
          Expanded(
            child: FlutterMap(
                options: MapOptions(
                  bounds: bounds,
                  boundsOptions:
                      const FitBoundsOptions(padding: EdgeInsets.all(50)),
                  initialCenter: _currentLocation!,
                  initialZoom: 15.2,
                  center: centerPoint,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.dags.logistics',
                  ),
                  MarkerLayer(markers: [
                    Marker(
                        point: _currentLocation!,
                        child: Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.blue,
                        )),
                    Marker(
                        point: widget.initialLocation,
                        child: Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        )),
                  ]),
                  // CircleLayer(
                  //   circles: [
                  //     CircleMarker(
                  //       point: _currentLocation!,
                  //       color: Colors.blue.withOpacity(0.7),
                  //       borderStrokeWidth: 2,
                  //       borderColor: Colors.blue,
                  //       radius: 12,
                  //     ),
                  //     if (widget.showGeoAndPoly)
                  //       CircleMarker(
                  //         point: widget.initialLocation,
                  //         color: Colors.red.withOpacity(0.7),
                  //         borderStrokeWidth: 2,
                  //         borderColor: Colors.red,
                  //         radius: 12,
                  //       ),
                  //   ],
                  // ),
                  if (widget.showGeoAndPoly &&
                      _currentLocation != null &&
                      widget.initialLocation != null) ...[
                    PolylineLayer(
                      polylines: [
                        // Polyline(
                        //   points: _calculateBezierPoints(
                        //           _currentLocation!, widget.initialLocation)
                        //       .map((point) {
                        //     return LatLng(point.latitude + 0.00005,
                        //         point.longitude + 0.00005);
                        //   }).toList(),
                        //   color: Colors.transparent,
                        //   strokeWidth: 6.0,
                        // ),
                        Polyline(
                          points: _calculateBezierPoints(
                              _currentLocation!, widget.initialLocation),
                          color: Colors.black,
                          strokeWidth: 3.0,
                          isDotted: true,
                        ),
                      ],
                    ),
                  ]
                ]),
          ),
        _mapOnlineTitleRow(
          onlineButton: () {
            ref.read(mapNotifierProvider.notifier).changeBool(false);
          },
        ),
        bottomCard(context, reachedPickupLocation, () {
          setState(() {
            reachedPickupLocation = !reachedPickupLocation;
          });
        }, widget.initialLocation, widget.user, widget.vendor,
            LogisticModel.orderId, widget.orderStatus, widget.orderLocation),
      ],
    );
  }

  Widget _buildOfflineMapContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _mapOfflineTitleRow(
          onlineButton: () {
            ref.read(mapNotifierProvider.notifier).changeBool(true);
          },
        ),
      ],
    );
  }

  Widget _mapOnlineTitleRow({void Function()? onlineButton}) {
    return Container(
      color: Colors.white.withOpacity(0.3),
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: const Row(
        children: [
          SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 80,
          ),
        ],
      ),
    );
  }

  Widget _mapOfflineTitleRow({void Function()? onlineButton}) {
    return Container(
      color: Colors.white.withOpacity(0.3),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: const Row(
        children: [
          SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 80,
          ),
        ],
      ),
    );
  }
}
