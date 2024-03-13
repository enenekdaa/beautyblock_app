import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/constants/firestore_constants.dart';
import 'package:beautyblock_app/home/local_widget/list_item/home_review_listview_item.dart';
import 'package:beautyblock_app/model/firebase_reply_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController reply = TextEditingController();
  BeautyPost? post;
  List<BeautyReply> replies = [];
  bool loadComplete = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData();
    //볼때마다 카운트 증가
    _incrementViewCount(widget.id ?? '');
  }

  updateData() {
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
    firestore
        .collection(FirestoreConstants.pathPostCollection)
        .doc(widget.id)
        .collection(FirestoreConstants.pathRepliesCollection)
        .orderBy('createdAt', descending: true) // 댓글을 최신 순으로 정렬
        .get()
        .then((value) {
      List<BeautyReply> tmp = [];
      for (DocumentSnapshot doc in value.docs) {
        tmp.add(BeautyReply.fromDocument(doc));
      }
      setState(() {
        replies = tmp;
        loadComplete = true;
      });
    });
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
    if (widget.id != null && loadComplete) {
      return Column(
        // padding: EdgeInsets.zero,
        // scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          replies.isNotEmpty
              ? Column(
                  children: replies
                      .map(
                        (reply) => HomeReviewListviewItem(
                            postId: widget.id,
                            id: reply.id,
                            imageUrl: NetworkImage(reply.profile),
                            nickName: reply.nickName,
                            date: reply.createdAt.substring(0, 10),
                            reviewText: reply.content,
                            reviewHeartCount: reply.likes.length.toString(),
                            reviewCount: '0',
                            shareButtonOnPress: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  // isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0,
                                            12,
                                            0,
                                            MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom +
                                                12),
                                        color: Colors.transparent,
                                        child: SingleChildScrollView(
                                            child: Column(
                                          children: ['삭제']
                                              .map((e) => GestureDetector(
                                                    onTap: () {
                                                      deleteReply(reply.id);
                                                      Get.back();
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          12.0,
                                                                      horizontal:
                                                                          20),
                                                              child: Text(e,
                                                                  style: AppTheme
                                                                      .smallTitleTextStyle),
                                                            ),
                                                            Container(
                                                                width:
                                                                    Get.width,
                                                                height: 2,
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    240,
                                                                    240,
                                                                    240,
                                                                    1))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                              .toList(),
                                        )));
                                  });
                            }),
                      )
                      .toList(),
                )
              : Text(
                  '등록된 댓글이 없습니다',
                  textAlign: TextAlign.center,
                ),
          SizedBox(
            height: 100,
          ),
        ],
      );
    } else {
      return Container();
    }
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
              backgroundImage: NetworkImage(
                LoginController.to.getProfile(),
              ),
              radius: Get.height * 0.02, //서치 픽쳐
            ),
          ),
          TextFormField(
            controller: reply,
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
                  onTap: () {
                    addReply();
                  },
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

  Future<void> addReply() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference postRef = firestore
        .collection(FirestoreConstants.pathPostCollection)
        .doc(widget.id);

    BeautyReply replyData = BeautyReply(
        id: '',
        userId: LoginController.to.getId(),
        profile: LoginController.to.getProfile(),
        nickName: LoginController.to.getNick(),
        createdAt: DateTime.now().toString(),
        content: reply.text,
        likes: []);

    DocumentReference doc =
        await postRef.collection('replies').add(replyData.toJson());
    await doc.update({'id': doc.id});
    reply.clear();
    updateData();
    showSaveSuccessDialog();
  }

  Future<void> deleteReply(String replyId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection(FirestoreConstants.pathPostCollection)
        .doc(widget.id)
        .collection('replies')
        .doc(replyId)
        .delete();
    updateData();
  }

  void showSaveSuccessDialog() {
    customDialog(
        '답글 작성 완료',
        Text(
          '답글이 성공적으로 등록되었습니다.',
          textAlign: TextAlign.center,
        ), () {
      FocusScope.of(context).unfocus();
      navigator?.pop(Get.context);
    }, '닫기');
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
