import 'package:beautyblock_app/model/channel_model.dart';
import 'package:beautyblock_app/model/roles_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  //textEditingController
  var uploadTitleController = TextEditingController();
  var uploadContentController = TextEditingController();
  var uploadTagController = TextEditingController();
  var searchController = TextEditingController();

  //mainPage
  var isShowSubscriptionChannel = false.obs;
  var influencerList = [].obs;
  var selectIfluencerIndex = 0.obs;

  //search
  var brandList =[].obs;
  var filteredData = [].obs;
  var searchQuery ="".obs;


  //selectCountry
  var continents = [].obs;
  var countries = [].obs;

  //postUpload
  var categories = [].obs;
  late final fetchImage ;

  //fetchList
  var channels = <ChannelModel>[].obs;
  var roles = <RolesModel>[].obs;

  //dropdown
  var dropdownSelected = <String, String>{
    "category": "Brand",
    "country": '대한민국',
    'continent': '아시아'
  }.obs;

  //drawer
  var selectedSearchCategory = 'Brand'.obs;

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
  void updateSearchQuery(String newQuery) {
      searchQuery.value = newQuery;
      if (searchQuery.value.isNotEmpty) {
        filteredData.value = brandList
            .where((item) =>
            item.toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList();
      } else {
        filteredData.value = brandList;
      }
  }


  @override
  void onInit() {
    super.onInit();
    influencerList.value = ['홍길동', '존박', '아리수', '고릴라', '쌈바', '손오공', '보노보노'];
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
    categories.value = [
      'Total',
      "Brand",
      "Distribute",
      "Celeb/Influencer",
      "Marketing/PR",
      'OEM/ODM',
      'Logistic',
    ];
    brandList.value = [
      '샤넬',
      '루이비통',
      '쿠션',
      '맥',
      '프라다',
      '디올',
      '뷰티블록',
    ];
    filteredData.value = brandList;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    uploadTitleController.dispose();
    uploadContentController.dispose();
    uploadTagController.dispose();
    searchController.dispose();
    influencerList.value = [];
    countries.value = [];
    continents.value=[];
    categories.value = [];
  }

}
