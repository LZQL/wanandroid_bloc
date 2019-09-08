import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class SystemClassifyState extends Equatable {
  SystemClassifyState([List props = const []]) : super(props);
}

/// 初始化 ，请求 体系 分类 数据
class InitSystemClassifyState extends SystemClassifyState {
  @override
  String toString() {
    return 'InitSystemClassifyState';
  }
}

/// 体系分类  数据
class GetSystemClassifyState extends SystemClassifyState{

  final List<SystemTabModel> systemClassifyList;

  GetSystemClassifyState({this.systemClassifyList}) : super([systemClassifyList]);

  @override
  String toString() {
    return 'GetSystemClassifyState';
//    return 'GetProjectClassifyState{projectClassifyList: $projectClassifyList}';
  }


}


