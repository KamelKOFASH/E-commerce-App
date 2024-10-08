import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  //! get request
  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode}');
    }
  }

//! post request
  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

//! put request
  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      "Content-Type": "application/x-www-form-urlencoded",
    });
    if (token != null) {
      body.addAll({"Authorization": "Bearer $token"});
    }
    print('Url = ${url} , body = $body , token = $token');
    http.Response response = await http.put(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> delete({required String url}) async {
    http.Response response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> patch(
      {required String url, required Map<String, dynamic> body}) async {
    http.Response response = await http.patch(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> head({required String url}) async {
    http.Response response = await http.head(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode}');
    }
  }
}
