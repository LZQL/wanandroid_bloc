import 'package:wanandroid_bloc/common/index_all.dart';

class CollectBloc extends Bloc<CollectBaseEvent, CollectBaseState> {
  @override
  CollectBaseState get initialState => InitCollectState();

  @override
  Stream<CollectBaseState> mapEventToState(CollectBaseEvent event) async* {
    try {

      /// 获取 最新项目 数据
      if (event is GetCollectListEvent) {
        List<ItemModel> originalList = event.collectList;
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
              await HttpRequestFactory.getCollectList(page: page);

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
          resultList.addAll(event.collectList);
          if (event.isRefresh) {
            event.controller.refreshFaild();
          } else {
            page--;
            event.controller.loadMoreFailed();
          }
        }

        yield GetCollectListState(collectList: resultList, page: page);
      }

      ///  收藏
      if(event is CollectEvent){
        int  id = event.id;

        String errorMsg ;

        try {
          BaseResponse baseResponse =   await HttpRequestFactory.collectArticle(id).catchError((error) {
            errorMsg = error.toString();
          });

          if(baseResponse == null) {
            yield CollectFailedState( errorMsg);
          }else{
            yield CollectSuccessState(id);
          }

        } catch (e) {
          yield CollectFailedState( e.toString());
        }
      }

      ///  取消收藏
      if(event is CancelCollectEvent){
        int  id = event.id;

        String errorMsg ;

        try {
          BaseResponse baseResponse =   await HttpRequestFactory.cancelCollectArticle(id).catchError((error) {
            errorMsg = error.toString();
          });

          if(baseResponse == null) {
            yield CancelCollectFailedState( errorMsg);
          }else{
            yield CancelCollectSuccessState(id);
          }

        } catch (e) {
          yield CancelCollectFailedState( e.toString());
        }
      }

    } catch (_) {
      if (event is GetCollectListEvent) {
        event.controller.refreshFaild();
      }else if(event is CancelCollectEvent){
        yield CancelCollectFailedState( _.toString());
      }else if(event is CollectEvent){
        yield CollectFailedState( _.toString());
      }
    }
  }
}
