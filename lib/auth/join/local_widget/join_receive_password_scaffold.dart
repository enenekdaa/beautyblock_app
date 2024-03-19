import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widget/widget_appbar.dart';

class JoinReceivePasswordScaffold extends StatelessWidget {
  const JoinReceivePasswordScaffold({
    Key? key,
    required this.receivePasswordInput,
    required this.joinButton,
  }) : super(key: key);

  final receivePasswordInput;
  final joinButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appbarText: "Sign Up"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: receivePasswordInput,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: joinButton,
      ),
    );
  }
}
