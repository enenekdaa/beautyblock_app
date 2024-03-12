import 'dart:io';
import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_post_upload_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_post_share_screen.dart';
import 'package:beautyblock_app/widget/widget_custom_dropdown.dart';
import 'package:beautyblock_app/widget/widget_overlapping_images.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/post_model.dart';
import '../../utils.dart';
import '../../widget/widget_appbar.dart';

class HomePostUploadScreen extends StatelessWidget {
  HomePostUploadScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return HomePostUploadScreenScaffold(
      appBarSection: _buildAppBar(),
      imageSection: _buildimageSection(),
      writePostSection: _buildWritePost(),
      circularProgressIndicator: _buildCircularProgress(),
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
    final pickerImagePath = HomeController.to.pickerIamgePath.value;
    return OverlappingImagesWidget(image:pickerImagePath.isNotEmpty ? FileImage(File(pickerImagePath)):AssetImage('assets/images/img_main_logo.png'));
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
              onPress: () {
                HomeController.to.isPostUploading.value = true;
                uploadImage();},
              text: '저장',
              backgroundColor: GlobalBeautyColor.buttonHotPink),
        ],
      ),
    );
  }

 Widget _buildCircularProgress() {
    return Obx(()=> HomeController.to.isPostUploading.value ? Container(
        color: Colors.black.withOpacity(0.5),
        child:  Center(child: CircularProgressIndicator()) )
    : SizedBox.shrink()
    );
  }

  void showSaveSuccessDialog(){
    customDialog('저장완료', Text('저장이 완료 되었습니다.\n다른 곳에 자랑하러 가볼까요?',textAlign: TextAlign.center,), (){
      HomeController.to.updateDropdownSelectedValue('category','Brand');
      HomeController.to.uploadTitleController.text='';
      HomeController.to.uploadContentController.text='';
      HomeController.to.uploadTagController.text ='';
      Get.to(HomePostShareScreen()
      );}, '자랑하러 가기');
  }

  Future<void> uploadImage() async {
    var imagePath = HomeController.to.pickerIamgePath.value;
    if (imagePath.isNotEmpty) {
      File file = File(imagePath);

      final firebaseStorageRef = FirebaseStorage.instance;
      final firebaseStoreRef = FirebaseFirestore.instance;
      TaskSnapshot task = await firebaseStorageRef
          .ref('images')
          .child('${DateTime.now()}.jpg')
          .putFile(file);

      if (task != null) {
        var downloadUrl = await task.ref.getDownloadURL();

        var doc =
        firebaseStoreRef.collection('users').doc(LoginController.to.getId());
        doc.update({
          'posts': FieldValue.arrayUnion([PostModel(
            id: doc.id,
            userId: "001",
            imagePath: downloadUrl,
            category: HomeController.to.getDropdownSelectedValue('category'),
            title: HomeController.to.uploadTitleController.text,
            contents: HomeController.to.uploadContentController.text,
            tag: HomeController.to.uploadTagController.text,
          ).toJson()
          ])
        }).then((onValue) {
          HomeController.to.isPostUploading.value = false;
          showSaveSuccessDialog();
        });
      }
    } else {
      print('이미지 선택 취소');
    }
  }
}
