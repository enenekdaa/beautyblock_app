import 'package:beautyblock_app/home/local_widget/list_item/home_review_listview_item.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../local_widget/scaffold/home_videoplayer_screen_scaffold.dart';

class HomeVideoplayerScreen extends StatelessWidget {
  const HomeVideoplayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeVideoplayerScreenScaffold(
        videoSection: _buildVideoPlayer(context),
        videoDescriptionSection: _buildDescriptionSection(),
        reviewSection: _buildReviewListview(),
        searchSection: _buildSearchSection());
  }

  Widget _buildVideoPlayer(context) {
    return Container(
      color: Colors.red,
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 12),
          child: Column(
            children: [
              //header Title Text
              Text(
                'Beauty Block Launching Festival - Heize & Dean',
                style: AppTheme.smallTitleTextStyle
                    .copyWith(fontSize: 18, height: 1.2),
                softWrap: true,
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
                    '2.5k',
                    style: AppTheme.tagTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    child: Text(
                      '·',
                      style: AppTheme.tagTextStyle,
                    ),
                  ),
                  Text(
                    '3개월전',
                    style: AppTheme.tagTextStyle,
                  ),
                  Text(
                    '#뷰티블록  #뷰티  #페스티발',
                    style: AppTheme.tagTextStyle,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: Get.height * 0.02),
          color: Color.fromRGBO(246, 246, 246, 1),
          child: Column(
            children: [
              SubscriptionProfileWidget(
                imageUrl: AssetImage('assets/images/img_test.png'),
                userName: 'Beauty Block',
                subscriptionBtnOnPress: () {},
                isSubscription: false,
                useGoToChannelText: false,
                useSubscriptionButton: false,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                        '안녕하세요 뷰티블록입니다.이번 런칭 페스티발에 참여해주신 모든 분들게 감사드리고 감사한 마음을 담아 영상을 만들게 되었습니다. 잘 부탁드리겠습니다. 감사합니다.',
                        softWrap: true,
                        style: AppTheme.smallTitleTextStyle),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    //bottom button
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.03),
                          child: Column(
                            children: [
                              SvgPicture.asset('assets/images/ic_text.svg'),
                              Text(
                                '24,415',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'NotoSans',
                                    fontSize: 12,
                                    height: 1.7,
                                    color: Color.fromRGBO(151, 151, 151, 1)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.03),
                          child: Column(
                            children: [
                              SvgPicture.asset('assets/images/ic_heart.svg'),
                              Text(
                                '24,415',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'NotoSans',
                                    fontSize: 12,
                                    height: 1.7,
                                    color: Color.fromRGBO(151, 151, 151, 1)),
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
                          padding: EdgeInsets.only(right: Get.width * 0.02),
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
        )
      ],
    ));
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
}
