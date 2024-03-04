import 'package:flutter/material.dart';

class HomeChannelDetailScreenScaffold extends StatelessWidget {
  const HomeChannelDetailScreenScaffold({
    Key? key,
    required this.AppbarSection,
    required this.profileSection,
    required this.tabBarSection,
    required this.tabPageSection,
  }) : super(key: key);

  final AppbarSection;
  final profileSection;
  final tabBarSection;
  final tabPageSection;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppbarSection,
      body: Column(
        children: [
          profileSection,
          tabBarSection,
          Expanded(child: tabPageSection)
        ],
      ),
    );
  }
}