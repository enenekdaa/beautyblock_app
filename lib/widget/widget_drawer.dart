import 'package:beautyblock_app/constants/beauty_constants.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_select_country_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final HomeController _homeController = Get.put(HomeController());
  @override
  build(BuildContext context) {
    return Drawer(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Container(
          height: Get.height,
          padding: EdgeInsets.only(top: Get.height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image.asset(
                  'assets/images/ic_main_leading_logo_2.png',
                  width: Get.width / 2.5,
                ),
              ),
              SizedBox(height: 34),
              buildDrawerByIndex()
            ],
          ),
        );
      }),
    );
  }

  Expanded buildDrawerByIndex() {
    List<String> categoryList = [...BeautyConstants.positions];
    List<String> continentList = BeautyConstants.continent.keys.toList();
    if (HomeController.to.drawerIndex == 0) {
      return Expanded(
          child: ListView(
        children: categoryList.map((item) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                dense: true,
                title: Text(
                  item,
                  style: AppTheme.tagTextStyle.copyWith(
                      color: Color.fromRGBO(23, 31, 36, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                onTap: () {
                  if (item == 'Total') {
                    //Total일 경우 아무 동작 안하게 - 이건주PM님
                    Fluttertoast.showToast(msg: '준비중인 기능입니다');
                  } else {
                    HomeController.to.selectCategory(item);
                  }
                  // Get.to(HomeSelectCountryScreen());
                },
                trailing: SvgPicture.asset('assets/images/ic_front_arrow.svg'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Color.fromRGBO(231, 232, 236, 1),
                ),
              )
            ],
          );
        }).toList(),
      ));
    } else if (HomeController.to.drawerIndex == 1) {
      return Expanded(
        child: ListView(children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            dense: true,
            title: Text(
              HomeController.to.selectedCategory,
              style: AppTheme.tagTextStyle.copyWith(
                  color: Color.fromRGBO(23, 31, 36, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            onTap: () {
              HomeController.to.selectDrawerBack();
            },
            leading: SvgPicture.asset(
              'assets/images/ic_back_arrow.svg',
            ),
          ),
          ...continentList.map((item) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  dense: true,
                  title: Text(
                    item,
                    style: AppTheme.tagTextStyle.copyWith(
                        color: Color.fromRGBO(23, 31, 36, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onTap: () {
                    HomeController.to.selectContinent(item);
                  },
                  trailing:
                      SvgPicture.asset('assets/images/ic_front_arrow.svg'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1,
                    color: Color.fromRGBO(231, 232, 236, 1),
                  ),
                )
              ],
            );
          }).toList(),
        ]),
      );
    } else if (HomeController.to.drawerIndex == 2) {
      return Expanded(
        child: ListView(children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            dense: true,
            title: Text(
              '${HomeController.to.selectedCategory} > ${HomeController.to.selectedContinent}',
              style: AppTheme.tagTextStyle.copyWith(
                  color: Color.fromRGBO(23, 31, 36, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            onTap: () {
              HomeController.to.selectDrawerBack();
            },
            leading: SvgPicture.asset(
              'assets/images/ic_back_arrow.svg',
            ),
          ),
          ...?BeautyConstants.continent[HomeController.to.selectedContinent]
              ?.map((item) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  dense: true,
                  title: Text(
                    item,
                    style: AppTheme.tagTextStyle.copyWith(
                        color: Color.fromRGBO(23, 31, 36, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onTap: () {
                    HomeController.to.selectCountry(item);
                  },
                  trailing:
                      SvgPicture.asset('assets/images/ic_front_arrow.svg'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1,
                    color: Color.fromRGBO(231, 232, 236, 1),
                  ),
                )
              ],
            );
          }).toList(),
        ]),
      );
    } else {
      return Expanded(child: Container());
    }
  }
}
