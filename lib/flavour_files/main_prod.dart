import 'package:apis_auth_jwt/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: "PROD",
    color: Colors.green,
    location: BannerLocation.bottomStart,
    variables: {
      "baseUrl": "",
      "Api_key": "",
    },
  );
  runApp(MyApp());
}
