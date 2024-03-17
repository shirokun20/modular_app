import 'package:my_dependencies/dependencies.dart';
import 'storage_util.dart';

class NetworkUtil {
  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(seconds: 40),
  ))..interceptors.add(
    LogInterceptor(responseBody: true, requestBody: true, requestHeader: true),
  );

  static Dio get dioClient {
    final storage = Get.find<StorageUtil>();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (option, handler) async {
          final token = await storage.getToken();
          if (token != null) {
            option.headers['Authorization'] = 'Bearer $token';
            option.headers['Accept'] = 'application/json';
          }
          return handler.next(option);
        },
        onError: (error, handler) async {
          final token = await storage.getToken();
          if (error.response?.statusCode == 401 && token != null) {
            await storage.removeAll();
          }
          return handler.next(error);
        },
      ),
    );
    return _dio;
  }
}