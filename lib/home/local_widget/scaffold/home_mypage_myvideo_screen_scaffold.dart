import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMyPageMyVideoScreenScaffold extends StatelessWidget {
  const HomeMyPageMyVideoScreenScaffold({
    Key? key,
    required this.appbarSection,
    required this.tabBarSection,
    required this.bottomListviewSection,
  }) : super(key: key);

  final appbarSection;
  final tabBarSection;
  final bottomListviewSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarSection,
      body: Column(children: [
        tabBarSection,
        Expanded(child:bottomListviewSection, )
      ]),
    );
  }
}
