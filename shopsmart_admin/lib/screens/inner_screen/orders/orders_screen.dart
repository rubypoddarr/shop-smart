import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/empty_bag.dart';
import '../../../providers/products_provider.dart';
import '../../../services/assets_manager.dart';
import '../../../widgets/title_text.dart';
import 'orders_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({Key? key}) : super(key: key);

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final allProducts = productsProvider.products;
    
    // Using the first few products to simulate "placed orders" as per user request
    final ordersToShow = allProducts.take(10).toList();

    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: 'Placed orders',
          ),
        ),
        body: ordersToShow.isEmpty
            ? EmptyBagWidget(
                imagePath: AssetsManager.order,
                title: "No orders has been placed yet",
                subtitle: "",
              )
            : ListView.separated(
                itemCount: ordersToShow.length,
                itemBuilder: (ctx, index) {
                  final product = ordersToShow[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(
                      name: product.productTitle,
                      price:"\$${product.productPrice}",
                      qty: product.productQuantity,
                      imageUrl: product.productImage,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
