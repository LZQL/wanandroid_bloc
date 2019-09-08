import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class ProjectClassifyState extends Equatable {
  ProjectClassifyState([List props = const []]) : super(props);
}

/// 初始化 ，请求 项目分类 数据
class InitProjectClassifyState extends ProjectClassifyState {
  @override
  String toString() {
    return 'InitProjectClassifyState';
  }
}

/// 项目分类  数据
class GetProjectClassifyState extends ProjectClassifyState{

  final List<TagModel> projectClassifyList;

  GetProjectClassifyState({this.projectClassifyList}) : super([projectClassifyList]);

  @override
  String toString() {
    return 'GetProjectClassifyState';
//    return 'GetProjectClassifyState{projectClassifyList: $projectClassifyList}';
  }


}


