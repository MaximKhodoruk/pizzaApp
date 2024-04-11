import 'package:flutter/material.dart';

import 'food_model.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  const FoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 14)),
            Padding(
                padding: EdgeInsets.all(14),
                child: Image.network(food.imagePath, height: 100)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 2),
                Text('\$${food.price}', style: const TextStyle(fontSize: 14)),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
