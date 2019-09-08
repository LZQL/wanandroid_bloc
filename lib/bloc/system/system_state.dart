import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class SystemState extends Equatable {
  SystemState([List props = const []]) : super(props);
}

/// 初始化 ，请求 体系 下文章 列表 数据
class InitSystemState extends SystemState {
  @override
  String toString() {
    return 'InitSystemState';
  }
}

/// 体系列表  数据
class GetSystemState extends SystemState{

  final List<ItemModel> systemList;
  final int page;

  GetSystemState({this.systemList,this.page}) : super([systemList, page]);

  @override
  String toString() {
    return 'GetSystemState{systemList: $systemList, page: $page}';
  }


}


