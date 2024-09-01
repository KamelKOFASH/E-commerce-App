import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/product_model.dart';

class GetCategoryByNameService {
  Future<List<ProductModel>> getCategoryByName(String name) async {
    http.Response response = await http
        .get(Uri.parse("https://fakestoreapi.com/products/category/$name"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProductModel> productsList = [];
      for (int i = 0; i < data.length; i++) {
        productsList.add(ProductModel.fromJson(data[i]));
      }
      return productsList;
    } else {
      throw Exception(
          'Failed to load category , There is problem with status code ${response.statusCode}');
    }
  }
}
