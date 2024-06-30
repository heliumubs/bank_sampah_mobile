import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  late String _csrfToken;
  final Dio _dio = Dio();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal();

  Future<void> initialize() async {
    _csrfToken = await _fetchCsrfToken();
  }

  Future<String> _fetchCsrfToken() async {
    try {
      Response response =
          await _dio.get('https://tugasinyuk.my.id/api/csrf-token');
      return response.data['csrfToken'];
    } catch (e) {
      print('Failed to get CSRF token: $e');
      return '';
    }
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    _csrfToken = await _fetchCsrfToken();
    print(_csrfToken);
    if (_csrfToken.isEmpty) {
      throw Exception('CSRF token is not initialized');
    }
// Update headers with latest CSRF token
    _dio.options.headers['X-CSRF-TOKEN'] = _csrfToken;
    try {
      Response response = await _dio.post(
        path,
        data: data,
      );
      return response;
    } catch (e) {
      print('Failed to post data: $e');
      throw e;
    }
  }

  // Tambahkan metode GET, PUT, DELETE jika diperlukan
}
