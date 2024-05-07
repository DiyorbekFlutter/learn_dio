import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
sealed class DioService {
  static const bool isTester = true;

  static const serverDevelopment = 'https://dummyjson.com';
  static const serverDeployment = 'https://dummyjson.com';
  static const apiAllProducts = '/products';

  static final Dio _dio = Dio(_baseOptions);

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: isTester ? serverDevelopment : serverDeployment,
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    contentType: 'application/json',
    validateStatus: (statusCode) => [200, 201].contains(statusCode)
  );

  static Future<Map<String, dynamic>?> get(String api) async {
    try{
      Response response = await _dio.get(api);
      return response.data;
    } catch(e){
      return null;
    }
  }

  static Future<String?> post(String api, Map<String, dynamic> data) async {
    try{
      Response response = await _dio.post(api, data: data);
      return response.data;
    } catch(e){
      return null;
    }
  }

  static Future<String?> put(String api, String id, Map<String, dynamic> data) async {
    try{
      Response response = await _dio.put('$api/$id', data: data);
      return response.data;
    } catch(e){
      return null;
    }
  }

  static Future<String?> delete(String api, String id) async {
    try{
      Response response = await _dio.delete('$api/$id');
      return response.data;
    } catch(e){
      return null;
    }
  }
}
