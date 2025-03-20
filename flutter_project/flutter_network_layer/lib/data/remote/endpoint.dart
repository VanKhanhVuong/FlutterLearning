import 'package:dio/dio.dart';

abstract class Endpoint<T> {
  String get baseURL;
  String get path;
  String get url => '$baseURL$path';
  Map<String, dynamic>? get parameters;
  HTTPMethod get method;
  Map<String, String>? get httpHeaderFields;
  dynamic get httpBody;
}

abstract class NetworkLayerConfigure<T> extends Endpoint<T> {
  @override
  String get baseURL => 'https://vnew.vankhanhvuong.com';

  @override
  Map<String, dynamic>? get parameters => throw UnimplementedError();

  @override
  get httpBody => throw UnimplementedError();

  RequestOptions toRequestOptions() {
    return RequestOptions(
      path: url,
      method: method.value,
      headers: httpHeaderFields,
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
