import 'package:wanandroid_bloc/common/index_all.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  @override
  BlogState get initialState => InitState();

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    try {
      /// 获取 Banner 数据
      if (event is BannerEvent) {
        List<BannerModel> bannerList = await HttpRequestFactory.getBanner();
        yield BannerState(bannerList);
      }

      /// 获取 公司任务 数据
      if (event is CompanyTaskEvent) {
        List<ItemModel> originalList = event.companyTaskList;
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
              await HttpRequestFactory.getBlogList(page: page);

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
          resultList.addAll(event.companyTaskList);
          if (event.isRefresh) {
            event.controller.refreshFaild();
          } else {
            page--;
            event.controller.loadMoreFailed();
          }
        }

        yield CompanyTaskState(blogList: resultList, page: page);
      }
    } catch (_) {
      if (event is CompanyTaskEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
