import 'package:wanandroid_bloc/common/index_all.dart';

class PublicBloc extends Bloc<PublicEvent, PublicState> {
  @override
  PublicState get initialState => InitPublicState();

  @override
  Stream<PublicState> mapEventToState(PublicEvent event) async* {
    try {
      /// 获取 公众号 数据
      if (event is GetPublicEvent) {
        List<ItemModel> originalList = event.projectList;
        List<ItemModel> resultList = new List();
        int page = 0;

        if (event.isRefresh) {
          /// 如果是刷新 ，
          page = 0;
        } else {
          page = event.page + 1;
        }
        try {
          BaseRefreshModel publicModel = await HttpRequestFactory.getPublicList(
              page: page, id: event.id);

          List<ItemModel> list = publicModel.datas.map((value) {
            return ItemModel.fromJson(value);
          }).toList();

          if (event.isRefresh) {
            // 下拉刷新
            if (list.isEmpty) {
              event.controller.refreshEmpty();
            } else {
              resultList.addAll(list);
              event.controller.refreshSuccess();

              if (publicModel.pageCount == publicModel.curPage) {
                event.controller.loadMoreNoMore();
              }
            }
          } else {
            // 加载更多
            resultList.addAll(originalList);
            resultList.addAll(list);
            event.controller.loadMoreSuccess();

            if (publicModel.pageCount == publicModel.curPage) {
              event.controller.loadMoreNoMore();
            }
          }
        } catch (e) {
          resultList.addAll(event.projectList);
          if (event.isRefresh) {
            event.controller.refreshFaild();
          } else {
            page--;
            event.controller.loadMoreFailed();
          }
        }

        yield GetPublicState(publicList: resultList, page: page);
      }
    } catch (_) {
      if (event is GetPublicEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
