import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeBrandSearchListViewItem extends StatelessWidget {
  const HomeBrandSearchListViewItem({
    Key? key,
    required this.text,
    // required this.imageUrl,
  });

  final text;

  // final imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      height: Get.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text,
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
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/img_test_video_thumbnail.png',
                            fit: BoxFit.cover,
                          ),
                      )
                    ),
                  )
                ],
              ),

              Positioned(
                child: Container(
                  decoration: BoxDecoration(

                  ),
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
    );
  }
}
