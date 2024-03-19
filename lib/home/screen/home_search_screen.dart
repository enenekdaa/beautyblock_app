import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/list_item/home_brand_search_listview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../local_widget/scaffold/home_search_screen_scaffold.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreen();
}

class _HomeSearchScreen extends State<HomeSearchScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    HomeController.to.searchController.clear();
    HomeController.to.clearSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return HomeSearchScreenScaffold(
        AppbarSection: _buildAppbar(),
        bodySection: _buildListview(),
      );
    });
  }

  Widget _buildAppbar() {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
          icon: Image.asset('assets/images/ic_back_arrow.png'),
          onPressed: () {
            Get.back();
          }),
      title: Row(children: [
        Flexible(
          fit: FlexFit.tight,
          child: TextFormField(
            controller: HomeController.to.searchController,
            onFieldSubmitted: (value) {
              HomeController.to.updateSearchQuery();
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Beauty Block Search',
              filled: true,
              fillColor: Color.fromRGBO(171, 169, 163, 0.12),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              hintStyle: TextStyle(
                  color: Color.fromRGBO(174, 173, 170, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.6),
              enabledBorder: OutlineInputBorder(
                // 기본 모양
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ]),
      actions: [
        GestureDetector(
          child: Container(
              width: Get.width * 0.15,
              child: SvgPicture.asset('assets/images/ic_search.svg')),
          onTap: () {
            HomeController.to.updateSearchQuery();
            print(
                'search Query ========== ${HomeController.to.searchController.text}');
          },
        )
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
              decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 4), // 그림자의 방향과 거리
            ),
          ]))),
    );
  }

  Widget _buildListview() {
    return HomeController.to.searchedList.isEmpty
        ? Center(
            child: Text(
              'No results were found',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: HomeController.to.searchedList.length,
            itemBuilder: (context, index) {
              return homeBrandSearchListViewItem(
                post: HomeController.to.searchedList[index],
              );
            },
          );
  }
}
