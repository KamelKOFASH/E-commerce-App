import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/components/product/secondary_product_card.dart';
import 'package:shop/components/skleton/product/secondery_produts_skelton.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/product_model_demo.dart';

import '../../../../constants.dart';
import '../../../../route/route_constants.dart';
import '../../../../services/get_all_product_service.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
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
            "Most popular",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // SeconderyProductsSkelton(),
        FutureBuilder<List<ProductModel2>>(
          future: GetAllProductService().getAllProducts2(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SeconderyProductsSkelton();
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<ProductModel2> products = snapshot.data!;
              final random = Random();
              final randomProducts = List.generate(
                products.length,
                (index) => products[random.nextInt(products.length)],
              );
              return SizedBox(
                height: 114,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: randomProducts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == randomProducts.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: SecondaryProductCard(
                      image: randomProducts[index].image,
                      brandName: randomProducts[index].category,
                      title: randomProducts[index].title,
                      price: demoPopularProducts[
                              index % demoPopularProducts.length]
                          .priceAfetDiscount,
                      priceAfetDiscount: randomProducts[index].price,
                      dicountpercent: demoPopularProducts[
                              index % demoPopularProducts.length]
                          .dicountpercent,
                      press: () {
                        Navigator.pushNamed(context, productDetailsScreenRoute,
                            arguments: {
                              'isProductAvailable': true,
                              'product': randomProducts[index],
                            });
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
