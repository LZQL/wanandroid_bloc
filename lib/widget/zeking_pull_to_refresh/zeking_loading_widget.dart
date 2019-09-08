import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 加载更多  加载中 widget
class ZekingLoadingWidget extends StatefulWidget {
  final String message;

  ZekingLoadingWidget({this.message});

  @override
  _ZekingLoadingWidgetState createState() => _ZekingLoadingWidgetState();
}

class _ZekingLoadingWidgetState extends State<ZekingLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimens.size(120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
//                valueColor: AlwaysStoppedAnimation(ColorT.gray_66),
              ),
            ),
            Container(
              width: 15,
            ),
            Text(
              widget.message == null
                  ? IntlUtil.getString(context, Ids.more_data_is_loading)
                  : widget.message,
              style: TextStyle(color: ColorT.gray_66, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
