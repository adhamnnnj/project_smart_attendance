import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'AttendanceScreen.dart';
import 'AttendanceRecordScreen.dart'; // Ensure this file exists
import 'package:flutter/material.dart';
import 'BeaconHelper.dart';
import 'firestore_service.dart'; // Your helper class file
import 'LoginScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isScanning = false;
  String selectedCourse = "Network Protocols";

  final Map<String, String> courseMACs = {
    'Network Protocols': '18:FA:B7:65:4F:F1', // Real beacon
  };

  Future<void> _checkPermissionsAndStartScan() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      _startScan();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bluetooth or Location permission not granted")),
      );
    }
  }

  void _startScan() async {
    if (isScanning) return;

    final String targetMAC = courseMACs[selectedCourse]!;

    setState(() => isScanning = true);

    bool found = false;

    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    final subscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.id.id == targetMAC) {
          found = true;
          FlutterBluePlus.stopScan();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AttendanceScreen(
                    courseName: selectedCourse,
                    rssi: r.rssi,
                    MACAddress: r.device.id.id,
                  ),
            ),
          );
          break;
        }
      }
    });

    await Future.delayed(Duration(seconds: 5));
    await FlutterBluePlus.stopScan();
    subscription.cancel();

    if (!found) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Beacon not found for selected course.")),
      );
    }

    setState(() => isScanning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Smart Attendance'),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCourse,
              decoration: InputDecoration(
                labelText: 'Select Course',
                border: OutlineInputBorder(),
              ),
              items: courseMACs.keys.map((course) =>
                  DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  )).toList(),
              onChanged: (value) {
                setState(() => selectedCourse = value!);
              },
            ),
            SizedBox(height: 32),



            ElevatedButton(
              onPressed: _checkPermissionsAndStartScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: isScanning
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                'Mark Attendance',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16), // Spacing between the buttons
            ElevatedButton(
              onPressed: () {
                BeaconHelper.startBeacon();
              },
              child: Text("Start Beacon"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AttendanceRecordScreen(), // You must create this screen
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'Check Attendance Record',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }}