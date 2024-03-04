import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePostUploadScreenScaffold extends StatelessWidget {
  const HomePostUploadScreenScaffold({
    Key? key,
    required this.appBarSection,
    required this.imageSection,
    required this.writePostSection,
  }) : super(key: key);

  final appBarSection;
  final imageSection;
  final writePostSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection,
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageSection,
            writePostSection,
          ],
        ),
      ),
    );
  }
}
