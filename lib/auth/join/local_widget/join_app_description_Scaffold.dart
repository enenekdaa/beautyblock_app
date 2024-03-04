import 'package:flutter/material.dart';

class JoinAppDescriptionScaffold extends StatelessWidget {
  const JoinAppDescriptionScaffold({
    Key? key,
    required this.decriptionTitle,
    required this.imageView,
    required this.appDecription,
    required this.bottomButtonSection,
  }) : super(key: key);

  final decriptionTitle;
  final imageView;
  final appDecription;
  final bottomButtonSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        decriptionTitle,
                        imageView,
                        appDecription,
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