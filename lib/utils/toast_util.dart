import 'package:flutter/widgets.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

class ToastUtil{
  static showShort(String msg, BuildContext context){
    Toast.show(msg, context,duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  static showLong(String msg, BuildContext context){
    Toast.show(msg, context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}