import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/widget/widget_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMainScreenScaffold extends StatelessWidget {
  const HomeMainScreenScaffold(
      {Key? key,
      // required this.homeAppbarSection,
      required this.bodySection,
      required this.bottomNavigationSection,
      required this.drawer})
      : super(key: key);

  // final homeAppbarSection;
  final bodySection;
  final bottomNavigationSection;
  final drawer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: BottomNavBarController.to.scaffoldKey,
      // appBar: homeAppbarSection,
      body: bodySection,
      bottomNavigationBar: bottomNavigationSection,
      drawer: drawer,
    );
  }
}
