import 'package:auto_route/auto_route.dart';
import 'package:pizza_app/domain/food_details.dart';
import 'package:provider/provider.dart';
import '../domain/shop.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/domain/food_tile.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToFoodDetails(int index) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsScreen(food: foodMenu[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;
    return ListView.builder(
      itemCount: foodMenu.length,
      itemBuilder: (context, index) => FoodTile(
        food: foodMenu[index],
        onTap: () => navigateToFoodDetails(index),
      ),
    );
  }
}
