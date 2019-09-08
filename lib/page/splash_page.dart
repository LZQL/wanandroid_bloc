//import 'package:pactera_platform/common/index_all.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/router/router.dart';
import 'package:wanandroid_bloc/utils/utils.dart';
import 'package:wanandroid_bloc/common/common.dart';
import 'package:flukit/flukit.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wanandroid_bloc/resources/resources.dart';

/// 欢迎页面

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _getSplashStatus();
  }

  void _getSplashStatus() async {
      _doCountDown();
  }

  /// 倒计时
  _doCountDown(){
    Observable.timer(0, Duration(seconds: 2)).listen((_){
      NavigatorUtils.goMainPage(context);
    });
  }

  /// 欢迎页面
  Widget _buildWelcome() {
    return new Image.asset(
      MyUtil.getImgPath('splash_bg'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildWelcome(),
      ),
    );
  }
}
