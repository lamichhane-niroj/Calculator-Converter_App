import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key, required this.sign, required this.onPressed});

  final String sign;
  final void Function() onPressed;

  final List<String> blackBoxes = ['C', '%', 'DEL', '÷', 'x', '-', '+', '='];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: blackBoxes.contains(sign) ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                const BoxShadow(
                  offset: Offset(-3, -3),
                  color: Colors.white,
                  spreadRadius: 3,
                  blurRadius: 3,
                ),
                BoxShadow(
                    offset: const Offset(3, 3),
                    color: Colors.grey.shade300,
                    spreadRadius: 3,
                    blurRadius: 3)
              ]),
          child: Center(
            child: Text(
              sign,
              style: TextStyle(
                color: blackBoxes.contains(sign) ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
