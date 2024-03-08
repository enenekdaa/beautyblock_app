import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/widget/widget_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMainScreenScaffold extends StatelessWidget {
  const HomeMainScreenScaffold({
    Key? key,
    // required this.homeAppbarSection,
    required this.bodySection,
    required this.bottomNavigationSection,
    required this.modalBottomSheet,
    required this.drawer
  }) : super(key: key);

  // final homeAppbarSection;
  final bodySection;
  final bottomNavigationSection;
  final modalBottomSheet;
  final drawer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: homeAppbarSection,
      body: bodySection,
      bottomNavigationBar: bottomNavigationSection,
      drawer: drawer,
      bottomSheet: modalBottomSheet,
    );
  }
}
