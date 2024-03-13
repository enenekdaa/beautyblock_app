import 'package:beautyblock_app/constants/firestore_constants.dart';
import 'package:beautyblock_app/home/local_widget/list_item/home_review_listview_item.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../model/firebase_post_model.dart';
import '../../model/firebase_user_model.dart';
import '../local_widget/scaffold/home_videoplayer_screen_scaffold.dart';

class HomeVideoplayerScreen extends StatefulWidget {
  final String? id;
  const HomeVideoplayerScreen({super.key, required this.id});

  @override
  State<HomeVideoplayerScreen> createState() => _HomeVideoplayerScreenState();
}

class _HomeVideoplayerScreenState extends State<HomeVideoplayerScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  BeautyPost? post;

  bool loadComplete = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore
        .collection(FirestoreConstants.pathPostCollection)
        .doc(widget.id)
        .get()
        .then((value) {
      setState(() {
        post = BeautyPost.fromDocument(value);
        loadComplete = true;
      });
    });
    //볼때마다 카운트 증가
    _incrementViewCount(widget.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return HomeVideoplayerScreenScaffold(
        videoSection: _buildVideoPlayer(),
        videoDescriptionSection: _buildDescriptionSection(),
        reviewSection: _buildReviewListview(),
        searchSection: _buildSearchSection());
  }

  Widget _buildVideoPlayer() {
    return Container(
        height: Get.height * 0.3,
        child: loadComplete
            ? BeautyVideoPlayer(
                url: post?.video,
              )
            : Container(
                color: Colors.black,
              ));
  }

  Widget _buildDescriptionSection() {
    if (widget.id != null && loadComplete) {
      return Container(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header Title Text
                Text(
                  post?.title ?? '',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontSize: 18, height: 1.2),
                  softWrap: true,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ), //title
                Row(
                  children: [
                    SvgPicture.asset('assets/images/ic_eye.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      post!.viewCnt.toString(),
                      style: AppTheme.tagTextStyle,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Text(
                        '·',
                        style: AppTheme.tagTextStyle,
                      ),
                    ),
                    Text(
                      post!.createdAt.substring(0, 10),
                      style: AppTheme.tagTextStyle,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      post!.tags.map((e) => '#$e').join(' '),
                      style: AppTheme.tagTextStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
            future: firestore
                .collection(FirestoreConstants.pathUserCollection)
                .doc(post?.userId)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // 데이터 불러오기 성공
                if (snapshot.hasData) {
                  BeautyUser user = BeautyUser.fromDocument(snapshot.data!);
                  return Container(
                    padding: EdgeInsets.only(bottom: Get.height * 0.02),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    child: Column(
                      children: [
                        SubscriptionProfileWidget(
                          imageUrl: NetworkImage(user.profile),
                          userName: user.company,
                          subscriptionBtnOnPress: () {},
                          channelId: user.id,
                          useGoToChannelText: false,
                          useSubscriptionButton: true,
                          useLikeButton: false,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post?.contents ?? '',
                                  softWrap: true,
                                  style: AppTheme.smallTitleTextStyle),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              //bottom button
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.03),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/ic_text.svg'),
                                        Text(
                                          post!.commentCnt.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'NotoSans',
                                              fontSize: 12,
                                              height: 1.7,
                                              color: Color.fromRGBO(
                                                  151, 151, 151, 1)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.03),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/ic_heart.svg'),
                                        Text(
                                          post!.likes.length.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'NotoSans',
                                              fontSize: 12,
                                              height: 1.7,
                                              color: Color.fromRGBO(
                                                  151, 151, 151, 1)),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(right: Get.width * 0.06),
                                  //   child: Column(
                                  //     children: [
                                  //       SvgPicture.asset('assets/images/ic_share.svg'),
                                  //       Text(' ')
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/ic_declaration.svg'),
                                        Text(' ')
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  // 데이터 불러오기 실패
                  return Text("Error: ${snapshot.error}");
                }
              }
              // 데이터 불러오는 동안 표시할 위젯
              return CircularProgressIndicator();
            },
          ),
        ],
      ));
    } else {
      return Container();
    }
  }

  Widget _buildReviewListview() {
    return Column(
      // padding: EdgeInsets.zero,
      // scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        HomeReviewListviewItem(
            imageUrl: AssetImage('assets/images/img_test.png'),
            nickName: '홍길동',
            date: '2주전',
            reviewText: '계속합시다',
            reviewHeartCount: '123',
            reviewCount: '12',
            shareButtonOnPress: () {}),
        HomeReviewListviewItem(
            imageUrl: AssetImage('assets/images/img_test.png'),
            nickName: '홍길동',
            date: '2주전',
            reviewText: '계속합시다계속합시다계속합시다계속합시다계속합시다계속합시다계속합시다계속합시다',
            reviewHeartCount: '123',
            reviewCount: '12',
            shareButtonOnPress: () {}),
        HomeReviewListviewItem(
            imageUrl: AssetImage('assets/images/img_test.png'),
            nickName: '홍길동',
            date: '2주전',
            reviewText: '계속합시다',
            reviewHeartCount: '123',
            reviewCount: '12',
            shareButtonOnPress: () {}),
        HomeReviewListviewItem(
            imageUrl: AssetImage('assets/images/img_test.png'),
            nickName: '홍길동',
            date: '2주전',
            reviewText: '언제까지 될까요?',
            reviewHeartCount: '123',
            reviewCount: '12',
            shareButtonOnPress: () {}),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: Get.width * 0.04,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/img_test.png',
              ),
              radius: Get.height * 0.02, //서치 픽쳐
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                isDense: true,
                hintText: 'Type of message',
                // 힌트문자
                filled: true,
                fillColor: Color.fromRGBO(171, 169, 163, 0.12),
                contentPadding: EdgeInsets.only(
                    left: Get.width * 0.15, top: 15, bottom: 15),
                hintStyle: TextStyle(
                    color: Color.fromRGBO(174, 173, 170, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.6),
                enabledBorder: OutlineInputBorder(
                  // 기본 모양
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    // 포커스 되었을 경우 모양
                    borderSide: BorderSide.none),
                errorBorder: OutlineInputBorder(
                    // 에러 발생 시 모양
                    ),
                focusedErrorBorder: OutlineInputBorder(
                    // 에러 발생 후 포커스 되었을 경우 모양
                    )),
          ),
          Positioned(
              top: 0,
              bottom: 0,
              right: Get.width * 0.05,
              child: GestureDetector(
                  child: SvgPicture.asset('assets/images/ic_send.svg')))
        ],
      ),
    );
  }

  Future<void> _incrementViewCount(String postId) async {
    final DocumentReference postRef =
        firestore.collection(FirestoreConstants.pathPostCollection).doc(postId);

    // Firestore 트랜잭션을 사용하여 viewCnt 안전하게 증가
    return firestore
        .runTransaction<void>((Transaction transaction) async {
          DocumentSnapshot postSnapshot = await transaction.get(postRef);
          if (postSnapshot.exists) {
            int currentViewCount = postSnapshot.get('viewCnt') ?? 0;
            transaction.update(postRef, {'viewCnt': currentViewCount + 1});
          }
        })
        .then((value) => print("View count incremented"))
        .catchError((error) => print("Failed to increment view count: $error"));
  }
}

