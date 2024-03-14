import 'dart:io';

import 'package:beautyblock_app/auth/join/screen/join_app_description_screen.dart';
import 'package:beautyblock_app/auth/join/screen/join_certify_email_screen.dart';
import 'package:beautyblock_app/auth/join/screen/join_check_info_screen.dart';
import 'package:beautyblock_app/auth/join/screen/join_receive_customer_info_screen.dart';
import 'package:beautyblock_app/auth/join/screen/join_receive_email_screen.dart';
import 'package:beautyblock_app/auth/join/screen/join_receive_password_screen.dart';
import 'package:beautyblock_app/auth/join/screen/join_select_category_screen.dart';
import 'package:beautyblock_app/auth/login/login_screen.dart';
import 'package:beautyblock_app/home/screen/home_add_detail_info_screen.dart';
import 'package:beautyblock_app/home/screen/home_almost_done_screen.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/home/screen/home_channel_world_and_category_select_screen.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_favorites_channel_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_mychannel_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_myvideo_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_screen.dart';
import 'package:beautyblock_app/home/screen/home_post_share_screen.dart';
import 'package:beautyblock_app/home/screen/home_post_upload_screen.dart';
import 'package:beautyblock_app/home/screen/home_search_screen.dart';
import 'package:beautyblock_app/home/screen/home_select_country_screen.dart';
import 'package:beautyblock_app/home/screen/home_videoplayer_screen.dart';
import 'package:beautyblock_app/main_init_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/join/screen/join_main_screen.dart';
import 'auth/join/screen/join_terms_of_use_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCufbnh5CYD8ze_QDIUjNd1xUoSI5ASaBo",
            appId: "1:992094078368:ios:ac43638a641ef621c410c5",
            messagingSenderId: "992094078368",
            projectId: "beautyblock-412902",
            storageBucket: "beautyblock-412902.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlobalBeauty',
      initialRoute: "/loginMainScreen",
      // initialRoute:'/homeMain' ,
      initialBinding: InitBinding(),
      getPages: [
        GetPage(
            name: '/loginMainScreen',
            page: () => LoginScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/joinMainScreen',
            page: () => JoinMainScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/termsScreen',
            page: () => JoinTermsOfUseScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/receiveEmailScreen',
            page: () => JoinReceiveEmailScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/certifyScreen',
            page: () => JoinCertifyEmailScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/receivePasswordScreen',
            page: () => JoinReceivePasswordScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/receiveCustomerInfo',
            page: () => JoinReceiveCustomerInfoScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/selectCategory',
            page: () => JoinSelectCategoryScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/infoCheck',
            page: () => JoinCheckInfoScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/appDescription', page: () => JoinAppDescriptionScreen()),
        GetPage(
            name: '/homeMain',
            page: () => HomeMainScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/homeSearch',
            page: () => HomeSearchScreen(),
            binding: InitBinding()),
        // GetPage(name: '/homeAlarm', page: ()=>HomeAlarmPage(),binding: InitBinding()),
        GetPage(
            name: '/homeVideo',
            page: () => const HomeVideoplayerScreen(
                  id: null,
                ),
            binding: InitBinding()),
        GetPage(
            name: '/homeChannelDetail',
            page: () => HomeChannelDetailScreen(
                  id: null,
                ),
            binding: InitBinding()),
        GetPage(
            name: '/selectCountry',
            page: () => HomeSelectCountryScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/postUpload',
            page: () => HomePostUploadScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/postShare',
            page: () => HomePostShareScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/addDetailInfo',
            page: () => HomeAddDetailInfoScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/almostDone',
            page: () => HomeAlmostDoneScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/worldAndCategorySelect',
            page: () => HomeChannelWorldAndCategorySelectScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/myPage',
            page: () => HomeMyPageScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/myPageFavoritesChannel',
            page: () => HomeMyPageFavoritesChannelScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/myPageMyChannel',
            page: () => HomeMyPageMyChannelScreen(),
            binding: InitBinding()),
        GetPage(
            name: '/myPageMyVideo',
            page: () => HomeMyPageMyVideoScreen(),
            binding: InitBinding()),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
