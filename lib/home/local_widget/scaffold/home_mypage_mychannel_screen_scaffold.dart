import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMyPageMyChannelScreenScaffold extends StatelessWidget {
  const HomeMyPageMyChannelScreenScaffold({
    Key? key,
    required this.appbarSection,
    required this.channelProfileSection,
    required this.bottomListviewSection,
  }) : super(key: key);

  final appbarSection;
  final channelProfileSection;
  final bottomListviewSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarSection,
      body: Column(children: [
        channelProfileSection,
        Expanded(child:bottomListviewSection, )
      ]),
    );
  }
}
