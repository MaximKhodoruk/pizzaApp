import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigation/app_router.dart';

class PizzaApp extends StatefulWidget {
  const PizzaApp({super.key});

  @override
  State<PizzaApp> createState() => _PizzaApp();
}

class _PizzaApp extends State<PizzaApp>{
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'PizzaApp',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 255, 255, 0.9),
        primarySwatch: Colors.red,
      ),
      routerConfig: _appRouter.config(
        navigatorObservers: ()=>[
          
        ]
      ),
    );
  }
}