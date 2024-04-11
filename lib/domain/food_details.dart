import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/domain/my_button.dart';
import 'package:pizza_app/domain/shop.dart';
import 'package:provider/provider.dart';

import '../generated/locale_keys.g.dart';
import 'food_model.dart';

@RoutePage()
class FoodDetailsScreen extends StatefulWidget {
  final Food food;
  const FoodDetailsScreen({super.key, required this.food});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantityCount = 0;

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void addToCart() {
    if (quantityCount > 0) {
      final shop = context.read<Shop>();
      shop.addToCart(widget.food, quantityCount);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.red,
          content: Text(
            LocaleKeys.successfully_added_to_cart.tr(),
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  Image.network(widget.food.imagePath, height: 200),
                  const SizedBox(height: 12),
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        widget.food.composition,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.food.comments,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.red,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${widget.food.price}',
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black12,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: decrementQuantity,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black12,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: incrementQuantity,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),
                MyButton(text: LocaleKeys.add_to_cart.tr(), onTap: addToCart),
              ],
            ),
          )
        ],
      ),
    );
  }
}
