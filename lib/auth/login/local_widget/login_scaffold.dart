import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({
    Key?key,
    required this.mainLogoWidget,
    required this.middleContent,
    required this.loginButton,
    required this.bottomNavigationBar
  }) : super(key:key);

  final Widget mainLogoWidget;
  final Widget middleContent;
  final Widget loginButton;
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainLogoWidget,
                    middleContent,
                    loginButton,
                  ],
                ),
              ),
              bottomNavigationBar
            ],
          ),
        ),
    );
  }
}
