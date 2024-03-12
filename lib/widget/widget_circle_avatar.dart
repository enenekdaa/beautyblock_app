import 'package:beautyblock_app/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    Key? key,
    required this.backgroundimage,
    this.text = "",
    this.bottomTextIsVisible = false,
    this.selected = false,
  }) : super(key: key);

  final backgroundimage;
  final text;
  final bottomTextIsVisible;
  final selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: Get.height * 0.04,
            backgroundImage: backgroundimage ??
                Image.asset('assets/images/img_main_logo.png'),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Visibility(
            visible: bottomTextIsVisible,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  fontFamily: 'NotoSans',
                  color: selected
                      ? GlobalBeautyColor.buttonHotPink
                      : const Color.fromRGBO(170, 178, 183, 1)),
            ),
          )
        ],
      ),
    );
  }
}
