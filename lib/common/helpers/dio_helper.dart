import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  DioHelper({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<FormData> _mapToFormData(Map<String, dynamic> map) async {
    final multipartMap = Map.of(map);

    for (final item in map.entries) {
      if (item.value is File) {
        multipartMap[item.key] = await MultipartFile.fromFile((item.value as File).path);
      } else if (item.value is List<File>) {
        final files = item.value as List<File>;
        final filesList = <MultipartFile>[];
        for (final file in files) {
          filesList.add(await MultipartFile.fromFile(file.path));
        }
        multipartMap[item.key] = filesList;
      }
    }

    final originalFormData = FormData.fromMap(multipartMap);
    final mappedFormData = FormData();

    // Add fields
    mappedFormData.fields.addAll(originalFormData.fields.map((e) => MapEntry(e.key, e.value)));

    // Add files
    for (final element in originalFormData.files) {
      if (element.key.contains('[') || element.key.contains(']')) {
        final newKey = element.key.replaceAllMapped(RegExp('([+[a-zA-Z]+])'), (m) {
          return '${m[0]}'.replaceAll('[', '.').replaceAll(']', '');
        });
        final newValue = element.value;
        final newEntry = MapEntry(newKey, newValue);
        mappedFormData.files.add(newEntry);
      } else {
        mappedFormData.files.add(element);
      }
    }

    return mappedFormData;
  }

  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
    void Function(int count, int total)? onSendProgress,
  }) async {
    if (formData != null) {
      data = await _mapToFormData(formData);
    }

    return _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );
  }

  Future<Response<dynamic>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
  }) async {
    if (formData != null) {
      data = await _mapToFormData(formData);
    }

    return _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> download(
    String url,
    String savedPath, {
    void Function(int, int)? onReceiveProgress,
  }) {
    return _dio.download(url, savedPath, onReceiveProgress: onReceiveProgress);
  }
}
