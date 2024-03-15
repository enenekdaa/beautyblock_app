import 'dart:convert';

import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePolicyScreen extends StatefulWidget {
  final String type;
  const HomePolicyScreen({super.key, required this.type});

  @override
  State<HomePolicyScreen> createState() => _HomePolicyScreenState();
}

class _HomePolicyScreenState extends State<HomePolicyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWidget(appbarText: policyText(widget.type)),
        body: FutureBuilder<String>(
            future: loadPolicies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(snapshot.data ?? ''),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
                }
              }
              // 데이터 로딩 중...
              return Center(child: CircularProgressIndicator());
            }));
  }

  String policyText(String type) {
    if (type == 'privacy') {
      return "개인정보 취급 방침";
    } else if (type == 'terms') {
      return '서비스 이용약관';
    } else if (type == "marketing") {
      return '이벤트 및 정보 수신';
    } else {
      return "";
    }
  }

  Future<String> loadPolicies() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/policies/policy.json');
    return json.decode(jsonString)[widget.type];
  }
}
