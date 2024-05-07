import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
sealed class MockApiService {
  static const bool isTester = true;

  static const serverDevelopment = 'https://65e04610d3db23f76248cbbc.mockapi.io';
  static const serverDeployment = 'https://65e04610d3db23f76248cbbc.mockapi.io';
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

  static Future<List?> get(String api) async {
    try{
      Response response = await _dio.get(api);
      return response.data;
    } catch(e){
      return null;
    }
  }

  static Future<bool> post(String api, Map<String, dynamic> data) async {
    try{
      await _dio.post(api, data: data);
      return true;
    } catch(e){
      return false;
    }
  }

  static Future<bool> put(String api, int id, Map<String, dynamic> data) async {
    try{
      await _dio.put('$api/$id', data: data);
      return true;
    } catch(e){
      return false;
    }
  }

  static Future<bool> deleteProduct(String api, int id, Map<String, dynamic> data) async {
    try{
      Response response = await _dio.delete('$api/$id', data: data);
      log(response.statusCode.toString());
      return true;
    } catch(e){
      log("catch: $e");
      return false;
    }
  }
}
