import 'package:dio/dio.dart';

abstract class Endpoint<T> {
  String get baseURL;
  String get path;
  String get url => '$baseURL$path';

  Map<String, dynamic>? get parameters => null;
  HTTPMethod get method;
  Map<String, String>? get httpHeaderFields => {};
  dynamic get httpBody => null;
}

abstract class NetworkLayerConfigure<T> extends Endpoint<T> {
  @override
  String get baseURL => 'https://vnew.vankhanhvuong.com';

  @override
  Map<String, dynamic>? get parameters => null;

  @override
  dynamic get httpBody => null;

  RequestOptions toRequestOptions() {
    return RequestOptions(
      path: url,
      method: method.value,
      headers: httpHeaderFields,
      queryParameters: parameters,
      data: httpBody,
    );
  }
}

enum HTTPMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE');

  final String value;
  const HTTPMethod(this.value);
}
