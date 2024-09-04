
import '../helper/api.dart';
import '../models/product_model.dart';

class GetCategoryByNameService {
  Future<List<ProductModel2>> getCategoryByName(String name) async {
    List<dynamic> data = await Api().get(
      url: "https://fakestoreapi.com/products/category/$name", token: '',
    );
    List<ProductModel2> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(
        ProductModel2.fromJson(data[i]),
      );
    }
    return productsList;
  }
}
