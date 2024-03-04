import 'package:flutter/material.dart';

class HomeAlarmScreenScaffold extends StatelessWidget {
  const HomeAlarmScreenScaffold(
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
      body: Column(
        children: [
          listviewSection,
        ],
      ),
    );
  }

}