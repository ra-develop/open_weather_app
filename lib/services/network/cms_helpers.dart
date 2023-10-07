import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';

import '../core/config.dart';

/*
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(dioBaseOptions());
  return dio;
});
*/

BaseOptions dioBaseOptions() {
  return BaseOptions(
    baseUrl: Config.getBaseUrl,
    contentType: 'application/x-www-form-urlencoded',
    // connectTimeout: 5000,
  );
}

// Resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
// for Dio
/*
void certificateVerifyResolve(Dio dio) {
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
}
*/

// Resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
// for Global
class CertificateVerifyResolve extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void dioErrorHandler(DioError e, {String? moduleName}) {
  // The request was made and the server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  // print("DioError.message:\n" + e.message);
  developer.log("DioError.message",
      name: moduleName != null ? "Module name: $moduleName" : "Dio",
      error: e.message);
  if (e.response != null) {
    // print("DioError.response.data:\n${e.response!.data}");
    developer.log("\n${e.response!.data}", name: "DioError.response.data");
    // print("DioError.response.headers:\n${e.response!.headers}");
    developer.log("\n${e.response!.headers}",
        name: "DioError.response.headers");
    // developer.log(
    //   "\n" + e.response!.requestOptions.baseUrl.toString(),
    //   name: "DioError.requestOptions.baseUrl",
    // );
    developer.log(
      e.response!.requestOptions.uri.origin.toString(),
      name: "DioError.requestOptions.uri.origin",
    );
    developer.log(
      e.response!.requestOptions.uri.path.toString(),
      name: "DioError.requestOptions.uri.path",
    );
    developer.log(
      "\n" + e.requestOptions.queryParameters.toString(),
      name: "DioError.requestOptions.queryParameters",
    );
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    // print("DioError.requestOptions:\n" + e.requestOptions.toString());
    developer.log("\n" + e.requestOptions.toString(),
        name: "DioError.requestOptions");
  }
}
