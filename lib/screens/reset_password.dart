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
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();

    super.dispose();
  }

  Future<void> resetPassword() async {
    final navigator = AutoRouter.of(context);
    final scaffoldMassager = ScaffoldMessenger.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailTextInputController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found') {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys.this_email_is_not_registered.tr(),
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

    var snackBar = SnackBar(
      content: Text(LocaleKeys
          .resetting_your_password_is_now_complete_check_your_email
          .tr()),
      backgroundColor: Colors.green,
    );

    scaffoldMassager.showSnackBar(snackBar);

    AutoRouter.of(context).push(HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.password_reset.tr()),
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
              ElevatedButton(
                onPressed: resetPassword,
                child: Center(child: Text(LocaleKeys.reset_the_password.tr())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
