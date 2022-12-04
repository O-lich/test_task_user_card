import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBoxDecoration {
  static BoxDecoration boxDecoration(BuildContext context, Color color) {
    return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
    );
  }}