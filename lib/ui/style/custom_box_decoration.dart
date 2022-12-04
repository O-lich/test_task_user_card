import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBoxDecoration {
  static BoxDecoration boxDecoration(BuildContext context, Color color, double width) {
    return BoxDecoration(
      border: Border.all(color: color, width: width),
      borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
    );
  }}