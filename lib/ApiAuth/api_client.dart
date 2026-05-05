import 'package:apis_auth_jwt/ApiAuth/secure_storage_service.dart';
import 'package:apis_auth_jwt/ApiConfig/api_config.dart';
import 'package:dio/dio.dart';

class ApiClient {
  late Dio dio;
  late final SecureStorageService storage;

  ApiClient(this.storage) {
    dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await storage.getAccessToken();
      if (token != null) {
        options.headers["Authorization"] = 'Bearer ${token}';
      }

      return handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        try {
          final newToken = await _refreshToken();
          if (newToken != null) {
            final requestOption = error.requestOptions;
            requestOption.headers["Authorization"] = 'Bearer $newToken';
            final cloneReq = await dio.fetch(requestOption);
            return handler.resolve(cloneReq);
          }
        } catch (e) {
          await storage.clear();
        }
        return handler.next(error);
      }
    }));
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await storage.getRefreshToken();
    final refreshDio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

    final response = await refreshDio.post(
      "/auth/refresh",
      data: {"refreshToken": refreshToken},
    );
    final newAccessToken = response.data["accessToken"];
    final newRefreshToken = response.data["refreshToken"];

    await storage.saveToken(newAccessToken, newRefreshToken);

    return newAccessToken;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return await dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return await dio.patch(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await dio.delete(path);
  }
}
