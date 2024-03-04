import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearchScreenScaffold extends StatelessWidget {
  const HomeSearchScreenScaffold({
    Key? key,
    required this.AppbarSection,
    required this.bodySection,
  }) : super(key: key);

  final AppbarSection;
  final bodySection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarSection,
        body: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.02,right: 20,left: 20),
          child:Column(
            children: [
              Expanded(child:bodySection ),
            ],
          )

        ),
    );
  }
}