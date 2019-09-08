
import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class SystemClassifyEvent extends Equatable {
  SystemClassifyEvent([List props = const []]) : super(props);
}

/// 获取 体系 分类 数据
class GetSystemClassifyEvent extends SystemClassifyEvent {

  final ZekingRefreshController controller;

  GetSystemClassifyEvent(this.controller,) : super([controller]);

  @override
  String toString() {
    return 'GetSystemClassifyEvent';
  }
}