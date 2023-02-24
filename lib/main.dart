import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:what_is_my_ip/model/ip_entity.dart';
import 'package:what_is_my_ip/model/ip_info_entity.dart';
import 'package:what_is_my_ip/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "What\'s my IP",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'What\'s my IP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapController mapController = MapController();
  LatLng? latLng;
  IPEntity? ipAddress;
  IPInfoEntity? ipInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ipCalls();
  }

  ipCalls() async {
    ipAddress = await APIService.getIpAddress();
    print("${ipAddress?.ip}");
    ipInfo = await APIService.getIpInfo(ip: "${ipAddress?.ip}");
    print("${ipInfo?.loc}");
    String location = "${ipInfo?.loc}";
    List<String> parts = location.split(",");
    double latitude = double.parse(parts[0]);
    double longitude = double.parse(parts[1]);
    latLng = LatLng(latitude, longitude);
    setState(() {});
    print(latLng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: latLng == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: LatLng(latLng!.latitude, latLng!.longitude),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          // "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          "https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          point: LatLng(latLng!.latitude, latLng!.longitude),
                          builder: (context) => Icon(Icons.location_on),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.white.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          IPAddressInfoWidget(
                              title: "IP Address:", ipInfo: ipInfo!.ip!),
                          IPAddressInfoWidget(
                              title: "City:", ipInfo: ipInfo!.city!),
                          IPAddressInfoWidget(
                              title: "Region:", ipInfo: ipInfo!.region!),
                          IPAddressInfoWidget(
                              title: "TimeZone:", ipInfo: ipInfo!.timezone!),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class IPAddressInfoWidget extends StatelessWidget {
  const IPAddressInfoWidget({
    Key? key,
    required this.title,
    required this.ipInfo,
  }) : super(key: key);

  final String ipInfo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(ipInfo),
      ],
    );
  }
}
