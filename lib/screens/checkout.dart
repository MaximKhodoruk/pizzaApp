import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/my_button.dart';
import '../domain/my_button2.dart';
import '../services/snack_bar.dart';

@RoutePage()
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _radioValue = 1;
  TextEditingController addressTextInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Your order',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Enter address: ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                autocorrect: false,
                controller: addressTextInputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Your address",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  Radio(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    fillColor: MaterialStateProperty.all<Color>(Colors.red),
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: (value) {
                      setState(() {
                        _radioValue = 1;
                      });
                    },
                  ),
                  const Text(
                    "Налиными курьеру",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Radio(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    fillColor: MaterialStateProperty.all<Color>(Colors.red),
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: (value) {
                      setState(() {
                        _radioValue = 2;
                      });
                    },
                  ),
                  const Text(
                    "Картой курьеру",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              MyButton(
                text: "Оформить",
                onTap: () {
                  AutoRouter.of(context).pop();
                  SnackBarService.showSnackBar(
                    context,
                    "Заказ успешно оформлен",
                    true,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
