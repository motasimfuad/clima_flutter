import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

Location _location;

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    _location = Location();

    await _location.getCurrentLocation();
    print(_location.latitude);
    print(_location.longitude);
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=72c769e50cee21c15e1a91ee859a513e'),
    );
    String data = response.body;

    // jsonDecode(data)['coord']['lon'];
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                //Get the current location
                getLocation();
              },
              child: Text('Get Location'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Latitude :',
                ),
                Text(
                  _location.latitude.toString() ?? 'No Info',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'longitude :',
                ),
                Text(
                  _location.longitude.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
