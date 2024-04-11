import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/navigation/app_router.dart';
import '../generated/locale_keys.g.dart';
import '../services/snack_bar.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final navigator = AutoRouter.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys.incorrect_email_or_password_try_again.tr(),
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys.unknown_error_try_again_or_contact_support.tr(),
          true,
        );
        return;
      }
    }
    AutoRouter.of(context).push(HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.to_come_in.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? LocaleKeys.enter_correct_email.tr()
                        : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: LocaleKeys.enter_email.tr(),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                validator: (value) => value != null && value.length < 6
                    ? LocaleKeys.minimum_6_characters.tr()
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: LocaleKeys.enter_password.tr(),
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: login,
                child: Center(child: Text(LocaleKeys.to_come_in.tr())),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => AutoRouter.of(context).push(SignUpRoute()),
                child: Text(
                  LocaleKeys.registration.tr(),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    AutoRouter.of(context).push(ResetPasswordRoute()),
                child: Text(LocaleKeys.reset_the_password.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
