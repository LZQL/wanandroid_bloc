import 'package:equatable/equatable.dart';
import 'package:wanandroid_bloc/widget/zeking_pull_to_refresh/zeking_refresh.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

@immutable
abstract class SystemEvent extends Equatable {
  SystemEvent([List props = const []]) : super(props);
}

/// 获取 体系 数据
class GetSystemEvent extends SystemEvent {
  final int page;
  final ZekingRefreshController controller;
  final bool isRefresh;

  final List<ItemModel> systemList;
  final String id;

  GetSystemEvent(
      this.systemList, this.page, this.id, this.controller, this.isRefresh)
      : super([systemList, page, id, controller, isRefresh]);

  @override
  String toString() {
    return 'GetSystemEvent -> page:$page,id:$id';
  }
}
