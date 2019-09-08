import 'package:wanandroid_bloc/common/index_all.dart';

/// 我的收藏列表
class CollectListPage extends StatefulWidget {
  @override
  _CollectListPageState createState() => _CollectListPageState();
}

class _CollectListPageState extends State<CollectListPage> {
  ZekingRefreshController _refreshController;

  CollectBloc _collectBloc;
  List<ItemModel> collectList;
  int page = 0;

  @override
  void initState() {
    _refreshController = new ZekingRefreshController();
    _collectBloc = BlocProvider.of<CollectBloc>(context);
    super.initState();

    _refreshController.refreshingWithLoadingView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTitleBar(IntlUtil.getString(context, Ids.my_collect)),
      body: BlocBuilder(
          bloc: _collectBloc,
          builder: (context, state) {
            if (collectList == null) {
              collectList = new List();
            }

            if (state is GetCollectListState) {
              if (collectList == null) {
                collectList = new List();
              }
              collectList.clear();
              collectList.addAll(state.collectList);
              page = state.page;
            }

            if (state is CancelCollectSuccessState) {
              _refreshController.loadingEnd(toastMsg:IntlUtil.getString(context, Ids.cancel_collect_success));
              _refreshController.refreshingWithLoadingView();
            }

            if(state is CancelCollectFailedState){
              _refreshController.loadingEnd(toastMsg:state.errorMsg);
            }

            return Container(
              color: Colors.white,
              child: MyZekingRefresh(
                  controller: _refreshController,
                  onRefresh: onRefresh,
                  onLoading: onLoading,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return buildItem(context, index);
                    },
                    itemCount: (null == collectList ? 0 : collectList.length),
                  )),
            );
          }),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => itemClick(index),
        child: Container(
          width: SystemScreenUtil.getInstance().screenWidth,
          child: Padding(
            padding: EdgeInsets.only(
                left: Dimens.size(32),
                right: Dimens.size(32),
                top: Dimens.size(20)),
            child: Column(
              children: <Widget>[
                Container(
                  width: SystemScreenUtil.getInstance().screenWidth -
                      Dimens.size(64),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              collectList[index].title,
                              style: TextStyle(
                                  fontSize: Dimens.sp(28),
                                  color: ColorT.gray_33,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: Dimens.size(6), bottom: Dimens.size(6)),
                              child: Text(
                                '作者：' +
                                    collectList[index].author +
                                    '    收藏时间：' +
                                    collectList[index].niceDate,
                                style: TextStyles.size22color666666,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: <Widget>[
                                  (collectList[index].tags == null ||
                                          collectList[index].tags.length == 0)
                                      ? Text('分类：',
                                          style: TextStyle(
                                              color: ColorT.gray_66,
                                              fontSize: 11))
                                      : StrokeWidget(
                                          edgeInsets: EdgeInsets.symmetric(
                                              vertical: Dimens.size(4),
                                              horizontal: Dimens.size(20)),
                                          strokeWidth: Dimens.size(1),
                                          color: Theme.of(context).primaryColor,
                                          childWidget: Text(
                                              collectList[index].tags[0].name,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: Dimens.sp(22))),
                                        ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Dimens.size(20)),
                                    child: Text(
//                            collectList[index].superChapterName +
//                                "/" +
                                        collectList[index].chapterName,
                                        style: TextStyles.size24color666666),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => unCollectClick(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimens.size(20),
                                horizontal: Dimens.size(20)),
                            child: Text(
                              IntlUtil.getString(context, Ids.cancel_collect),
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                DividerHorizontal()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void itemClick(index) {
    NavigatorUtils.goWebView(
        context, collectList[index].link, collectList[index].title);
  }

  void unCollectClick(index) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new SingleChildScrollView(
            child: new Text(
              IntlUtil.getString(context, Ids.are_you_sure_to_cancel_the_collection),
              style: TextStyles.size32color333333,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(IntlUtil.getString(context, Ids.cancel),
                  style: TextStyles.size28color333333),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(IntlUtil.getString(context, Ids.confirm),
                  style:
                      TextStyle(fontSize: Dimens.size(28), color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                unCollect(index);
              },
            ),
          ],
        );
      },
    );
  }

  void onRefresh() {
    _collectBloc.dispatch(
        GetCollectListEvent(collectList, page, _refreshController, true));
  }

  void onLoading() {
    _collectBloc.dispatch(
        GetCollectListEvent(collectList, page, _refreshController, false));
  }

  void unCollect(index) {
    _refreshController.loading();
    _collectBloc.dispatch(
        CancelCollectEvent(collectList[index].originId));
  }
}
