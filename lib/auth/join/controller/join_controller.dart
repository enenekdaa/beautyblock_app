import 'package:get/get.dart';

class JoinController extends GetxController {

  //termsOfUse
  var isChecked = List<bool>.filled(4, false).obs;

  //category
  var interestTypeIsChecked = List<bool>.filled(9, false).obs;
  var interestCategoryIsChecked = List<bool>.filled(7, false).obs;
  var interestCountryIsChecked = List<bool>.filled(1, false).obs;

  //category
  void toggleInterestTypeButton(int index){
    interestTypeIsChecked[index] = !interestTypeIsChecked[index];
  }
  void toggleInterestCategoryButton(int index){
    interestCategoryIsChecked[index] = !interestCategoryIsChecked[index];
  }
  void toggleInterestCountryButton(int index){
    interestCountryIsChecked[index] = !interestCountryIsChecked[index];
  }

  //termsOfUse
  void termsOfUseAllAgreeValueChanger() {
    if (isChecked[0] &&
        isChecked[1] &&
        isChecked[2]
    ) {
      isChecked[3]= true;
    } else {
      isChecked[3] = false;
    }
  }
}