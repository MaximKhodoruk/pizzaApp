import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';
import '../navigation/app_router.dart';
import '../services/snack_bar.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = AutoRouter.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        LocaleKeys.passwords_must_match.tr(),
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys
              .this_Email_is_already_in_use_try_again_using_a_different_email
              .tr(),
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys.unknown_error_try_again_or_contact_support.tr(),
          true,
        );
      }
    }

    AutoRouter.of(context).push(HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.register.tr()),
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
                  border: const OutlineInputBorder(),
                  hintText: LocaleKeys.enter_email.tr(),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? LocaleKeys.minimum_6_characters.tr()
                    : null,
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
              TextFormField(
                autocorrect: false,
                controller: passwordTextRepeatInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? LocaleKeys.minimum_6_characters.tr()
                    : null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: LocaleKeys.enter_your_password_again.tr(),
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
                onPressed: signUp,
                child: Center(child: Text(LocaleKeys.registration.tr())),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => AutoRouter.of(context).pop(),
                child: Text(
                  LocaleKeys.to_come_in.tr(),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
