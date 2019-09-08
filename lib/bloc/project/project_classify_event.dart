
import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class ProjectClassifyEvent extends Equatable {
  ProjectClassifyEvent([List props = const []]) : super(props);
}

/// 获取 项目分类 数据
class GetProjectClassifyEvent extends ProjectClassifyEvent {

  final ZekingRefreshController controller;

  GetProjectClassifyEvent(this.controller,) : super([controller]);

  @override
  String toString() {
    return 'GetProjectClassifyEvent';
  }
}