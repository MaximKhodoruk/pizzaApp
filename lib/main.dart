import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pizza_app/domain/shop.dart';
import 'package:pizza_app/domain/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const PizzaApp(),
    ),
  );
}

class PizzaApp extends StatefulWidget {
  const PizzaApp({super.key});

  @override
  State<PizzaApp> createState() => _PizzaApp();
}

class _PizzaApp extends State<PizzaApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Shop(),
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          child: Builder(
            builder: (context) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'PizzaApp',
                theme: Provider.of<ThemeProvider>(context).themeData,
                routerConfig: _appRouter.config(),
              );
            },
          ),
        ));
  }
}
