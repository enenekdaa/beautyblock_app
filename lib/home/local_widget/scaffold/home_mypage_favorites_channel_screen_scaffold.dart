import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMyPageFavoritesChannelScreenScaffold extends StatelessWidget {
  const HomeMyPageFavoritesChannelScreenScaffold({
    Key? key,
    required this.appbarSection,
    required this.channelSection,
    required this.bottomListviewSection,
  }) : super(key: key);

  final appbarSection;
  final channelSection;
  final bottomListviewSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarSection,
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
          color: Color.fromRGBO(246, 246, 246, 1),
          child: channelSection,
        ),
        Expanded(child:bottomListviewSection, )

      ]),
    );
  }
}
