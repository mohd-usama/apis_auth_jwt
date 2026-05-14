

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import '../main.dart';

void main() {
  FlavorConfig(
    name: "STAGING",
    color: Colors.blue,
    location: BannerLocation.bottomStart,
    variables: {
      "baseUrl": "",
      "Api_key": "",
    },
  );
  runApp(MyApp());
}