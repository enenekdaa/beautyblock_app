import 'package:beautyblock_app/auth/join/local_widget/join_select_category_scaffold.dart';
import 'package:beautyblock_app/auth/join/screen/join_check_info_screen.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_category_button.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinSelectCategoryScreen extends StatelessWidget {
  const JoinSelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinSelectCategoryScaffold(
      topTextSection: _buildTopText(),
      interestTypeSection: _buildInterestTypeContainer(),
      interestCategorySection: _buildInterestCategoryContainer(),
      interestCountrySection: _buildInterestCountryContainer(),
      bottomButtomSection: _buildBottomButtonContainer(),
    );
  }

  Widget _buildTopText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 관심 유형과 카테고리를\n선택해주세요.',
              softWrap: true,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w900,
                height: 1.45,
                color: Color.fromRGBO(18, 17, 22, 1),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              '선택한 항목에 따라 다양한 컨텐츠를 즐기실 수 있습니다.',
              softWrap: true,
              style: AppTheme.smallTitleTextStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestTypeContainer() {
    List<String> interestTypeList = [
      "BUYER",
      "CELEB",
      "MKT",
      "PR",
      "OEM",
      "ODM",
      "LOGISTIC",
      "INFLUENCER",
      "OTHERS"
    ];
    List<Widget> textWidgetList = [];
    interestTypeList.forEach((textValue) {
      textWidgetList.add(CategoryButtonWidget(
        text: textValue,
        onPress: () {},
        index: 0,
        isSelected: false,
      ));
    });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height *0.01),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '관심유형',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                SizedBox(width: 5,),
                Text(
                  '최대 2개까지 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                      color: Color.fromRGBO(196, 196, 196, 1)),
                )
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Wrap(
              spacing: 12,
              runSpacing: 3, //수직
              children: textWidgetList,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCategoryContainer() {
    print('========build category in');
    List<String> interestCategoryList = ['뷰티','색조','스킨케어','마스크/팩','선케어','클렌징/필링','베이스'];
    List<Widget> categoryWidgetList = [];

    interestCategoryList.forEach((textValue) {
      categoryWidgetList.add(CategoryButtonWidget(
        text: textValue,
        onPress: () {},
        index: 0,             //카테고리 버튼 index
        isSelected: false,    //카테고리 버튼 toggle event
      ));
    });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '관심 카테고리',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                SizedBox(width: 5,),
                Text(
                  '최대 3개까지 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                      color: Color.fromRGBO(196, 196, 196, 1)),
                )
              ],
            ),
            SizedBox(height: Get.height*0.015,),
            Wrap(
              spacing: 12,  //수평
              runSpacing: 3, //수직
              children: categoryWidgetList,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCountryContainer() {
    List<String> interestCountryList = ['대한민국'];
    List<Widget> countryWidgetList = [];

    interestCountryList.forEach((textValue) {
      countryWidgetList.add(CategoryButtonWidget(
        text: textValue,
        onPress: () {},
        index: 0,             //카테고리 버튼 index
        isSelected: false,    //카테고리 버튼 toggle event
      ));
    });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '관심 국가',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                SizedBox(width: 5,),
              ],
            ),
            SizedBox(height: Get.height*0.015,),
            Wrap(
              spacing: 12,  //수평
              runSpacing: 3, //수직
              children: countryWidgetList,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonContainer() {
    return Row(
      children: [
        Expanded(child: RadiusButtonWidget(onPress: (){}, text: '나중에 선택', backgroundColor: Color.fromRGBO(165, 165, 165, 1))),
        SizedBox(width: 10,),
        Expanded(child: RadiusButtonWidget(onPress: (){Get.to(JoinCheckInfoScreen());}, text: '저장', backgroundColor: GlobalBeautyColor.buttonHotPink)),
      ],
    );
  }
}
