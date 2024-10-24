import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ResultForIceland extends StatefulWidget {
  const ResultForIceland({super.key});

  @override
  _ResultForIcelandState createState() => _ResultForIcelandState();
}

class _ResultForIcelandState extends State<ResultForIceland> {
  String userCountry = '';
  bool isIceland = false;

  @override
  void initState() {
    super.initState();
    _getLocationAndCheckCountry();
  }

  // Function to check the location and country
  Future<void> _getLocationAndCheckCountry() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get the place marks for the current position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Check the country from the placemarks
    if (placemarks.isNotEmpty) {
      String country = placemarks[0].country ?? '';
      print(country);
      setState(() {
        userCountry = country;
        isIceland = (country == 'Iceland');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results in Iceland'),
      ),
      body: Center(
        child: isIceland
            ? _showResults() // Display results if the user is in Iceland
            : Text(
                'You are not in Iceland',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
      ),
    );
  }

  // Method to show API result
  Widget _showResults() {
    // Replace this with your actual API result display logic
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to Iceland!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Display API results here
        Text(
          'Here are your results...',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
