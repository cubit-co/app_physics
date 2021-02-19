import 'package:dio/dio.dart';

const API_URL = 'https://api-dev.cubit.com.co/v1/physics-service';

final _serviceOptions = BaseOptions(
  baseUrl: API_URL,
  receiveTimeout: 10,
);

final apiService = Dio(_serviceOptions);
