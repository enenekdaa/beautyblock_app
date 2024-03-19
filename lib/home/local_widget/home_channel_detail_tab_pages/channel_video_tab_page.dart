import 'dart:math';

import 'package:beautyblock_app/constants/firestore_constants.dart';
import 'package:beautyblock_app/home/local_widget/list_item/tab_home_listview_item.dart';
import 'package:beautyblock_app/home/local_widget/list_item/channel_detail_video_tab_listview_item.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/firebase_post_model.dart';

class ChannelVideoTabPage extends StatelessWidget {
  final String id;
  const ChannelVideoTabPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BeautyPost>>(
        future: getPostData(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BeautyPost> posts = snapshot.data ?? [];
            Random random = Random();
            if (posts.isEmpty) {
              return Center(
                child: Text('No registered content'),
              );
            } else {
              BeautyPost rand = posts[random.nextInt(posts.length)];
              return ListView(
                children: [
                  _buildRecommandSection(rand),
                  _buildPopularityVideoSection(posts),
                ],
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildRecommandSection(BeautyPost item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore',
          style:
              AppTheme.smallTitleTextStyle.copyWith(fontSize: 18, height: 1.2),
        ),

        ///TODO: 데이터 연동
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
          child: TabHomeListviewItem(
            thumbnail: item.thumbnail,
            id: item.id,
            duration: item.videoLength,
            videoTitle: item.title,
            views: item.viewCnt.toString(),
            date: formatDateString(item.createdAt),
            tags: item.tags,
          ),
        ),
      ],
    );
  }

  Widget _buildPopularityVideoSection(List<BeautyPost> posts) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Popular',
              style: AppTheme.smallTitleTextStyle
                  .copyWith(fontSize: 18, height: 1.2),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.01),
              child: Column(
                children: posts
                    .map(
                      (e) => ChannelDetailVideoTabListviewItem(
                          id: e.id,
                          thumbnail: e.thumbnail,
                          videoText: e.title,
                          followCount: e.likes.length.toString(),
                          contentCount: e.commentCnt.toString()),
                    )
                    .toList(),
              ),
            ),
          ]),
    );
  }

  Future<List<BeautyPost>> getPostData(id) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection(FirestoreConstants.pathPostCollection)
        .where('userId', isEqualTo: id)
        .get();
    List<BeautyPost> list = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      list.add(BeautyPost.fromDocument(doc));
    }
    return list;
  }
}
