import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../widget/widget_appbar.dart';

class JoinCertifyEmailScaffold extends StatelessWidget {
  const JoinCertifyEmailScaffold({
    Key? key,
    required this.imageContainer,
    required this.messageToInform,
    required this.joinButton,
    required this.receiveCertifyNumInput,
    required this.reSendButton,
  }) : super(key: key);

  final imageContainer;
  final messageToInform;
  final joinButton;
  final receiveCertifyNumInput;
  final reSendButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appbarText: "회원가입"),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    children: [
                      imageContainer,
                      messageToInform,
                      receiveCertifyNumInput,
                    ],
                  ),
                ),
              ),
                Positioned(
                    bottom: 0,
                    child: reSendButton),
              ]
            ),
          ),
          joinButton,
        ],
      ),
    );
  }
}
