
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class CollectBaseEvent extends Equatable {
  CollectBaseEvent([List props = const []]) : super(props);
}

/// 获取 收藏列表 数据
class GetCollectListEvent extends CollectBaseEvent {

  final int page;
  final ZekingRefreshController controller;
  final bool isRefresh ;
  final List<ItemModel> collectList;

  GetCollectListEvent(this.collectList,this.page,this.controller,this.isRefresh) : super([page,controller,isRefresh]);

  @override
  String toString() {
    return 'GetCollectListEvent -> $page';
  }
}

class CollectEvent extends CollectBaseEvent {

  final int id;

  CollectEvent(this.id) : super([id]);

  @override
  String toString() {
    return 'CollectEvent -> $id';
  }
}

class CancelCollectEvent extends CollectBaseEvent {

  final int id;

  CancelCollectEvent(this.id) : super([id]);

  @override
  String toString() {
    return 'CancelCollectEvent -> $id';
  }
}