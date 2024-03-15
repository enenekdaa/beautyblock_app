import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_channel_world_and_category_select_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widget/widget_appbar.dart';

class HomeChannelWorldAndCategorySelectScreen extends StatelessWidget {
  HomeChannelWorldAndCategorySelectScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return HomeChannelWorldAndCategorySelectScreenScaffold(
      homeAppbarSection: _buildAppbar(),
      selectWorldSection: _buildWorldSelctor(),
      selectCategorySection: _buildCategorySelector(),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      leading: IconButton(
          icon: Image.asset('assets/images/ic_back_arrow.png'),
          onPressed: () => Get.offAll(() => HomeMainScreen())),
      title: Text(
        'World',
        style: AppTheme.appBarTextStyle,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Get.height * 0.02),
          child: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_bell.svg')),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_search.svg')),
        )
      ],
    );
  }

  Widget _buildWorldSelctor() {
    return Obx(
      () => Container(
        child: _homeController.isWorldSelected.value
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        height: Get.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: Get.height * 0.2,
                                child: Image.asset(
                                  'assets/images/img_world_base.png',
                                  fit: BoxFit.cover,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/images/ic_left_arrow_fill.svg')),
                                Text(
                                  'World',
                                  style: AppTheme.smallTitleTextStyle
                                      .copyWith(fontSize: 16),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/images/ic_right_arrow_fill.svg'))
                              ],
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 3,
                      child: Container(
                        height: Get.height * 0.16,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                    height: Get.height * 0.13,
                                    child: Image.asset(
                                      'assets/images/img_ko_circle.png',
                                      fit: BoxFit.cover,
                                    ))),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                          'assets/images/ic_left_arrow_fill.svg')),
                                  Text(
                                    'Korea',
                                    style: AppTheme.smallTitleTextStyle
                                        .copyWith(fontSize: 16),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                          'assets/images/ic_right_arrow_fill.svg'))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              )
            : Container(
                child: Center(
                    child: GestureDetector(
                        onTap: () {
                          _homeController.isWorldSelected.value = true;
                        },
                        child: Image.asset(
                          'assets/images/img_world_location.png',
                          fit: BoxFit.cover,
                        ))),
              ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    var list = _homeController.categories;
    list.remove('Total');
    print('========$list');
    var widgets = list
        .map((element) => categoryContainer(
            element.toUpperCase().replaceAll('MARKETING', "MKT")))
        .toList();
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: Get.width * 0.06,
      runSpacing: Get.height * 0.03,
      children: widgets,
    );
  }

  Container categoryContainer(String categoryName) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: Get.height * 0.1,
              child: Image.asset(
                'assets/images/img_main_logo.png',
                fit: BoxFit.cover,
              )),
          Text(
            categoryName.replaceAll('CELEB/', 'CELEB/\n'),
            textAlign: TextAlign.center,
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
