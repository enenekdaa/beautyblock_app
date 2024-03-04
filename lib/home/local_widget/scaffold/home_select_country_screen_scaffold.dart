import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widget/widget_appbar.dart';

class HomeSelectCountryScreenScaffold extends StatelessWidget {
  const HomeSelectCountryScreenScaffold({
    Key? key,
    required this.appBarSection,
    required this.selectCountrySection,
    required this.bottomButtonSection,
  }) : super(key: key);
  final appBarSection;
  final selectCountrySection;
  final bottomButtonSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: selectCountrySection,
            ),
            Padding(padding:EdgeInsets.symmetric(vertical: 20,),child: bottomButtonSection,)
          ],
        ),
      ),
    );
  }
}