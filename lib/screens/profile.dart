import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/navigation/app_router.dart';

import '../generated/locale_keys.g.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();
    AutoRouter.of(context).push(HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('K&M'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${LocaleKeys.your_email.tr()} ${user?.email}'),
            TextButton(
              onPressed: () => signOut(),
              child: Text(LocaleKeys.exit.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
