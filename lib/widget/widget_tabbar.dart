import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget(
      {
        Key? key,
        required this.controller,
        required this.tabs,
      }):super(key: key);

  final controller;
  final tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      labelPadding: EdgeInsets.zero,
      controller: controller,
      dividerColor: Color.fromRGBO(239, 239, 239, 1),
      indicator: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2,
                  color: GlobalBeautyColor.buttonHotPink
              )
          )
      ),
      unselectedLabelColor: Color.fromRGBO(175, 175, 175, 1),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w700, fontFamily: 'NotoSans', fontSize: 15),
      labelColor: GlobalBeautyColor.buttonHotPink,
      tabs: tabs,
    );
  }
}
