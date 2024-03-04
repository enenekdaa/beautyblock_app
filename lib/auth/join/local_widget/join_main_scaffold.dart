import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:flutter/material.dart';

class JoinMainScreenScaffold extends StatelessWidget {
  const JoinMainScreenScaffold({
    Key? key,
    required this.mainLogoWidget,
    required this.middleContent,
    required this.joinButton,
  }):super(key: key);

  final mainLogoWidget;
  final middleContent;
  final joinButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child:
              Column(
                children: [
                  mainLogoWidget,
                  middleContent,
                  joinButton,
                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
}
