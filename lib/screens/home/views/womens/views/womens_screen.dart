import 'package:flutter/material.dart';

import '../../../../../components/product/product_card.dart';
import '../../../../../components/skleton/product/products_skelton.dart';
import '../../../../../constants.dart';
import '../../../../../models/product_model.dart';
import '../../../../../route/route_constants.dart';
import '../../../../../services/get_category_by_name.dart';

class WomensScreen extends StatelessWidget {
  const WomensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Women’s',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<ProductModel2>>(
        future:
            GetCategoryByNameService().getCategoryByName("women's clothing"),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<ProductModel2> products = snapshot.data!;
            return GridView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.all(defaultPadding),
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.67,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    image: products[index].image,
                    brandName: products[index].category,
                    title: products[index].title,
                    price: products[index].price,
                    press: () {
                      Navigator.pushNamed(context, productDetailsScreenRoute,
                          arguments: {
                            'isProductAvailable': true,
                            'product': products[index],
                          });
                    },
                  );
                });
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProductsSkelton();
          }

          return const Center(
            child: Text("No products found"),
          );
        },
      ),
    );
  }
}
