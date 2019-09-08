import 'package:wanandroid_bloc/common/index_all.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  @override
  SystemState get initialState => InitSystemState();

  @override
  Stream<SystemState> mapEventToState(SystemEvent event) async* {
    try {
      /// 获取 体系下文章列表 数据
      if (event is GetSystemEvent) {
        List<ItemModel> originalList = event.systemList;
        List<ItemModel> resultList = new List();
        int page = 0;

        if (event.isRefresh) {
          /// 如果是刷新 ，
          page = 0;
        } else {
          page = event.page + 1;
        }
        try {
          BaseRefreshModel systemModel = await HttpRequestFactory.getSystemList(
              page: page, cid: event.id);

          List<ItemModel> list = systemModel.datas.map((value) {
            return ItemModel.fromJson(value);
          }).toList();

          if (event.isRefresh) {
            // 下拉刷新
            if (list.isEmpty) {
              event.controller.refreshEmpty();
            } else {
              resultList.addAll(list);
              event.controller.refreshSuccess();

              if (systemModel.pageCount == systemModel.curPage) {
                event.controller.loadMoreNoMore();
              }
            }
          } else {
            // 加载更多
            resultList.addAll(originalList);
            resultList.addAll(list);
            event.controller.loadMoreSuccess();

            if (systemModel.pageCount == systemModel.curPage) {
              event.controller.loadMoreNoMore();
            }
          }
        } catch (e) {
          resultList.addAll(event.systemList);
          if (event.isRefresh) {
            event.controller.refreshFaild();
          } else {
            page--;
            event.controller.loadMoreFailed();
          }
        }

        yield GetSystemState(systemList: resultList, page: page);
      }
    } catch (_) {
      if (event is GetSystemEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
