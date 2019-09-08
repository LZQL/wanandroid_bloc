import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class PublicState extends Equatable {
  PublicState([List props = const []]) : super(props);
}

/// 初始化 ，请求 公众号列表 数据
class InitPublicState extends PublicState {
  @override
  String toString() {
    return 'InitPublicState';
  }
}

/// 公众号列表  数据
class GetPublicState extends PublicState{

  final List<ItemModel> publicList;
  final int page;

  GetPublicState({this.publicList,this.page}) : super([publicList, page]);

  @override
  String toString() {
    return 'GetPublicState{projectList: $publicList, page: $page}';
  }


}


