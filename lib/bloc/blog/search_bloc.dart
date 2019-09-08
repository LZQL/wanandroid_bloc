import 'package:wanandroid_bloc/common/index_all.dart';

class SearchBloc extends Bloc<SearchBaseEvent, SearchBaseState> {
  @override
  SearchBaseState get initialState => InitSearchState();

  @override
  Stream<SearchBaseState> mapEventToState(SearchBaseEvent event) async* {
    try {

      if (event is SearchEvent) {
        List<ItemModel> originalList = event.searchList;
        List<ItemModel> resultList = new List();
        int page = 0;

        if (event.isRefresh) {
          /// 如果是刷新 ，
          page = 0;
        } else {
          page = event.page + 1;
        }
        try {
          BaseRefreshModel blogModel =
              await HttpRequestFactory.search(page: page,k:event.k);

          List<ItemModel> list = blogModel.datas.map((value) {
            return ItemModel.fromJson(value);
          }).toList();

          if (event.isRefresh) {
            // 下拉刷新
            if (list.isEmpty) {
              event.controller.refreshEmpty();
            } else {
              resultList.addAll(list);
              event.controller.refreshSuccess();

              if (blogModel.pageCount == blogModel.curPage) {
                event.controller.loadMoreNoMore();
              }
            }
          } else {
            // 加载更多
            resultList.addAll(originalList);
            resultList.addAll(list);
            event.controller.loadMoreSuccess();

            if (blogModel.pageCount == blogModel.curPage) {
              event.controller.loadMoreNoMore();
            }
          }
        } catch (e) {
          resultList.addAll(event.searchList);
          if (event.isRefresh) {
            event.controller.refreshFaild();
          } else {
            page--;
            event.controller.loadMoreFailed();
          }
        }

        yield SearchState(searchList: resultList, page: page);
      }
    } catch (_) {
      if (event is SearchEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
