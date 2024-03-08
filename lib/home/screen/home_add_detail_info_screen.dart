import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/list_item/home_add_detail_info_list_item.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_add_detail_info_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_almost_done_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../config.dart';
import '../../widget/widget_radius_button.dart';

class HomeAddDetailInfoScreen extends StatelessWidget {
  HomeAddDetailInfoScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return HomeAddDetailInfoScaffold(
      homeAppbarSection: _buildAppbar(),
      selectViedoSection: _buildSelectedVideoThumbnailAndDescription(),
      selectInfoSection: _buildSelectInfoList(),
      bottomButtonSection: _buildBottomButton(),
    );
  }

  Widget _buildAppbar() {
    return AppbarWidget(
      appbarText: '세부정보 추가',
      actions: [
        SvgPicture.asset('assets/images/ic_bell.svg'),
        SvgPicture.asset('assets/images/ic_search.svg')
      ],
    );
  }

  Widget _buildSelectedVideoThumbnailAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.11,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(HomeController.to.fetchImage),
          ),
        ),
        SizedBox(height: Get.height * 0.02,),
        TextField(
            maxLines: null,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: '동영상 설명을 추가해주세요.',
              hintStyle: AppTheme.tagTextStyle,
              filled: true,
              fillColor: Color.fromRGBO(171, 169, 163, 0.12),
              enabledBorder: OutlineInputBorder(
                // 기본 모양
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ))
      ],
    );
  }

  Widget _buildSelectInfoList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      children: [
        HomeAddDetailInfoItem(text: 'userName'),
        Obx(() =>
            HomeAddDetailInfoItem(
              text: '공개상태:${_homeController.getSwitchValue('isPostOpen')
                  ? '공개'
                  : '비공개'}', useSwitch: true, switchKey: 'isPostOpen',)),
        HomeAddDetailInfoItem(text: '위치'),
        Column(
          children: [
            HomeAddDetailInfoItem(text: '공개대상 선택'),
            SizedBox(height: Get.height * 0.01,),
            Text(
              '모든 크리에이터는 위치에 상관없이 이동 온라인 개인정보 보호법COPPA 및 기타 법률을 준수해야 할 법적인 의무가 있습니다.아동용 동영상인지 여부는 크리에이터가 지정해야 합니다.',
              softWrap: true,style: AppTheme.tagTextStyle.copyWith(height: 1.20),),
          ],
        ),

        HomeAddDetailInfoItem(
          text: '댓글 사용', useSwitch: true, switchKey: 'isUseReview',)
      ],

    );
  }

  Widget _buildBottomButton() {
    return RadiusButtonWidget(
        onPress: () {Get.offAll(HomeAlmostDoneScreen());},
        text: '동영상 업로드',
        backgroundColor: GlobalBeautyColor.buttonHotPink);
  }
}
