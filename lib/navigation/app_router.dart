import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza_app/screens/history.dart';
import 'package:pizza_app/screens/main.dart';
import '../domain/food_details.dart';
import '../domain/food_model.dart';
import '../screens/cart.dart';
import '../screens/checkout.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/profile.dart';
import '../screens/reset_password.dart';
import '../screens/settings.dart';
import '../screens/sign_up.dart';
import '../screens/verify_email.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          path: '/',
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: SettingsRoute.page, path: 'settings'),
            AutoRoute(page: HistoryRoute.page, path: 'history'),
            AutoRoute(page: CartRoute.page, path: 'cart'),
          ],
        ),
        AutoRoute(page: ProfileRoute.page, path: '/profile'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: SignUpRoute.page, path: '/sighup'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/resetpassword'),
        AutoRoute(page: VerifyEmailRoute.page, path: '/verifyemail'),
        AutoRoute(page: FoodDetailsRoute.page, path: '/fooddetails'),
        AutoRoute(page: CheckoutRoute.page, path: '/checkout'),
      ];
}
