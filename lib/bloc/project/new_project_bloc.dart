import 'package:wanandroid_bloc/common/index_all.dart';

class NewProjectBloc extends Bloc<NewProjectEvent, NewProjectState> {
  @override
  NewProjectState get initialState => InitNewProjectState();

  @override
  Stream<NewProjectState> mapEventToState(NewProjectEvent event) async* {
    try {

      /// 获取 最新项目 数据
      if (event is GetNewProjectEvent) {
        List<ItemModel> originalList = event.newProjectList;
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
              await HttpRequestFactory.getNewProjectList(page: page);

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
            }

            if (blogModel.pageCount == blogModel.curPage) {
              event.controller.loadMoreNoMore();
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
          resultList.addAll(event.newProjectList);
          if (event.isRefresh) {
            event.controller.refreshFaild();
          } else {
            page--;
            event.controller.loadMoreFailed();
          }
        }

        yield GetNewProjectState(newProjectList: resultList, page: page);
      }
    } catch (_) {
      if (event is GetNewProjectEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
