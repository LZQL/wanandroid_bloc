import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

@immutable
abstract class PublicEvent extends Equatable {
  PublicEvent([List props = const []]) : super(props);
}

/// 获取 公众号 数据
class GetPublicEvent extends PublicEvent {
  final int page;
  final ZekingRefreshController controller;
  final bool isRefresh;

  final List<ItemModel> projectList;
  final int id;

  GetPublicEvent(
      this.projectList, this.page, this.id, this.controller, this.isRefresh)
      : super([projectList, page, id, controller, isRefresh]);

  @override
  String toString() {
    return 'GetPublicEvent -> page:$page,id:$id';
  }
}
