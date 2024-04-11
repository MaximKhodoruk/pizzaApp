import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton2({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 100,
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
