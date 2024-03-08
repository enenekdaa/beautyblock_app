import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_post_upload_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_post_share_screen.dart';
import 'package:beautyblock_app/widget/widget_custom_dropdown.dart';
import 'package:beautyblock_app/widget/widget_overlapping_images.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils.dart';
import '../../widget/widget_appbar.dart';

class HomePostUploadScreen extends StatelessWidget {
  HomePostUploadScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return HomePostUploadScreenScaffold(
      appBarSection: _buildAppBar(),
      imageSection: _buildimageSection(),
      writePostSection: _buildWritePost(),
    );
  }

  Widget _buildAppBar() {
    return AppbarWidget(
      appbarText: "",
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            'Cancel',
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget _buildimageSection() {
    return OverlappingImagesWidget(image:Image.file(HomeController.to.fetchImage));
  }

  Widget _buildWritePost() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          SizedBox(height: Get.height * 0.03),
          Text('카테고리',style: AppTheme.smallTitleTextStyle.copyWith(fontSize: 13),),
          SizedBox(height: Get.height * 0.01),
          CustomDropDownWidget(
              itemList: _homeController.categories, dropdownKey: 'category'),
          SizedBox(height: Get.height * 0.03),
          TextInputWidget(titleText: '제목', hintText: '제목을 입력해 주세요.', isGuideTextVisible: false,controller:_homeController.uploadTitleController ,),
          SizedBox(height: Get.height * 0.03),
          Text('내용',style: AppTheme.smallTitleTextStyle,),
          SizedBox(height: Get.height * 0.01),
          Stack(
            children:[ TextField(
              maxLength: 2000,
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _homeController.uploadContentController,
              decoration: InputDecoration(
                hintText: '내용을 입력해 주세요.',
                hintStyle: AppTheme.tagTextStyle.copyWith(fontWeight: FontWeight.w400,fontSize: 14),
                filled: true,
                fillColor: Color.fromRGBO(171, 169, 163, 0.12),
                enabledBorder: OutlineInputBorder(
                    // 기본 모양
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),

            Positioned(bottom:-2 ,child: Text('글자 수 최대 2,000자까지 입력 가능합니다.',style: AppTheme.tagTextStyle,),)
            ]
          ),
          SizedBox(height: Get.height * 0.03),
          TextInputWidget(titleText: '태그', hintText: "태그", isGuideTextVisible: false,controller: _homeController.uploadTagController,),
          SizedBox(height: Get.height * 0.03),
          RadiusButtonWidget(
              onPress: () {Get.to(HomePostShareScreen());},
              text: '저장',
              backgroundColor: GlobalBeautyColor.buttonHotPink),
        ],
      ),
    );
  }
}
