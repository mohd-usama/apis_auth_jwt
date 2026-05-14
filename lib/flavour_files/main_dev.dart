import 'package:apis_auth_jwt/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: {
      "baseUrl": "",
      "Api_Key": "",
    },
  );
  runApp(MyApp());
}
