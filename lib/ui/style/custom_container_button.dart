import 'package:flutter/material.dart';
import 'custom_box_decoration.dart';

class CustomContainer {
  static GestureDetector customBottomContainerButton(BuildContext context,
      String image, void Function()? onTap, Color color, double width) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: CustomBoxDecoration.boxDecoration(context, color, width),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset(
            image,
            scale: 3,
          ),
        ),
      ),
    );
  }

  static GestureDetector customRightContainerButton(
    String image,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Image.asset(
            image,
            scale: 3,
          ),
        ),
      ),
    );
  }
}
