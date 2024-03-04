import 'package:get/get.dart';

class HomeController extends GetxController {
  //mainPage
  var influencerList = [].obs;
  var selectIfluencerIndex = 0.obs;
  //selectCountry
  var continents = [].obs;
  var countries = [].obs;
  //postUpload
  var categories = [].obs;
  //dropdown
  var dropdownSelected = <String, String>{
    "category": "Brand",
    "countries": '대한민국',
    'continents': '아시아'
  }.obs;
  //alarmPage
  var isAlarmClicked = false.obs;
  //switchClicked
  var isSwitchChecked = <String, bool>{'isPostOpen':false,'isUseReview':false,'isAlarm':false}.obs;
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
  }
}
