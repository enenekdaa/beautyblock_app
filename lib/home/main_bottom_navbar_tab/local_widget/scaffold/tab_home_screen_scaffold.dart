import 'package:beautyblock_app/widget/widget_drawer.dart';
import 'package:flutter/material.dart';

class TabHomeScaffold extends StatelessWidget {
  const TabHomeScaffold({
    Key? key,
    required this.homeAppbarSection,
    required this.tabBarSection,
    required this.influencerListSection,
    required this.channelProfileSection,
    required this.bottomListviewSection,
  }) : super(key: key);

  final homeAppbarSection;
  final tabBarSection;
  final influencerListSection;
  final channelProfileSection;
  final bottomListviewSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppbarSection,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children:[
            tabBarSection,
            influencerListSection,
            channelProfileSection,
            bottomListviewSection,
          ]
        ),
      ),
    );
  }
}
