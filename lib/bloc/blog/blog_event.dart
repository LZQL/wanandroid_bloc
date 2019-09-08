
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class BlogEvent  {
}

/// 获取Banner 数据
class BannerEvent extends BlogEvent {


  BannerEvent() : super();

  @override
  String toString() {
    return 'BannerTaskSquare';
  }
}

/// 获取 博文 数据
class CompanyTaskEvent extends BlogEvent {


  final int page;
  final ZekingRefreshController controller;
  final bool isRefresh ;
  final List<ItemModel> companyTaskList;
//  final bool isFirstLoad;

  CompanyTaskEvent(this.companyTaskList,this.page,this.controller,this.isRefresh) ;

  @override
  String toString() {
    return 'ItemTaskSquareEvent -> $page';
  }
}