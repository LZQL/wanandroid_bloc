//import 'package:flutter/material.dart';
//import 'package:wanandroid_bloc/common/index_all.dart';
//
///// 加载更多，失败 widget
//class ZekingLoadFailWidget extends StatefulWidget {
//  final ZekingRefreshController controller;
//  final String message;
//
//  ZekingLoadFailWidget({this.controller, this.message});
//
//  @override
//  _ZekingLoadFailWidgetState createState() => _ZekingLoadFailWidgetState();
//}
//
//class _ZekingLoadFailWidgetState extends State<ZekingLoadFailWidget> {
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: widget.controller.requestLoading,
//      child: Container(
//        height: Dimens.size(120),
//        color: Colors.transparent,
//        child: Container(
//          alignment: Alignment.center,
//          color: Colors.transparent,
//          child: Center(
//            child: Text(
//              widget.message == null
//                  ? IntlUtil.getString(
//                      context, Ids.failed_to_load_please_click_retry)
//                  : widget.message,
//              style: TextStyles.size28color666666,
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
