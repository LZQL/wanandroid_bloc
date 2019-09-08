import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class CollectBaseState  {
}

class InitCollectState extends CollectBaseState {
  @override
  String toString() {
    return 'InitCollectState';
  }
}

/// 最新项目列表  数据
class GetCollectListState extends CollectBaseState {
  final List<ItemModel> collectList;
  final int page;

  GetCollectListState({this.collectList, this.page});

  @override
  String toString() {
    return 'GetCollectListState{collectList: $collectList, page: $page}';
  }
}

class CollectSuccessState extends CollectBaseState {

  final int id;


  CollectSuccessState(this.id);

  @override
  String toString() {
    return 'CollectSuccessState{$id}';
  }
}

class CollectFailedState extends CollectBaseState {

  final String errorMsg;

  CollectFailedState(this.errorMsg);

  @override
  String toString() {
    return 'CollectFailedState';
  }
}

class CancelCollectSuccessState extends CollectBaseState {
  final int id;


  CancelCollectSuccessState(this.id);

  @override
  String toString() {
    return 'CancelCollectSuccessState{$id}';
  }
}

class CancelCollectFailedState extends CollectBaseState {

  final String errorMsg;

  CancelCollectFailedState(this.errorMsg);

  @override
  String toString() {
    return 'CancelCollectFailedState';
  }
}
