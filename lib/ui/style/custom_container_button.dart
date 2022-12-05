import 'package:flutter/material.dart';
import 'custom_box_decoration.dart';

class CustomContainer {
  static GestureDetector customBottomContainerButton(
      {required BuildContext context,
      required String image,
      void Function()? onTap,
      required Color color,
      required double borderWidth,
      required double width,
      required double height

      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: CustomBoxDecoration.boxDecoration(context, color, borderWidth),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset(
            image,
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
