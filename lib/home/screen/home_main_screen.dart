import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_add_detail_info_screen.dart';
import 'package:beautyblock_app/home/screen/home_post_upload_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import '../../config.dart';
import '../../widget/widget_drawer.dart';
import '../local_widget/scaffold/home_main_screen_scaffold.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return HomeMainScreenScaffold(
      bodySection: _buildBodySection(),
      bottomNavigationSection: BottomNavBar(),
      modalBottomSheet: _buildBottomModalSheet(context),
      drawer: DrawerWidget(),
    );
  }

  Widget _buildBodySection() {
    return Obx(() => BottomNavBarController.to
        .pages.value[BottomNavBarController.to.bottomNavCurrentIndex.value]);
  }

  Widget _buildBottomModalSheet(context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  height: Get.height * 0.35,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.02),
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
                          '영상 Play 만들기',
                          style: AppTheme.smallTitleTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Get.height * 0.01, left: 20),
                        child: GestureDetector(
                          child: Text('카메라/동영상'),
                          onTap: () {

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
                          child: Text('업로드'),
                          onTap: () {
                            _pickMediaFromGallery();
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
                          child: Text('스트리밍'),
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
      },
      child: Container(
        height: Get.height * 0.03,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Container(
            width: Get.width * 0.2,
            height: 4,
            color: GlobalBeautyColor.tagGray170,
          ),
        ),
      ),
    );
  }

  Future<void> _pickMediaFromGallery() async {
    final XFile? pickedMedia = await _picker.pickMedia(imageQuality:80);
    final videoExtensions = ['mp4', 'avi', 'mov', 'mkv', 'wmv'];
    if(pickedMedia != null){
      if(videoExtensions.any((extension) =>pickedMedia.path.endsWith(extension) )){
        HomeController.to.fetchImage.value = await VideoCompress.getFileThumbnail(pickedMedia.path).then((value) => Get.to(HomeAddDetailInfoScreen()));
      }else{
        HomeController.to.fetchImage.value = pickedMedia;
        Get.to(HomePostUploadScreen());
      }
    }
  }
  
}
