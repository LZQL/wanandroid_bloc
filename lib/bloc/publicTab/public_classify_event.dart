
import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class PublicClassifyEvent extends Equatable {
  PublicClassifyEvent([List props = const []]) : super(props);
}

/// 获取 公众号分类 数据
class GetPublicClassifyEvent extends PublicClassifyEvent {

  final ZekingRefreshController controller;

  GetPublicClassifyEvent(this.controller,) : super([controller]);

  @override
  String toString() {
    return 'GetPublicClassifyEvent';
  }
}