import 'package:shop/models/product_model.dart';

import '../helper/api.dart';

class GetCategoryByNameService {
  Future<List<ProductModel>> getCategoryByName(String name) async {
    List<dynamic> data = await Api().get(
      url: "https://fakestoreapi.com/products/category/$name",
    );
    List<ProductModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(
        ProductModel.fromJson(data[i]),
      );
    }
    return productsList;
  }
}
