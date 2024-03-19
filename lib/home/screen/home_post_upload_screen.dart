import 'dart:io';
import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_post_upload_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_post_share_screen.dart';
import 'package:beautyblock_app/widget/widget_custom_dropdown.dart';
import 'package:beautyblock_app/widget/widget_overlapping_images.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_tag_chip.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../constants/firestore_constants.dart';
import '../../model/firebase_post_model.dart';
import '../../utils.dart';
import '../../widget/widget_appbar.dart';

class HomePostUploadScreen extends StatefulWidget {
  HomePostUploadScreen({super.key});

  @override
  State<HomePostUploadScreen> createState() => _HomePostUploadScreen();
}

class _HomePostUploadScreen extends State<HomePostUploadScreen> {
  @override
  void dispose() {
    resetControllValue();

    super.dispose();
  }

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
      isShowLeading: false,
      appbarText: "",
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              resetControllValue();
              Get.back();
            },
            child: Text(
              'Cancel',
              style: AppTheme.smallTitleTextStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildimageSection() {
    final pickerImagePath = HomeController.to.pickerThumbnailVideoPath.value;
    return OverlappingImagesWidget(
        image: pickerImagePath.isNotEmpty
            ? FileImage(File(pickerImagePath))
            : AssetImage('assets/images/img_main_logo_2.png'));
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
          Text(
            'Category',
            style: AppTheme.smallTitleTextStyle.copyWith(fontSize: 13),
          ),
          SizedBox(height: Get.height * 0.01),
          CustomDropDownWidget(
              itemList: HomeController.to.categories, dropdownKey: 'category'),
          SizedBox(height: Get.height * 0.03),
          TextInputWidget(
            titleText: 'Title',
            hintText: 'Enter Title',
            isGuideTextVisible: false,
            controller: HomeController.to.uploadTitleController,
          ),
          SizedBox(height: Get.height * 0.03),
          Text(
            'Content',
            style: AppTheme.smallTitleTextStyle,
          ),
          SizedBox(height: Get.height * 0.01),
          Stack(children: [
            TextField(
              maxLength: 2000,
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: HomeController.to.uploadContentController,
              decoration: InputDecoration(
                  hintText: 'Enter Content',
                  hintStyle: AppTheme.tagTextStyle
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  filled: true,
                  fillColor: Color.fromRGBO(171, 169, 163, 0.12),
                  enabledBorder: OutlineInputBorder(
                    // 기본 모양
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Positioned(
              bottom: -2,
              child: Text(
                'You can enter up to 2,000 words.',
                style: AppTheme.tagTextStyle,
              ),
            )
          ]),
          SizedBox(height: Get.height * 0.03),
          Stack(children: [
            TextInputWidget(
              titleText: 'Tags',
              hintText: "Tags",
              isGuideTextVisible: false,
              controller: HomeController.to.uploadTagController,
            ),
            Positioned(
                right: 0,
                top: 30,
                child: IconButton(
                  icon: Icon(CupertinoIcons.add_circled),
                  onPressed: () {
                    if (HomeController.to.uploadTagController.text.isNotEmpty) {
                      HomeController.to
                          .addTag(HomeController.to.uploadTagController.text);
                      HomeController.to.uploadTagController.text = '';
                    }
                  },
                ))
          ]),
          SizedBox(height: Get.height * 0.015),
          _tagsWidget(),
          SizedBox(height: Get.height * 0.03),
          RadiusButtonWidget(
              onPress: () {
                // uploadImage();
                FocusScope.of(context).unfocus();
                showUploadDialog();
              },
              text: 'Upload',
              backgroundColor: GlobalBeautyColor.buttonHotPink),
        ],
      ),
    );
  }

  Widget _tagsWidget() {
    return Obx(
      () => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HomeController.to.tags.length > 0
                ? Column(children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: HomeController.to.tags
                          .map((tag) => TagChipWidget(
                                tag: tag,
                                onTap: () => HomeController.to.removeTag(tag),
                              ))
                          .toSet()
                          .toList(),
                    ),
                  ])
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgress() {
    return Obx(() => HomeController.to.isPostUploading.value
        ? Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(child: CircularProgressIndicator()))
        : SizedBox.shrink());
  }

  void showUploadDialog() {
    customDialog(
        'Upload Guide',
        Text(
          'Would you like to upload this file?',
          textAlign: TextAlign.center,
        ), () {
      FocusScope.of(context).unfocus();
      navigator?.pop(Get.context);
      HomeController.to.isPostUploading.value = true;
      uploadFile();
    }, 'Confirm');
  }

  void showSaveSuccessDialog() {
    customDialog(
        'Upload Complete',
        Text(
          'Would you like to share your new video?',
          textAlign: TextAlign.center,
        ), () {
      FocusScope.of(context).unfocus();
      navigator?.pop(Get.context);
      resetControllValue();
      Get.off(() => const HomePostShareScreen());
    }, 'Share');
  }

  void resetControllValue() {
    HomeController.to.updateDropdownSelectedValue('category', 'Brand');
    HomeController.to.uploadTitleController.text = '';
    HomeController.to.uploadContentController.text = '';
    HomeController.to.uploadTagController.text = '';
    HomeController.to.tags.value = [];
    HomeController.to.isPostUploading.value = false;
  }

  Future<void> uploadFile() async {
    var videoPath = HomeController.to.pickerVideoPath.value;
    var videoThumbnailPath = HomeController.to.pickerThumbnailVideoPath.value;

    if (videoPath.isNotEmpty) {
      File videofile = File(videoPath);
      File videoThumbnailFile = File(videoThumbnailPath);
      //영상 길이 추가
      VideoPlayerController? controller;
      controller = VideoPlayerController.file(videofile);
      await controller.initialize();
      int duration = controller.value.duration.inSeconds;
      controller.dispose();
      final firebaseStorageRef = FirebaseStorage.instance;
      final firebaseStoreRef = FirebaseFirestore.instance;
      TaskSnapshot task = await firebaseStorageRef
          .ref('videos')
          .child('${DateTime.now()}.mp4')
          .putFile(videofile);

      TaskSnapshot thumbnailTask = await firebaseStorageRef
          .ref('thumbnails')
          .child('${DateTime.now()}.jpg')
          .putFile(videoThumbnailFile);

      if (task != null) {
        var videoDownloadUrl = await task.ref.getDownloadURL();
        var thumbnailDownloadUrl = await thumbnailTask.ref.getDownloadURL();
        // var doc = firebaseStoreRef
        //     .collection(FirestoreConstants.pathUserCollection)
        //     .doc(LoginController.to.getId());
        // DocumentSnapshot documentSnapshot = await doc.get();
        // List postsList = documentSnapshot.get('posts') as List;

        // print("=================$postsList");
        // print(LoginController.to.getId());
        BeautyPost postData = BeautyPost(
            id: 'temp',
            userId: LoginController.to.getId(),
            video: await videoDownloadUrl.toString(),
            thumbnail: await thumbnailDownloadUrl.toString(),
            category: HomeController.to.getDropdownSelectedValue('category')!,
            title: HomeController.to.uploadTitleController.text,
            contents: HomeController.to.uploadContentController.text,
            createdAt: DateTime.now().toString(),
            tags: HomeController.to.tags,
            videoLength: duration);
        DocumentReference doc = await firebaseStoreRef
            .collection(FirestoreConstants.pathPostCollection)
            .add(postData.toJson());
        await doc.update({'id': doc.id});
        postData.id = doc.id;
        notifyFollowers(postData);
        HomeController.to.isPostUploading.value = false;
        showSaveSuccessDialog();
      }
    } else {
      print('동영상 선택 취소');
    }
  }

  void notifyFollowers(BeautyPost postData) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 채널의 구독자 목록 조회
    QuerySnapshot subscriptionSnapshot = await firestore
        .collection(FirestoreConstants.pathSubscriptionCollection)
        .where('channelId', isEqualTo: postData.userId)
        .get();

    // 각 구독자에 대해 알림 생성
    for (var doc in subscriptionSnapshot.docs) {
      String subscriberId = doc['userId']; // 구독자 ID를 얻습니다.

      // 알림 데이터를 생성합니다. 예를 들면 아래와 같습니다:
      Map<String, dynamic> notificationData = {
        'toId': subscriberId, // 알림을 받을 구독자 ID
        'fromId': postData.userId, // 알림을 보내는 채널(포스트 작성자) ID
        'image': postData.thumbnail, // 포스트 이미지
        'content': 'Video uploaded from ${LoginController.to.getNick()} : '
            '${postData.title}',
        // 알림 내용
        'createdAt': DateTime.now().toString(), // 알림 생성 시간
        'type': 'post', // 알림 타입
        'postId': postData.id
      };

      // 'notifications' 컬렉션에 알림 문서를 추가합니다.
      await firestore.collection('notifications').add(notificationData);
    }
  }

