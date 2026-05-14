
import 'package:apis_auth_jwt/ApiAuth/api_client.dart';
import 'package:apis_auth_jwt/ApiAuth/api_repository.dart';
import 'package:apis_auth_jwt/ApiAuth/secure_storage_service.dart';
import 'package:apis_auth_jwt/Home/HomeScreen.dart';
import 'package:apis_auth_jwt/Home/home_bloc.dart';
import 'package:apis_auth_jwt/Login/login.dart';
import 'package:apis_auth_jwt/Login/login_bloc.dart';
import 'package:apis_auth_jwt/SplashScreen/auth_bloc.dart';
import 'package:apis_auth_jwt/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final storage = SecureStorageService();
  late final apiClient = ApiClient(storage);
  late final repository = ApiRepository(apiClient, storage);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(repository)),
        BlocProvider(create: (_) => AuthBloc(repository)),
        BlocProvider(create: (_) => HomeBloc(repository)),
      ],
      child: FlavorBanner(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginScreen(),
          },
        ),
      ),
    );
  }
}
