import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 下拉刷新 成功  但是  无数据 页面
class ZekingRefreshEmptyWidget extends StatefulWidget {
  final ZekingRefreshController controller;
  final String message;

  ZekingRefreshEmptyWidget({this.controller, this.message});

  @override
  _ZekingRefreshEmptyWidgetState createState() =>
      _ZekingRefreshEmptyWidgetState();
}

class _ZekingRefreshEmptyWidgetState
    extends State<ZekingRefreshEmptyWidget> {
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
                MyUtil.getImgPath('empty'),
                width: Dimens.size(273),
                height: Dimens.size(244),
              ),
              SizedBox(
                height: Dimens.size(72),
              ),
              Text(
                widget.message == null
                    ? IntlUtil.getString(context, Ids.no_data_try_again)
                    : widget.message,
                style: TextStyles.size28color666666,
              )
            ],
          ),
        ),
      ),
    );
  }
}
