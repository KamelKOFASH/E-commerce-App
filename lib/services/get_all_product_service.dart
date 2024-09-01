import 'dart:convert';

import 'package:shop/models/product_model.dart';
import 'package:http/http.dart' as http;

class GetAllProductService {
  Future<List<ProductModel>> getAllProducts() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProductModel> productsList = [];

      for (int i = 0; i < data.length; i++) {
        productsList.add(ProductModel.fromJson(data[i]));
      }
      return productsList;
    } else {
      throw Exception(
          'Failed to load products , There is problem with status code ${response.statusCode}');
    }
  }
}
