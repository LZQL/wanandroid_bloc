import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class PublicClassifyState extends Equatable {
  PublicClassifyState([List props = const []]) : super(props);
}

/// 初始化 ，请求 公众号分类 数据
class InitPublicClassifyState extends PublicClassifyState {
  @override
  String toString() {
    return 'InitProjectClassifyState';
  }
}

/// 公众号分类  数据
class GetPublicClassifyState extends PublicClassifyState{

  final List<TagModel> publicClassifyList;

  GetPublicClassifyState({this.publicClassifyList}) : super([publicClassifyList]);

  @override
  String toString() {
    return 'GetPublicClassifyState';
//    return 'GetProjectClassifyState{projectClassifyList: $projectClassifyList}';
  }


}


