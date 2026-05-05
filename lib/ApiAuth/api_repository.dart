import 'package:apis_auth_jwt/ApiAuth/api_client.dart';
import 'package:apis_auth_jwt/ApiAuth/secure_storage_service.dart';
import 'package:apis_auth_jwt/ApiConfig/api_config.dart';
import 'package:dio/src/response.dart';

class ApiRepository {
  late final ApiClient api;
  late final SecureStorageService storage;
  ApiRepository(this.api, this.storage);

  Future<void> login(String userName, String password) async {
    final res = await api.post(
      ApiConfig.login,
      data: {
        "username": userName,
        "password": password,
      },
    );
    print("response here");

    print(res);

    await storage.saveToken(res.data['accessToken'], res.data['refreshToken']);
  }

  Future<Response> getRecipesList(String limit, String skip) async {
    final response = await api.get("${ApiConfig.recipes}$limit&skip=${skip}");
    return response;
  }

  Future<bool> checkSession() async {
    try {
      final token = await storage.getAccessToken();
      if (token == null) return false;
      await api.get(ApiConfig.authMe);
      return true;
    } catch (e) {
      return false;
    }
  }
}
