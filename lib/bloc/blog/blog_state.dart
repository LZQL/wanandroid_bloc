import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class BlogState extends Equatable {
  BlogState([List props = const []]) : super(props);
}

/// 初始化 ，请求  Banner 和 CompanyTask 数据
class InitState extends BlogState {
  @override
  String toString() {
    return 'InitTaskSquareState';
  }
}

/// Banner
class BannerState extends BlogState {
  final List<BannerModel> bannerList;

  BannerState(this.bannerList);

  @override
  String toString() {
    return 'TaskSquareBannerState{bannerList: $bannerList}';
  }
}

/// 公司任务  数据
class CompanyTaskState extends BlogState{

  final List<ItemModel> blogList;
  final int page;

  CompanyTaskState({this.blogList,this.page}) : super([blogList, page]);

//  CompanyTaskTaskSquareState copyWith({
//    List<BlogModel> blogList,
//    int page,
//  }) {
//    return CompanyTaskTaskSquareState(
//      blogList: blogList ?? this.blogList,
//      page: page ?? this.page,
//    );
//  }

  @override
  String toString() {
    return 'CompanyTaskTaskSquareState{blogList: $blogList, page: $page}';
  }


}


