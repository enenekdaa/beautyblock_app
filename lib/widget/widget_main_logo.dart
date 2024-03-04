import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';

class MainLogoWidget extends StatelessWidget {
  const MainLogoWidget
      ({
    Key? key,
    this.imageHeight,
    this.imageCrossAlignment,
    this.contentGap,
  }) :super(key: key);

  final imageHeight;
  final contentGap;
  final imageCrossAlignment;

  @override
  Widget build(BuildContext context) {
    print('===========main logo in');

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment:
        imageCrossAlignment,
        children: [
          Container(
            height: imageHeight,
            child: Image.asset(
              'assets/images/img_main_logo.png'
              , fit: BoxFit.cover,
            ),
          ),
          SizedBox(height:contentGap),
          Text('Beauty Block', style: AppTheme.mainLogoTextStyle.copyWith(height: 1.5),),
        ],
      ),
    );
  }
}
