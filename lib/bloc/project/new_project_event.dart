
import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class NewProjectEvent  {
}

/// 获取 最新项目 数据
class GetNewProjectEvent extends NewProjectEvent {

  final int page;
  final ZekingRefreshController controller;
  final bool isRefresh ;
  final List<ItemModel> newProjectList;
//  final bool isFirstLoad;

  GetNewProjectEvent(this.newProjectList,this.page,this.controller,this.isRefresh) ;

  @override
  String toString() {
    return 'GetNewProjectEvent -> $page';
  }
}