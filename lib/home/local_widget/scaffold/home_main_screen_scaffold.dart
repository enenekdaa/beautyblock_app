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
    required this.modalBottomSheet
  }) : super(key: key);

  // final homeAppbarSection;
  final bodySection;
  final bottomNavigationSection;
  final modalBottomSheet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: homeAppbarSection,
      body: bodySection,
      bottomNavigationBar: bottomNavigationSection,
      drawer: DrawerWidget(),
      bottomSheet: modalBottomSheet,
    );
  }
}
