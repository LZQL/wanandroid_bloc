
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';
import 'package:wanandroid_bloc/common/index_all.dart';


@immutable
abstract class SearchBaseEvent  {
}

class SearchEvent extends SearchBaseEvent {

  final int page;
  final String k;
  final ZekingRefreshController controller;
  final bool isRefresh ;
  final List<ItemModel> searchList;

  SearchEvent({this.page,this.k,this.controller,this.isRefresh,this.searchList}) ;

  @override
  String toString() {
    return 'SearchEvent';
  }
}

