import 'dart:io';

import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/list_item/home_add_detail_info_list_item.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_add_detail_info_screen_scaffold.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../config.dart';
import '../../model/video_model.dart';
import '../../widget/widget_radius_button.dart';
import 'home_main_screen.dart';

class HomeAddDetailInfoScreen extends StatefulWidget {
  HomeAddDetailInfoScreen({super.key});

  @override
  State<HomeAddDetailInfoScreen> createState() => _HomeAddDetailInfoScreen();
}
class _HomeAddDetailInfoScreen extends State<HomeAddDetailInfoScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetControllValue();
  }
  @override
  Widget build(BuildContext context) {
    return HomeAddDetailInfoScaffold(
      homeAppbarSection: _buildAppbar(),
      selectViedoThumbnailSection: _buildSelectedVideoThumbnailAndDescription(),
      selectInfoSection: _buildSelectInfoList(),
      bottomButtonSection: _buildBottomButton(),
      circularProgress: _buildCircularProgress(),
    );
  }

  Widget _buildAppbar() {
    return AppbarWidget(
      appbarText: '세부정보 추가',
      actions: [
        // SvgPicture.asset('assets/images/ic_bell.svg'),
        // SvgPicture.asset('assets/images/ic_search.svg')
      ],
    );
  }

  Widget _buildSelectedVideoThumbnailAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.11,
          width: Get.width * 0.4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(HomeController.to.pickerThumbnailVideoPath.value),fit: BoxFit.cover,),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeAddDetailInfoItem(text: LoginController.to.getNick()),
          SizedBox(height: Get.height * 0.01,),
          Obx(() =>
              HomeAddDetailInfoItem(
                text: '공개상태:${HomeController.to.getSwitchValue('isPostOpen')
                    ? '공개'
                    : '비공개'}', useSwitch: true, switchKey: 'isPostOpen',)),
          SizedBox(height: Get.height * 0.01,),
          HomeAddDetailInfoItem(text: '위치'),
          SizedBox(height: Get.height * 0.01,),
          Column(
            children: [
              HomeAddDetailInfoItem(text: '공개대상 선택'),
              SizedBox(height: Get.height * 0.01,),
              Text(
                '모든 크리에이터는 위치에 상관없이 이동 온라인 개인정보 보호법COPPA 및 기타 법률을 준수해야 할 법적인 의무가 있습니다.아동용 동영상인지 여부는 크리에이터가 지정해야 합니다.',
                softWrap: true,style: AppTheme.tagTextStyle.copyWith(height: 1.20),),
              SizedBox(height: Get.height * 0.01,),
            ],
          ),

          HomeAddDetailInfoItem(
            text: '댓글 사용', useSwitch: true, switchKey: 'isUseReview',)
        ],

      ),
    );
  }

  Widget _buildBottomButton() {
    return RadiusButtonWidget(
        onPress: () {showUploadDialog();},
        text: '동영상 업로드',
        backgroundColor: GlobalBeautyColor.buttonHotPink);
  }

  Widget _buildCircularProgress() {
    return Obx(()=> HomeController.to.isVideoUploading.value ? Container(
        color: Colors.black.withOpacity(0.5),
        child:  Center(child: CircularProgressIndicator()) )
        : SizedBox.shrink()
    );
  }

  Future<void> uploadFile() async {
    var videoPath = HomeController.to.pickerVideoPath.value;
    var videoThumbnailPath = HomeController.to.pickerThumbnailVideoPath.value;
    if (videoPath.isNotEmpty) {
      File videofile = File(videoPath);
      File videoThumbnailFile = File(videoThumbnailPath);
      final firebaseStorageRef = FirebaseStorage.instance;
      final firebaseStoreRef = FirebaseFirestore.instance;
      TaskSnapshot task = await firebaseStorageRef
          .ref('videos')
          .child('${DateTime.now()}.mp4')
          .putFile(videofile);

      TaskSnapshot thumbnailTask = await firebaseStorageRef
          .ref('thumbnail')
          .child('${DateTime.now()}.jpg')
          .putFile(videoThumbnailFile);

      if (task != null) {
        var videoDownloadUrl = await task.ref.getDownloadURL();
        var thumbnailDownloadUrl = await thumbnailTask.ref.getDownloadURL();
        var doc =
        firebaseStoreRef.collection('users').doc(LoginController.to.getId());
        DocumentSnapshot documentSnapshot = await doc.get();
    List  videoList =  documentSnapshot.get('videos') as List? ?? [];
        print(LoginController.to.getId());
        doc.update({
          'videos':FieldValue.arrayUnion([
          VideoModel(
            createAt: DateTime.now().toString(),
            status: HomeController.to.getSwitchValue('isPostOpen').toString(),
            updateAt: DateTime.now().toString(),
            video: await videoDownloadUrl.toString(),
            videoId: videoList.length +1,
            videoDescription: HomeController.to.videoDescriptionController.text,
            thumbNail: await thumbnailDownloadUrl,
            isActiveReview: HomeController.to.getSwitchValue('isUseReview'),
          ).toJson()
        ])}).then((onValue) {
          HomeController.to.isVideoUploading.value = false;
          Get.offAll(HomeMainScreen());
        });
      }
    } else {
      print('동영상 선택 취소');
    }
  }
  void showUploadDialog(){
    customDialog('Upload 안내', Text('해당 파일을 업로드 하시겠습니까?',textAlign: TextAlign.center,), (){
      navigator?.pop(Get.context);
      HomeController.to.isVideoUploading.value = true;
      uploadFile();}, '확인');
  }
  void resetControllValue(){
    HomeController.to.videoDescriptionController.text = '';
    HomeController.to.updateSwitchValue("isPostOpen", false);
    HomeController.to.updateSwitchValue("isUseReview", false);
  }
}
