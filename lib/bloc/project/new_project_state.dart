import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class NewProjectState extends Equatable {
  NewProjectState([List props = const []]) : super(props);
}

/// 初始化 ，请求 最新项目列表 数据
class InitNewProjectState extends NewProjectState {
  @override
  String toString() {
    return 'InitNewProjectState';
  }
}

/// 最新项目列表  数据
class GetNewProjectState extends NewProjectState{

  final List<ItemModel> newProjectList;
  final int page;

  GetNewProjectState({this.newProjectList,this.page}) : super([newProjectList, page]);
//
//  GetNewProjectState copyWith({
//    List<ProjectModel> newProjectList,
//    int page,
//  }) {
//    return GetNewProjectState(
//      newProjectList: newProjectList ?? this.newProjectList,
//      page: page ?? this.page,
//    );
//  }

  @override
  String toString() {
    return 'GetNewProjectState{blogList: $newProjectList, page: $page}';
  }


}