class BeautyVideoPlayer extends StatefulWidget {
  const BeautyVideoPlayer({super.key, required this.url});
  final String? url;
  @override
  State<BeautyVideoPlayer> createState() => _BeautyVideoPlayerState();
}

class _BeautyVideoPlayerState extends State<BeautyVideoPlayer> {
  late VideoPlayerController controller;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url ?? ''),
    );
    controller.initialize().then((_) => setState(() {
          isLoading = false;
        }));
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          color: Colors.grey.withOpacity(0.1),
        ),
        if (!isLoading)
          FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                  height: controller.value.size.height,
                  width: controller.value.size.width,
                  child: VideoPlayer(controller))),
        controlsOverlay(),
        VideoProgressIndicator(controller, allowScrubbing: true),
      ],
    );
  }

  Widget controlsOverlay() {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.topLeft,
                  child: const ColoredBox(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                        semanticLabel: 'Play',
                      ),
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
            setState(() {});
          },
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: PopupMenuButton<Duration>(
        //     initialValue: controller.value.captionOffset,
        //     tooltip: 'Caption Offset',
        //     onSelected: (Duration delay) {
        //       controller.setCaptionOffset(delay);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<Duration>>[
        //         for (final Duration offsetDuration in _exampleCaptionOffsets)
        //           PopupMenuItem<Duration>(
        //             value: offsetDuration,
        //             child: Text('${offsetDuration.inMilliseconds}ms'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
        //     ),
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (double speed) {
        //       controller.setPlaybackSpeed(speed);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<double>>[
        //         for (final double speed in _examplePlaybackRates)
        //           PopupMenuItem<double>(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
