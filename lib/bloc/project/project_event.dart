import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

@immutable
abstract class ProjectEvent extends Equatable {
  ProjectEvent([List props = const []]) : super(props);
}

/// 获取 项目 数据
class GetProjectEvent extends ProjectEvent {
  final int page;
  final ZekingRefreshController controller;
  final bool isRefresh;

  final List<ItemModel> projectList;
  final int cid;

  GetProjectEvent(
      this.projectList, this.page, this.cid, this.controller, this.isRefresh)
      : super([projectList, page, cid, controller, isRefresh]);

  @override
  String toString() {
    return 'GetProjectEvent -> page:$page,cid:$cid';
  }
}
