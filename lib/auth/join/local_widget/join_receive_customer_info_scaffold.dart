import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget/widget_appbar.dart';

class JoinReceiveCustomerInfoScaffold extends StatelessWidget {
  const JoinReceiveCustomerInfoScaffold({
    Key? key,
    required this.receiveCustomerInfoInput,
    required this.joinButton,
  }) : super(key: key);

  final receiveCustomerInfoInput;
  final joinButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appbarText: "고객정보입력"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: receiveCustomerInfoInput,
        ),
      ),
      bottomNavigationBar: Padding(padding:EdgeInsets.symmetric(vertical: 20,horizontal: 20),child: joinButton,),
    );
  }
}