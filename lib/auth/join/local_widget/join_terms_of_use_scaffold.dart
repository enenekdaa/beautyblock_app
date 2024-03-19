import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widget/widget_appbar.dart';

class JoinTermsOfUseScaffold extends StatelessWidget {
  const JoinTermsOfUseScaffold({
    Key? key,
    required this.middleContents,
    required this.joinButton,
    required this.inviteCodeForm,
  }) : super(key: key);

  final middleContents;
  final joinButton;
  final inviteCodeForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppbarWidget(appbarText: "Sign Up"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: middleContents,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 6.0, color: Color.fromRGBO(246, 246, 246, 1)),
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: inviteCodeForm,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: joinButton,
      ),
    );
  }
}
