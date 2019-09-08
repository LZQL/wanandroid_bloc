import 'package:wanandroid_bloc/common/index_all.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  @override
  ProjectState get initialState => InitProjectState();

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    try {
      /// 获取 最新项目 数据
      if (event is GetProjectEvent) {
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
          BaseRefreshModel projectModel = await HttpRequestFactory.getProjectList(
              page: page, cid: event.cid);

          List<ItemModel> list = projectModel.datas.map((value) {
            return ItemModel.fromJson(value);
          }).toList();

          if (event.isRefresh) {
            // 下拉刷新
            if (list.isEmpty) {
              event.controller.refreshEmpty();
            } else {
              resultList.addAll(list);
              event.controller.refreshSuccess();

              if (projectModel.pageCount == projectModel.curPage) {
                event.controller.loadMoreNoMore();
              }
            }
          } else {
            // 加载更多
            resultList.addAll(originalList);
            resultList.addAll(list);
            event.controller.loadMoreSuccess();

            if (projectModel.pageCount == projectModel.curPage) {
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

        yield GetProjectState(projectList: resultList, page: page);
      }
    } catch (_) {
      if (event is GetProjectEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
