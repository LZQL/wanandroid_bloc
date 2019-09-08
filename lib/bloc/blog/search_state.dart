import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class SearchBaseState  {
}

class InitSearchState extends SearchBaseState {
  @override
  String toString() {
    return 'InitSearchState';
  }
}

class SearchState extends SearchBaseState {
  final List<ItemModel> searchList;
  final int page;

  SearchState({this.searchList,this.page});

  @override
  String toString() {
    return 'SearchState{searchList: $searchList}';
  }
}



