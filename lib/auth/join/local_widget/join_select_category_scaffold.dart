import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../widget/widget_appbar.dart';

class JoinSelectCategoryScaffold extends StatelessWidget {
  const JoinSelectCategoryScaffold({
    Key? key,
    required this.topTextSection,
    required this.interestTypeSection,
    required this.interestCategorySection,
    required this.interestCountrySection,
    required this.bottomButtomSection,
  }) : super(key: key);

  final topTextSection;
  final interestTypeSection;
  final interestCategorySection;
  final interestCountrySection;
  final bottomButtomSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appbarText: "부가정보선택"),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      topTextSection,
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: Color.fromRGBO(181, 181, 181, 0.7),
                      ),
                      interestTypeSection,
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: Color.fromRGBO(181, 181, 181, 0.7),
                      ),
                      interestCategorySection,
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: Color.fromRGBO(181, 181, 181, 0.7),
                      ),
                      interestCountrySection,
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: bottomButtomSection,
              ),
            ],
          )),
    );
  }
}
