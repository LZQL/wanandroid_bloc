import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class ProjectState extends Equatable {
  ProjectState([List props = const []]) : super(props);
}

/// 初始化 ，请求 项目列表 数据
class InitProjectState extends ProjectState {
  @override
  String toString() {
    return 'InitProjectState';
  }
}

/// 项目列表  数据
class GetProjectState extends ProjectState{

  final List<ItemModel> projectList;
  final int page;

  GetProjectState({this.projectList,this.page}) : super([projectList, page]);

  @override
  String toString() {
    return 'GetProjectState{projectList: $projectList, page: $page}';
  }


}


