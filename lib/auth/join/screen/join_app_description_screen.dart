import 'package:beautyblock_app/auth/join/local_widget/join_app_description_Scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widget/widget_radius_button.dart';

class JoinAppDescriptionScreen extends StatelessWidget {
  const JoinAppDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinAppDescriptionScaffold(
      decriptionTitle: _buildTitleSection(),
      imageView: _buildImageSection(),
      appDecription: _buildAppDecription(),
      bottomButtonSection: _buildBottomButton(),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          '뷰티, 한곳에서 빠르고 싶게',
          style: AppTheme.smallTitleTextStyle.copyWith(fontSize: 15),
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          '뷰티의 모든 것, 뷰티블록 App',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontFamily: 'NotoSans',
              height: 1.45),
        )
      ],
    );
  }

  Widget _buildImageSection() {
    return Image.asset('assets/images/img_page_description.png');
  }

  Widget _buildAppDecription() {
    return Column(
      children: [
        Text(
          '뷰티산업 모든 필수 서비스가 한곳에',
          style:
              AppTheme.smallTitleTextStyle.copyWith(fontSize: 16, height: 1.4),
        ),
        SizedBox(height: Get.height * 0.01,),
        Text(
          '브랜드, 바이어, 마케팅, 상품의 제작생산, 유통 그리고 셀렙,\n인플루언서, 유튜브 등 뷰티산업의 모든 서비스가\n한 화면에서 손쉽게 제공됩니다.',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w500,
              height: 1.45,
              color: Color.fromRGBO(91, 89, 84, 1)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildBottomButton() {
    return RadiusButtonWidget(
      text: "NEXT",
      onPress: () {Get.to(HomeMainScreen());},
      backgroundColor: GlobalBeautyColor.buttonHotPink,
    );
  }
}
