import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 下拉刷新数据 失败  widget
class ZekingRefreshFailWidget extends StatefulWidget {
  final ZekingRefreshController controller;
  final String message;

  ZekingRefreshFailWidget({this.controller, this.message});

  @override
  _ZekingRefreshFailWidgetState createState() =>
      _ZekingRefreshFailWidgetState();
}

class _ZekingRefreshFailWidgetState extends State<ZekingRefreshFailWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.controller.refreshingWithLoadingView,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                MyUtil.getImgPath('failure'),
                width: Dimens.size(273),
                height: Dimens.size(244),
              ),
              SizedBox(
                height: Dimens.size(72),
              ),
              Text(
                widget.message == null
                    ? IntlUtil.getString(context, Ids.load_failed_try_again)
                    : widget.message,
                style: TextStyles.size28color666666,
              )
            ],
          ),
        ),
      ),
    );

//      Center(
//      child: Container(
//          height: 60,
//          child: Text(
//            '加载失败，请点击重试',
//            style: TextStyle(color: ColorT.gray_66, fontSize: 14),
//          )),
//    );
  }
}
