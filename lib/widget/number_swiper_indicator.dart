import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 博文也 Banner 指示器

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 8.0, right: 5.0,bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Text("${++index} / $itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}