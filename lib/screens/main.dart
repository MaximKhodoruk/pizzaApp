import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';
import '../navigation/app_router.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeRoute(),
        const SettingsRoute(),
        const HistoryRoute(),
        const CartRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final user = FirebaseAuth.instance.currentUser;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: const Text('K&M'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                if (user == null) {
                  AutoRouter.of(context).push((const LoginRoute()));
                } else {
                  AutoRouter.of(context).push(const ProfileRoute());
                }
              },
              icon: const Icon(
                Icons.person,
              ),
            ),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: LocaleKeys.menu.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: LocaleKeys.settings.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: LocaleKeys.history.tr()),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: LocaleKeys.cart.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
