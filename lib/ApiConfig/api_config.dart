
class ApiConfig{
  static const baseUrl = "https://dummyjson.com";


  // Endpoints
  static const login = "/auth/login";
  static const authMe = "/auth/me";
  static const recipes = "/recipes?limit=";

}



// import 'package:flutter_flavor/flutter_flavor.dart';
//
// // Get baseUrl
// final baseUrl = FlavorConfig.instance.variables["baseUrl"] as String;
//
// // Get flavor name
// final flavorName = FlavorConfig.instance.name; // "DEV", "STAGING", ""
//
// // Check if production
// final isProd = FlavorConfig.instance.name.isEmpty;