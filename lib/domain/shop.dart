import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../generated/locale_keys.g.dart';
import 'food_model.dart';

class Shop extends ChangeNotifier {
  List<Food> _foodMenu = [
    Food(
      name: LocaleKeys.name_margarita.tr(),
      price: "10",
      imagePath: 'https://cdn-icons-png.flaticon.com/128/6635/6635089.png',
      composition: LocaleKeys.composition_margarita.tr(),
      comments: LocaleKeys.comments_margarita.tr(),
    ),
    Food(
      name: LocaleKeys.name_pepperoni.tr(),
      price: "15",
      imagePath: 'https://cdn-icons-png.flaticon.com/128/1699/1699822.png',
      composition: LocaleKeys.composition_pepperoni.tr(),
      comments: LocaleKeys.comments_pepperoni.tr(),
    ),
    Food(
      name: LocaleKeys.name_marine.tr(),
      price: "20",
      imagePath: 'https://cdn-icons-png.flaticon.com/128/2848/2848600.png',
      composition: LocaleKeys.composition_marine.tr(),
      comments: LocaleKeys.comments_marine.tr(),
    ),
    Food(
      name: LocaleKeys.name_ham_and_mushrooms.tr(),
      price: "15",
      imagePath: 'https://cdn-icons-png.flaticon.com/128/9633/9633377.png',
      composition: LocaleKeys.composition_ham_and_mushrooms.tr(),
      comments: LocaleKeys.comments_ham_and_mushrooms.tr(),
    )
  ];

  List<Food> _cart = [];
  List<Food> get foodMenu => _foodMenu;
  List<Food> get cart => _cart;

  void addToCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  String calculateTotal() {
    int total = 0;
    for (int i = 0; i < _cart.length; i++) {
      total += int.parse(_cart[i].price);
    }
    return total.toString();
  }
}
