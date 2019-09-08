import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 加载更多   已加载全部数据 widget
class ZekingLoadNoMoreWidget extends StatefulWidget {
  final String message;

  ZekingLoadNoMoreWidget({this.message});

  @override
  _ZekingLoadNoMoreWidgetState createState() => _ZekingLoadNoMoreWidgetState();
}

class _ZekingLoadNoMoreWidgetState extends State<ZekingLoadNoMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.size(120),
      child: Center(
        child: Text(
          widget.message == null
              ? IntlUtil.getString(context, Ids.all_data_has_been_loaded)
              : widget.message,
          style: TextStyle(color: ColorT.gray_66, fontSize: 14),
        ),
      ),
    );
  }
}
