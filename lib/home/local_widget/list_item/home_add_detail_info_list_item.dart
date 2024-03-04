import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAddDetailInfoItem extends StatelessWidget {
  HomeAddDetailInfoItem({
  Key? key,
    // required this.image,
    required this.text,
    this.useSwitch = false,
    this.switchKey,
});

  // final image;
  final text;
  final useSwitch;
  final switchKey;

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Get.width * 0.02),
                    child: CircleAvatar(
                      radius: Get.height * 0.025,
                      backgroundImage: AssetImage('assets/images/img_test.png'),
                    ),
                  ),
                  Text(text, style: AppTheme.smallTitleTextStyle.copyWith(
                      fontSize: 16,
                      height: 1.45,
                      color: Color.fromRGBO(30, 29, 29, 1)),)
                ],
              ),
              useSwitch?
              Obx(()=>Switch(
                  value: _homeController.getSwitchValue(switchKey),
                activeColor: GlobalBeautyColor.buttonHotPink, // 활성화 상태의 thumb 색상
                activeTrackColor: Color.fromRGBO(171, 169, 163, 0.12), // 활성화 상태의 track 색상
                inactiveThumbColor: Color.fromRGBO(213, 212, 208, 1), // 비활성화 상태의 thumb 색상
                inactiveTrackColor: Color.fromRGBO(171, 169, 163, 0.24),
                trackOutlineColor: MaterialStateProperty.resolveWith(
                      (final Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return null;
                    }
                    return Colors.transparent;
                  },
                ),
                  onChanged: (bool? value) {
                    _homeController.updateSwitchValue(switchKey, value!);
                  },
                ),
              )
              :Text('')
              ,
            ],
          ),
        ],
      ),
    );
  }}
