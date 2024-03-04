import 'package:flutter/material.dart';

class TabChannelScreenScaffold extends StatelessWidget {
  const TabChannelScreenScaffold(
      {
        Key? key,
        required this.appbarSection,
        required this.listviewSection
      }):super(key: key);

  final appbarSection;
  final listviewSection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarSection,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            listviewSection
          ],
        ),
      ),
    );
  }

}
