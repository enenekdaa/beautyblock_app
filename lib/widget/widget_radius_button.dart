import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/main_init_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadiusButtonWidget extends StatelessWidget {
  const RadiusButtonWidget(
      {Key? key,
      required this.onPress,
      required this.text,
      required this.backgroundColor});

  // final onPress;
  final text;
  final backgroundColor;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.07,
      child: OutlinedButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              height: 1.75,
              fontFamily: 'NotoSans'),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
