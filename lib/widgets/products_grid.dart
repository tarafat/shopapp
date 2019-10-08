import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavourite;
  ProductsGrid(this.isFavourite);
  @override
  Widget build(BuildContext context) {
   // print('Product Grid Called with value $isFavourite');
    final products = Provider.of<Products>(context);
    final _lodedProducts = isFavourite ? products.showFavourite : products.item;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: _lodedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: _lodedProducts[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
