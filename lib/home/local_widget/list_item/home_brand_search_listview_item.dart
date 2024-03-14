import 'package:beautyblock_app/home/screen/home_videoplayer_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../model/firebase_post_model.dart';

Widget homeBrandSearchListViewItem({
  required BeautyPost post,
}) {
  return GestureDetector(
    onTap: () {
      Get.to(() => HomeVideoplayerScreen(id: post.id));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      height: Get.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(post.title,
              style: AppTheme.smallTitleTextStyle.copyWith(
                fontSize: 16,
              )),
          Stack(
            children: [
              // ImageUrl    //todo image connect
              Column(
                children: [
                  Expanded(
                    child: Container(
                        width: 116,
                        height: 66,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            post.thumbnail,
                            fit: BoxFit.cover,
                          ),
                        )),
                  )
                ],
              ),

              Positioned(
                child: Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    'assets/images/ic_play.svg',
                  ),
                ),
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
              )
            ],
          )
        ],
      ),
    ),
  );
}
