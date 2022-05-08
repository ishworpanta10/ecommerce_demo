import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../products/data/fake_products_repositories.dart';
import '../../../products/domain/product.dart';

/// Shows an individual order item, including price and quantity.
class OrderItemListTile extends ConsumerWidget {
  const OrderItemListTile({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final productRepository = ref.watch(productRepositoryProvider);
    // final Product product = productRepository.getProduct(item.productId)!;

    // pass productId as an argument when watching the provider
    final productValue = ref.watch(productFutureProvider(item.productId));
    return AsyncValueWidget<Product?>(
      value: productValue,
      data: (product) {
        if (product != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomImage(imageUrl: product.imageUrl),
                ),
                gapW8,
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title),
                      gapH12,
                      Text(
                        'Quantity: ${item.quantity}'.hardcoded,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
