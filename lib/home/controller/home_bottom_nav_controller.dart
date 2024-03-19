import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/main_bottom_navbar_tab/screen/tab_category_screen.dart';
import 'package:beautyblock_app/home/main_bottom_navbar_tab/screen/tab_fan_screen.dart';
import 'package:beautyblock_app/home/screen/home_camera_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../utils.dart';
import '../main_bottom_navbar_tab/screen/tab_channel_screen.dart';
import '../../fan/screen/home_select_country_screen.dart';
import '../main_bottom_navbar_tab/screen/tab_home_screen.dart';
import '../screen/home_add_detail_info_screen.dart';
import '../screen/home_post_upload_screen.dart';
import 'home_controller.dart';

class BottomNavBarController extends GetxController {
  static BottomNavBarController get to => Get.find();
  var bottomItems = <BottomNavigationBarItem>[].obs;
  var pages = [].obs;
  var bottomNavCurrentIndex = 0.obs;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    super.onInit();
    setBottomItems();
    pages.value = [
      TabHomeScreen(),
      TabCategoryScreen(),
      Text('tab3'),
      HomeSelectCountryScreen(),
      HomeMyPageScreen()
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bottomItems.value = [];
    pages.value = [];
  }

  void onItemTapped(int index) {
    if (HomeController.to.isShowSubscriptionChannel) {
      HomeController.to.toggleShowSubscriptionChannel();
    }
    if (index == 1) {
      //Drawer 열고 카테고리 진행
      if (bottomNavCurrentIndex.value != 1) {
        //이미 보고있을 때는 그대로 있기만 함
        HomeController.to.openDrawer();
      }
    } else if (index == 2) {
      showModal(Get.context);
    } else {
      bottomNavCurrentIndex.value = index;
    }
  }

  void setBottomItems() {
    bottomItems.value = [
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/images/ic_home.svg',
          color: GlobalBeautyColor.buttonHotPink,
          matchTextDirection: true,
        ),
        icon: SvgPicture.asset('assets/images/ic_home.svg'),
        label: 'HOME',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/images/ic_channel.svg',
          color: GlobalBeautyColor.buttonHotPink,
          matchTextDirection: true,
        ),
        icon: SvgPicture.asset('assets/images/ic_channel.svg'),
        label: 'CATEGORY',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/images/ic_camera.svg',
          color: GlobalBeautyColor.buttonHotPink,
          matchTextDirection: true,
        ),
        icon: SvgPicture.asset('assets/images/ic_camera.svg'),
        label: 'CAMERA',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/images/ic_fan.svg',
          color: GlobalBeautyColor.buttonHotPink,
          matchTextDirection: true,
        ),
        icon: SvgPicture.asset('assets/images/ic_fan.svg'),
        label: 'FAN',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/images/ic_profile.svg',
          color: GlobalBeautyColor.buttonHotPink,
          matchTextDirection: true,
        ),
        icon: SvgPicture.asset('assets/images/ic_profile.svg'),
        label: 'MYPAGE',
      ),
    ];
  }

  showModal(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: Get.height * 0.35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  child: Center(
                    child: Container(
                      width: Get.width * 0.2,
                      height: 4,
                      color: GlobalBeautyColor.tagGray170,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Create a PLAY video',
                    style: AppTheme.smallTitleTextStyle
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      Get.to(HomeCameraScreen());
                    },
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color.fromRGBO(230, 230, 230, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.01, left: 20),
                  child: GestureDetector(
                    child: Text('Upload Video'),
                    onTap: () {
                      // _pickImageFromGallery();
                      _pickVideoFromGallery();
                    },
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color.fromRGBO(230, 230, 230, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    child: const Text('Streaming'),
                    onTap: () {},
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color.fromRGBO(230, 230, 230, 1),
                )
              ],
            ));
      },
    );
  }

  // Future<void> _pickImageFromGallery() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if(image != null){
  //     HomeController.to.pickerImagePath.value = image.path;
  //     Get.to(HomePostUploadScreen());
  //   }
  // }

  Future<void> _pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final thumbnailFile = await VideoCompress.getFileThumbnail(video.path,
          quality: 50, position: 100);
      HomeController.to.pickerVideoPath.value = video.path;
      HomeController.to.pickerThumbnailVideoPath.value = thumbnailFile.path;
      Get.to(HomePostUploadScreen());
    }
  }
}
