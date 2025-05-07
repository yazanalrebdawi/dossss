import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio {
  late Dio _dio;


  AppDio() {
    _dio = Dio();
    _addHeaderToDio();
    _addLogger();
  }

  _addHeaderToDio() {
    _dio.options.headers = {
      "Accept": Headers.jsonContentType,
    };
  }

  addTokenToHeader(String token) {
    _dio.options.headers = {
      "Authorization": "Bearer $token",
    };
  }

  _addLogger() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }

  Dio get dio => _dio;
}
