import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 加载中 动画 控件

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with TickerProviderStateMixin {
  AnimationController controller; //动画控制器
  CurvedAnimation curved;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    curved = new CurvedAnimation(parent: controller, curve: Curves.linear);

//    controller.addStatusListener((status){
//      print(status);
//    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: RotationTransition(
        //旋转动画
        turns: curved,
        child: Image.asset(
          MyUtil.getImgPath('common_loading'),
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
