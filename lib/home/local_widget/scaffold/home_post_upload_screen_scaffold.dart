import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePostUploadScreenScaffold extends StatelessWidget {
  const HomePostUploadScreenScaffold({
    Key? key,
    required this.appBarSection,
    required this.imageSection,
    required this.writePostSection,
    required this.circularProgressIndicator
  }) : super(key: key);

  final appBarSection;
  final imageSection;
  final writePostSection;
  final circularProgressIndicator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection,
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Column(
            children: [
              imageSection,
              writePostSection,
            ],
          ),
            Positioned(top:0,bottom:0,right:0,left:0,child:circularProgressIndicator ),
          ]
        ),
      ),
    );
  }
}
