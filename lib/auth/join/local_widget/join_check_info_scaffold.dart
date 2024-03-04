import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../widget/widget_appbar.dart';

class JoinCheckInfoScaffold extends StatelessWidget {
  const JoinCheckInfoScaffold({
    Key? key,
    required this.infoSection,
    required this.interestSection,
    required this.bottomButtonSection,
  }) : super(key: key);

  final infoSection;
  final interestSection;
  final bottomButtonSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appbarText: "가입정보선택"),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoSection,
                      interestSection,
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: bottomButtonSection
              )
          ]
          )),
    );
  }
}