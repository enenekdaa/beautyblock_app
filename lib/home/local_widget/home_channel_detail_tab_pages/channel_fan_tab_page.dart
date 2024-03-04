import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils.dart';

class ChannelFanTabPage extends StatelessWidget {
  const ChannelFanTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildListView(),
        ),
      ],
    );
  }

  Widget _buildListView(){
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        myPageListTile('BRAND FAN RANKING',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        myPageListTile('브랜드 기여도 순위',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        myPageListTile('브랜드 홍보하기',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        Divider(
          color: Color.fromRGBO(171, 169, 163, 0.24),
        ),
        myPageListTile('내 활동 내역',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        myPageListTile('내 지갑 & FAN 코인',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        myPageListTile('브랜드 홈페이지 방문',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        myPageListTile('담당자 문의하기',
            SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
      ],
    );
  }
  ListTile myPageListTile(text, trailing, onPress) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: AppTheme.boldMyPageTextStyle,
      ),
      trailing: trailing,
      onTap: onPress,
    );
  }
}
