import 'dart:io';

import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_post_share_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_overlapping_images.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class HomePostShareScreen extends StatelessWidget {
  const HomePostShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePostShareScreenScaffold(
        appBarSection: _buildAppbar(),
        imageSection: _buildImage(),
        saveTextSection: _buildSaveText(),
        shareButtonSection: _buildShareButtons());
  }

  Widget _buildAppbar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset('assets/images/ic_white_back_arrow.svg',),
        onPressed: (){Get.offAll(HomeMainScreen());},
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildImage() {
    final pickerImagePath = HomeController.to.pickerThumbnailVideoPath.value;

    return OverlappingImagesWidget(
        image:pickerImagePath.isNotEmpty
            ? FileImage(File(pickerImagePath))
            : AssetImage('assets/images/img_main_logo.png'));
  }

  Widget _buildSaveText() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/ic_ok_circle.svg'),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              '저장완료!',
              style: AppTheme.whiteTextStyle.copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButtons() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  thickness: 1,
                ),
                Positioned(
                    top: -6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.black,
                      child: Text(
                        'SHARE',
                        style: AppTheme.whiteTextStyle
                            .copyWith(fontSize: 16, backgroundColor: Colors.black,),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: Get.height * 0.1),
            child: RadiusButtonWidget(onPress: (){Share.shareFiles([HomeController.to.pickerThumbnailVideoPath.value]);}, text: "공유하기", backgroundColor: GlobalBeautyColor.buttonHotPink),
          )
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: Get.height * 0.04),
          //   child: Wrap(
          //     spacing: Get.width * 0.03,
          //     runSpacing: Get.height * 0.02,
          //     children: [
          //
          //       Column(
          //         children: [
          //           Image.asset('assets/images/ic_instagram.png'),
          //           Text('Instagram',style: AppTheme.whiteTextStyle.copyWith(fontWeight: FontWeight.w500),)
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Image.asset('assets/images/ic_facebook.png'),
          //           Text('Facebook',style: AppTheme.whiteTextStyle.copyWith(fontWeight: FontWeight.w500))
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Image.asset('assets/images/ic_facebook.png'),
          //           Text('Facebook',style: AppTheme.whiteTextStyle.copyWith(fontWeight: FontWeight.w500))
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Image.asset('assets/images/ic_facebook.png'),
          //           Text('Facebook',style: AppTheme.whiteTextStyle.copyWith(fontWeight: FontWeight.w500))
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Image.asset('assets/images/ic_facebook.png'),
          //           Text('Facebook',style: AppTheme.whiteTextStyle.copyWith(fontWeight: FontWeight.w500))
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Image.asset('assets/images/ic_facebook.png'),
          //           Text('Facebook',style: AppTheme.whiteTextStyle.copyWith(fontWeight: FontWeight.w500))
          //         ],
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
