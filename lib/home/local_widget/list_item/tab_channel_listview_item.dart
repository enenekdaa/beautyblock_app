import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/home/screen/home_videoplayer_screen.dart';
import 'package:beautyblock_app/model/firebase_post_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/firestore_constants.dart';
import '../../../model/firebase_user_model.dart';

class TabChannelListviewItem extends StatelessWidget {
  TabChannelListviewItem({Key? key, required this.channel}) : super(key: key);

  BeautyUser channel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeChannelDetailScreen(id: channel.id));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
              child: Row(
                children: [
                  _buildLeftImageSection(),
                  _buildMiddleSection(),
                  // _buildRightShareSection(),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Color.fromRGBO(239, 239, 239, 1),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLeftImageSection() {
    return Container(
      padding: EdgeInsets.only(right: Get.width * 0.03),
      height: Get.height * 0.05, // 가능한 최대 너비
      child: AspectRatio(
        aspectRatio: 1 / 1, // 가로 세로 비율을 1:1로 설정
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover,

                // 이미지가 컨테이너를 꽉 채우도록
                image: NetworkImage(channel.profile)), // 여기에 이미지 URL을 넣으세요.
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            channel.nickName,
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              FutureBuilder(
                  future: followCount(channel.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('Follow : ${snapshot.data.toString()}',
                          style: AppTheme.tagTextStyle);
                    } else {
                      return const Text('Follow : 0',
                          style: AppTheme.tagTextStyle);
                    }
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Text(
                  '·',
                  style: AppTheme.tagTextStyle,
                ),
              ),
              FutureBuilder(
                  future: contentCount(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('Content : ${snapshot.data.toString()}',
                          style: AppTheme.tagTextStyle);
                    } else {
                      return const Text('Content : 0',
                          style: AppTheme.tagTextStyle);
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightShareSection() {
    return Row(
      children: [
        GestureDetector(
          child: SvgPicture.asset('assets/images/ic_heart2.svg'),
        ),
        Padding(
          padding: EdgeInsets.only(left: Get.height * 0.03),
          child: GestureDetector(
            child: SvgPicture.asset('assets/images/ic_share3.svg'),
          ),
        ),
      ],
    );
  }

  Future<int> contentCount() async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(FirestoreConstants.pathPostCollection)
        .where('userId', isEqualTo: channel.id)
        // .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.length;
  }
}
