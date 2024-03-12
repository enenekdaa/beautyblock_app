import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTitleDropDownWidget extends StatelessWidget {
  CustomTitleDropDownWidget(
      {Key? key,
        required this.itemList,
        required this.dropdownKey,
      })
      : super(key: key);

  final  itemList;
  final dropdownKey;

  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
   List<DropdownMenuItem<String>> widgetList =[];
    if(itemList != null){
      itemList.forEach((value){
      widgetList.add(DropdownMenuItem(
        value: value.title,
        child: Text(value.title,style: AppTheme.smallTitleTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w400),),
      ));
      });
    }

    return Obx(()=> Container(
        height: Get.height * 0.06,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        // 드롭다운 버튼의 내부 패딩
        decoration: BoxDecoration(
          color: Color.fromRGBO(171, 169, 163, 0.12), // 배경색을 회색으로 설정
          borderRadius: BorderRadius.circular(8), // 모서리를 둥글게
        ),
        child: DropdownButton(
          style: AppTheme.tagTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w400),
          isExpanded: true,
          value: _homeController.getDropdownSelectedValue(dropdownKey),
            isDense: true,
            underline: SizedBox.shrink(),
            icon: SvgPicture.asset('assets/images/ic_dropdown.svg'),
            // isExpanded: true,
            items: widgetList,
            onChanged:(value){
              _homeController.updateDropdownSelectedValue(dropdownKey, value.toString());
            }),
      ),
    );
  }
}
