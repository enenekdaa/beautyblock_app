import 'package:beautyblock_app/constants/beauty_constants.dart';
import 'package:beautyblock_app/fan/controller/fan_controller.dart';
import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/model/channel_model.dart';
import 'package:beautyblock_app/model/firebase_post_model.dart';
import 'package:beautyblock_app/model/roles_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/login/controller/login_controller.dart';
import '../../constants/firestore_constants.dart';
import '../../model/firebase_subscription_model.dart';
import '../../model/firebase_user_model.dart';
import '../../model/video_model.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  List<BeautyPost> popularPosts = [];
  List<BeautyPost> newPosts = [];
  List<BeautyPost> recommendPosts = [];
  List<BeautyPost> interestPosts = [];
  List<BeautyPost> subscribingPosts = [];
  List<BeautySubscription> subscriptions = [];
  List<BeautyUser> subscriptionChannels = [];
  List<BeautyUser> filteredChannels = [];
  //textEditingController
  var uploadTitleController = TextEditingController();
  var uploadContentController = TextEditingController();
  var uploadTagController = TextEditingController();
  var searchController = TextEditingController();
  var videoDescriptionController = TextEditingController();

  //mainPage
  bool isShowSubscriptionChannel = false;
  String selectInfluencerId = '';
  bool influencerSelected = false;

  //search
  // var brandList = [].obs;
  // var filteredData = [].obs;
  // var searchQuery = "".obs;
  List<BeautyPost> searchedList = [];

  //selectCountry
  var continents = [].obs;
  var countries = [].obs;

  //postUpload
  var categories = [].obs;
  var pickerVideoPath = "".obs;
  var pickerImagePath = ''.obs;
  var pickerThumbnailVideoPath = ''.obs;
  var isPostUploading = false.obs;
  var isVideoUploading = false.obs;
  var tags = emptyList.obs;

  //tag
  void addTag(tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
    return;
  }

  void removeTag(tag) {
    tags.remove(tag);
  }

  //fetchList
  var channels = <ChannelModel>[].obs;
  var roles = <RolesModel>[].obs;
  var videos = <VideoModel>[].obs;

  //dropdown
  var dropdownSelected = <String, String>{
    "category": "Brand",
    "country": '대한민국',
    'continent': '아시아'
  }.obs;

  //drawer
  int drawerIndex = 0;
  String selectedCategory = '';
  String selectedContinent = "";
  String selectedCountry = "";

  //alarmPage
  var isAlarmClicked = false.obs;

  //switchClicked
  var isSwitchChecked = <String, bool>{
    'isPostOpen': false,
    'isUseReview': false,
    'isAlarm': false
  }.obs;

  //worldAndCategorySelect
  var isWorldSelected = false.obs;

  //alarm
  void toggleAlarmbutton() {
    isAlarmClicked.value = !isAlarmClicked.value;
  }

  //updateDropdown
  void updateDropdownSelectedValue(String dropdownKey, String newValue) {
    dropdownSelected[dropdownKey] = newValue;
    dropdownSelected.refresh();
  }

  //dropdownGetValue
  String? getDropdownSelectedValue(String dropdownKey) {
    return dropdownSelected[dropdownKey];
  }

  //dropdownGetValue
  String? getGroupSelectedValue(String dropdownKey) {
    return dropdownSelected[dropdownKey];
  }

  //dropdownGetValue
  String? getTitleSelectedValue(String dropdownKey) {
    return dropdownSelected[dropdownKey];
  }

  //updateSwitch
  void updateSwitchValue(String switchKey, bool newValue) {
    isSwitchChecked[switchKey] = newValue;
    isSwitchChecked.refresh();
  }

  //switchGetValue
  bool getSwitchValue(String switchKey) {
    return isSwitchChecked[switchKey]!;
  }

  // sortFromList(type,List list){
  //   if(type == 'Latest'){
  //     list.sort((a,b) => a.createAt.compareTo(b.createAt));
  //   }else{
  //     list.sort((a,b)=> a.po.compareTo(b.po));
  //   }
  // }
  void updateSearchQuery() async {
    // 검색어로 시작하는 title을 가진 posts 문서를 조회
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(FirestoreConstants.pathPostCollection)
        .where('title', isGreaterThanOrEqualTo: searchController.text)
        .where('title', isLessThan: '${searchController.text}\uf8ff')
        .get();
    List<BeautyPost> tmp = [];
    for (DocumentSnapshot item in querySnapshot.docs) {
      tmp.add(BeautyPost.fromDocument(item));
    }
    searchedList = tmp;
    update();
  }

  void clearSearchResult() {
    searchedList = [];
  }

  @override
  void onInit() async {
    super.onInit();

    countries.value = ['대한민국', '중국', '미국', '말레이시아', '캐나다', '영국', '네덜란드'];
    continents.value = [
      '아시아',
      '아프리카',
      '북 아메리카',
      '남 아메리카',
      '남극 대륙',
      ' 유럽',
      ' 오세아니아'
    ];
    categories.value = [...BeautyConstants.positions];
    updateMainPosts();
    updateSubscribe();
    getSubscriptionChannels();
  }

  void updateMainPosts() async {
    final postsRef = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathPostCollection)
        .orderBy('createdAt', descending: true)
        .limit(20);
    //10개까지만 추출
    final querySnapshot = await postsRef.get();
    List<BeautyPost> posts = [];

    for (var doc in querySnapshot.docs) {
      posts.add(BeautyPost.fromDocument(doc));
    }
    popularPosts = posts.toList();
    popularPosts.sort((a, b) => b.viewCnt - a.viewCnt);
    interestPosts = posts.toList();
    interestPosts.sort((a, b) => b.likes.length - a.likes.length);
    newPosts = posts.toList();
    newPosts.sort((a, b) {
      DateTime dateA = DateTime.parse(b.createdAt);
      DateTime dateB = DateTime.parse(a.createdAt);
      return dateA.compareTo(dateB);
    });
    recommendPosts = posts.toList();
    recommendPosts.sort((a, b) {
      int scoreA = a.viewCnt + a.likes.length * 10;
      int scoreB = b.viewCnt + b.likes.length * 10;
      return scoreB - scoreA;
    });

    update();
  }

  updateSubscribe() async {
    QuerySnapshot result = await firebaseFirestore
        .collection(FirestoreConstants.pathSubscriptionCollection)
        .where('userId', isEqualTo: LoginController.to.getId())
        .get();
    List<BeautySubscription> tmp = [];
    for (var doc in result.docs) {
      BeautySubscription sub = BeautySubscription.fromDocument(doc);
      tmp.add(sub);
    }
    subscriptions = tmp;
    update();
  }

  changeSubscribe({required int type, required String targetId}) async {
    //0: 구독, 1: 알림취소, 2: 구독취소(삭제)
    QuerySnapshot result = await firebaseFirestore
        .collection(FirestoreConstants.pathSubscriptionCollection)
        .where('userId', isEqualTo: LoginController.to.getId())
        .where('channelId', isEqualTo: targetId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (type == 0) {
      // 문서의 존재 여부를 확인합니다.
      if (!documents.isNotEmpty) {
        // 문서가 존재하지 않는 경우, 새로운 문서를 생성합니다.
        print("Creating new subscription with type 0.");
        await firebaseFirestore
            .collection(FirestoreConstants.pathSubscriptionCollection)
            .add(BeautySubscription(
                    userId: LoginController.to.getId(),
                    type: type,
                    channelId: targetId)
                .toJson());
      } else {
        // 문서가 이미 존재하는 경우, type을 업데이트합니다.
        DocumentReference documentRef = FirebaseFirestore.instance
            .collection(FirestoreConstants.pathSubscriptionCollection)
            .doc(documents[0].id);
        documentRef.update({'type': type});
      }
    } else if (type == 1) {
      // type을 1로 업데이트합니다.
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection(FirestoreConstants.pathSubscriptionCollection)
          .doc(documents[0].id);
      documentRef.update({'type': type});
    } else if (type == 2) {
      // type이 2인 경우, 해당 구독 데이터(문서)를 삭제합니다.
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection(FirestoreConstants.pathSubscriptionCollection)
          .doc(documents[0].id);
      documentRef.delete();
    }
    updateSubscribe();
  }

  bool isSubscribe(String channelId) {
    return subscriptions
        .where((element) => element.channelId == channelId)
        .toList()
        .isNotEmpty;
  }

  int getSubscriptionStatus(String channelId) {
    List<BeautySubscription> list = subscriptions
        .where((element) => element.channelId == channelId)
        .toList();
    if (list.isEmpty) {
      return 2;
    } else {
      return list.first.type;
    }
  }

  getSubscriptionChannels() async {
    List<String> channelIdList = [];
    List<DocumentSnapshot> allResults = [];
    for (var element in subscriptions) {
      channelIdList.add(element.channelId);
    }
    // channelIds 배열을 10개 단위로 분할
    for (int i = 0; i < channelIdList.length; i += 10) {
      List<String> subset = channelIdList.sublist(
          i, i + 10 > channelIdList.length ? channelIdList.length : i + 10);

      final QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .where(FieldPath.documentId, whereIn: subset)
          .get();

      allResults.addAll(querySnapshot.docs);
    }
    List<BeautyUser> tmp = [];
    for (DocumentSnapshot doc in allResults) {
      tmp.add(BeautyUser.fromDocument(doc));
    }
    subscriptionChannels = tmp;
    //구독 중인 채널들의 포스트 호출
    updateSubscribingPosts();
  }

  updateSubscribingPosts() async {
    List<String> channelIdList = [];
    List<DocumentSnapshot> allResults = [];
    for (var element in subscriptions) {
      channelIdList.add(element.channelId);
    }
    List<DocumentSnapshot> allPosts = [];

    // userIds를 10개 단위로 분할하여 쿼리
    for (int i = 0; i < channelIdList.length; i += 10) {
      List<String> subset = channelIdList.sublist(
          i, i + 10 > channelIdList.length ? channelIdList.length : i + 10);

      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(FirestoreConstants.pathPostCollection)
          .where('userId', whereIn: subset)
          // .orderBy('createdAt', descending: true)
          .get();

      allPosts.addAll(querySnapshot.docs);
    }
    List<BeautyPost> postTmp = [];
    for (DocumentSnapshot doc in allPosts) {
      postTmp.add(BeautyPost.fromDocument(doc));
    }
    subscribingPosts = postTmp;
    update();
  }

  @override
  void dispose() {
    uploadTitleController.dispose();
    uploadContentController.dispose();
    uploadTagController.dispose();
    searchController.dispose();
    videoDescriptionController.dispose();
    countries.value = [];
    continents.value = [];
    categories.value = [];
    super.dispose();
  }

  void toggleShowSubscriptionChannel() {
    if (!isShowSubscriptionChannel) {
      updateSubscribe();
      getSubscriptionChannels();
    }
    influencerSelected = false;
    isShowSubscriptionChannel = !isShowSubscriptionChannel;
    update();
  }

  void tapInfluencer(BeautyUser element) {
    if (!influencerSelected) {
      selectInfluencerId = element.id;
      influencerSelected = true;
    } else {
      if (selectInfluencerId == element.id) {
        influencerSelected = false;
      } else {
        selectInfluencerId = element.id;
      }
    }
    update();
  }

  selectCategory(String value) {
    selectedCategory = value;
    drawerIndex = 1;
    update();
  }

  selectContinent(String value) {
    selectedContinent = value;
    drawerIndex = 2;
    update();
  }

  selectCountry(String value) async {
    selectedCountry = value;
    closeDrawer();
    BottomNavBarController.to.bottomNavCurrentIndex.value = 1;
    //필터 검색
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where('position', isEqualTo: selectedCategory)
        .where('interestCountry', isEqualTo: selectedCountry)
        .get();
    List<BeautyUser> tmp = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      tmp.add(BeautyUser.fromDocument(doc));
    }
    print('value :: ${value}');
    filteredChannels = tmp;
    update();
  }

  selectCountryFan(String value) async {
    selectedCountry = value;
    //필터 검색
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where('position', isEqualTo: selectedCategory)
        .where('interestCountry', isEqualTo: selectedCountry)
        .orderBy('followCnt',descending: true)
        .get();
    List<BeautyUser> tmp = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      tmp.add(BeautyUser.fromDocument(doc));
    }
    print('value :: ${value}');
    filteredChannels = tmp;
    update();
  }

  closeDrawer() {
    BottomNavBarController.to.scaffoldKey.currentState?.closeDrawer();
  }

  selectDrawerBack() {
    if (drawerIndex > 0) {
      if (drawerIndex == 2) {
        //국가 선택
        selectedCountry = '';
      } else if (drawerIndex == 1) {
        selectedContinent = '';
      } else if (drawerIndex == 0) {
        selectedCategory = '';
      }
      drawerIndex--;
    }
    update();
  }

  String getCategoryString() {
    return '$selectedCategory > $selectedContinent > $selectedCountry';
  }

  void openDrawer() {
    selectedCountry = '';
    selectedContinent = '';
    selectedCategory = '';
    drawerIndex = 0;
    update();
    BottomNavBarController.to.scaffoldKey.currentState?.openDrawer();
  }
}
