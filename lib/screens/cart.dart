import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/domain/my_button.dart';
import 'package:pizza_app/navigation/app_router.dart';
import 'package:provider/provider.dart';

import '../domain/food_model.dart';
import '../domain/shop.dart';
import '../generated/locale_keys.g.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removerFromCart(Food food, BuildContext context) {
    final shop = context.read<Shop>();
    shop.removeFromCart(food);
  }

  void clearCart() {
    final shop = context.read<Shop>();
    shop.clearCart();
  }

  String calculateTotal() {
    final shop = context.read<Shop>();
    return shop.calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, value, index) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: value.cart.length,
              itemBuilder: (context, index) {
                final Food food = value.cart[index];

                final String foodName = food.name;

                final String foodPrice = food.price;

                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: ListTile(
                    title: Text(
                      foodName,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      '\$${food.price}',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removerFromCart(food, context),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: MyButton(
              text: "\$${calculateTotal()} ${LocaleKeys.pay_now.tr()}",
              onTap: () {
                AutoRouter.of(context).push((const CheckoutRoute()));
                clearCart();
              },
            ),
          )
        ],
      ),
    );
  }
}
