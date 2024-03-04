import 'package:flutter/material.dart';

class HomePostShareScreenScaffold extends StatelessWidget {
  const HomePostShareScreenScaffold({
    Key? key,
    required this.appBarSection,
    required this.imageSection,
    required this.saveTextSection,
    required this.shareButtonSection,
  }) : super(key: key);

  final appBarSection;
  final saveTextSection;
  final imageSection;
  final shareButtonSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarSection,
      body: Column(
        children: [
          imageSection,
          Expanded(child: saveTextSection,),
          shareButtonSection,
        ],
      ),
    );
  }
}