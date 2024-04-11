import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/domain/my_button2.dart';
import 'package:provider/provider.dart';

import '../domain/shop.dart';
import '../domain/theme_provider.dart';
import '../generated/locale_keys.g.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
          child: Column(
        children: [
          MyButton2(
            text: LocaleKeys.change_the_topic.tr(),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          SizedBox(height: 20),
          MyButton2(
            text: LocaleKeys.change_language.tr(),
            onTap: () {
              if (context.locale == Locale('ru'))
                context.setLocale(Locale('en'));
              else
                context.setLocale(Locale('ru'));
            },
          ),
        ],
      )),
    );
  }
}
