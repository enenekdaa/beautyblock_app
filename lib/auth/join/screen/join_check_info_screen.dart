
import 'package:beautyblock_app/auth/join/screen/join_app_description_screen.dart';
import 'package:beautyblock_app/widget/widget_category_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config.dart';
import '../../../utils.dart';
import '../../../widget/widget_radius_button.dart';
import '../../../widget/widget_text_input.dart';
import '../local_widget/join_check_info_scaffold.dart';

class JoinCheckInfoScreen extends StatelessWidget {
  const JoinCheckInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinCheckInfoScaffold(
        infoSection: _buildInfoContainer(),
        interestSection: _buildInterestContainer(),
        bottomButtonSection: _buildBottomButtonContainer()
    );
  }

  Widget _buildInfoContainer(){
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
        child: Column(
          children: [
            TextInputWidget(titleText: '이메일주소', hintText: '이메일 주소를 입력해주세요.', isVisible: false,initTextValue: "afhskjfshafhjkdjkfh@dfhkafhdkj",),
            SizedBox(height: Get.height * 0.03,),
            TextInputWidget(titleText: '회원명', hintText: '회원명을 입력해주세요.', isVisible: false,initTextValue: "blackShadow",),
            SizedBox(height: Get.height * 0.03,),
            TextInputWidget(titleText: '회사명', hintText: '회사명을 입력해주세요.', isVisible: false,initTextValue: "blackCompany",),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestContainer(){
    List<String> selectedInterestCategoryTextList = ["CELEB",'LOGISTIC','뷰티','스킨케어','마스크/팩'];
    List<Widget> selectedInterestCategoryButtonList = [];
    selectedInterestCategoryTextList.forEach((textValue){ selectedInterestCategoryButtonList.add(CategoryButtonWidget(text: textValue, index: 0, onPress: null, isSelected: true));} );
    List<String> selectedInterestCountryTextList = ["대한민국"];
    List<Widget> selectedInterestCountryButtonList = [];
    selectedInterestCountryTextList.forEach((value) {selectedInterestCountryButtonList.add(CategoryButtonWidget(text: value, index: 1, onPress: null, isSelected: true)); });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('나의 관심사',style: AppTheme.smallTitleTextStyle,),
            Wrap(
              spacing: 10,  //수평
              runSpacing: 3, //수직
              children: selectedInterestCategoryButtonList,
            ),
            SizedBox(height: Get.height * 0.02,),
            Text('관심국가',style: AppTheme.smallTitleTextStyle,),
            SizedBox(height: 6,),
            Wrap(
              spacing: 12,  //수평
              runSpacing: 3, //수직
              children: selectedInterestCountryButtonList,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonContainer() {
    return Row(
      children: [
        Expanded(child: RadiusButtonWidget(onPress: (){}, text: '수정하기', backgroundColor: Color.fromRGBO(165, 165, 165, 1))),
        SizedBox(width: 10,),
        Expanded(child: RadiusButtonWidget(onPress: (){Get.to(JoinAppDescriptionScreen());}, text: '저장', backgroundColor: GlobalBeautyColor.buttonHotPink)),
      ],
    );
  }
}
