// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class TopButton extends StatelessWidget {
  TopButton(
      {super.key,
      required this.text,
      this.isSelected = false,
      required this.onClick});

  final String text;
  final void Function() onClick;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-3, -3),
                  color: Colors.white,
                  spreadRadius: 2,
                  blurRadius: 2,
                  inset: isSelected),
              BoxShadow(
                offset: const Offset(3, 3),
                color: Colors.grey.shade400,
                spreadRadius: 2,
                blurRadius: 2,
                inset: isSelected,
              )
            ]),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
