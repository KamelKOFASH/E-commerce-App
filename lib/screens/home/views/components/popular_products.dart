import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model_demo.dart';
import 'package:shop/route/screen_export.dart';

import '../../../../components/skleton/product/products_skelton.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';
import '../../../../services/get_all_product_service.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Popular products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const ProductsSkelton(),
        FutureBuilder<List<ProductModel2>>(
          future: GetAllProductService().getAllProducts2(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProductsSkelton();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<ProductModel2> products = snapshot.data!;
              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == products.length - 1 ? defaultPadding : 0,
                    ),
                    child: ProductCard(
                      image: products[index].image,
                      brandName: products[index].category,
                      title: products[index].title,
                      price: products[index].price,
                      dicountpercent: demoFlashSaleProducts[
                              index % demoFlashSaleProducts.length]
                          .dicountpercent,
                      priceAfetDiscount: demoBestSellersProducts[
                              index % demoBestSellersProducts.length]
                          .priceAfetDiscount,
                      press: () {
                        Navigator.pushNamed(context, productDetailsScreenRoute,
                            arguments: index.isEven);
                      },
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("No products available"),
              );
            }
          },
        )
      ],
    );
  }
}