// Future<void> uploadImage() async {
//   var imagePath = HomeController.to.pickerImagePath.value;
//   if (imagePath.isNotEmpty) {
//     File file = File(imagePath);
//
//     final firebaseStorageRef = FirebaseStorage.instance;
//     final firebaseStoreRef = FirebaseFirestore.instance;
//     TaskSnapshot task = await firebaseStorageRef
//         .ref('images')
//         .child('${DateTime.now()}.jpg')
//         .putFile(file);
//
//     if (task != null) {
//       var downloadUrl = await task.ref.getDownloadURL();
//
//       var doc =
//       firebaseStoreRef.collection(FirestoreConstants.pathUserCollection).doc(LoginController.to.getId());
//       doc.update({
//         'posts': FieldValue.arrayUnion([PostModel(
//           id: doc.id,
//           userId: "001",
//           imagePath: downloadUrl,
//           category: HomeController.to.getDropdownSelectedValue('category'),
//           title: HomeController.to.uploadTitleController.text,
//           contents: HomeController.to.uploadContentController.text,
//           tag: HomeController.to.uploadTagController.text,
//         ).toJson()
//         ])
//       }).then((onValue) {
//         HomeController.to.isPostUploading.value = false;
//         showSaveSuccessDialog();
//       });
//     }
//   } else {
//     print('이미지 선택 취소');
//   }
// }
}
