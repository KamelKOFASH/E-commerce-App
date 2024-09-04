import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/components/Banner/S/banner_s_style_1.dart';
import 'package:shop/components/Banner/S/banner_s_style_5.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/screen_export.dart';

import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            // const SliverPadding(
            //   padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
            //   sliver: SliverToBoxAdapter(child: FlashSale()),
            // ),
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       // While loading use 👇
            //       // const BannerMSkelton(),‚
            //       BannerSStyle1(
            //         title: "New \narrival",
            //         subtitle: "SPECIAL OFFER",
            //         discountParcent: 50,
            //         press: () {
            //           Navigator.pushNamed(context, onSaleScreenRoute);
            //         },
            //       ),
            //       const SizedBox(height: defaultPadding / 4),
            //       // We have 4 banner styles, all in the pro version
            //     ],
            //   ),
            // ),
            const SliverToBoxAdapter(child: BestSellers()),
            const SliverToBoxAdapter(child: MostPopular()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding * 1.5),

                  const SizedBox(height: defaultPadding / 4),
                  // While loading use 👇
                  // const BannerSSkelton(),
                  BannerSStyle5(
                    image: "https://i.imgur.com/${[
                      "9bZr;W8",
                      "FfV;W3M",
                      "Lp0D6k5",
                      "UM3GdWg"
                    ][Random().nextInt(4)]}.png",
                    title: "Black \nfriday",
                    subtitle: "50% Off",
                    bottomText: "Collection".toUpperCase(),
                    press: () {
                      Navigator.pushNamed(context, womensScreenRoute);
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
