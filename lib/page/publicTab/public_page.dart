import 'package:wanandroid_bloc/common/index_all.dart';

/// 公众号列表 页面
class PublicPage extends StatefulWidget {
  final int id;

  PublicPage(this.id);

  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage>
    with AutomaticKeepAliveClientMixin {
  ZekingRefreshController _refreshController;

  List<ItemModel> publicList; // 公众号 数据
  int page = 0;
  PublicBloc _projectBloc;
  ApplicationBloc _applicationBloc;
  CollectBloc _collectBloc;

  @override
  void initState() {
    _refreshController = new ZekingRefreshController();
    _projectBloc = BlocProvider.of<PublicBloc>(context);
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    _collectBloc = BlocProvider.of<CollectBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildRootList(context),
    );
  }

  Widget buildRootList(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _applicationBloc,
          listener: (context, state) {
            if (state is UpdateDataState) {
              _refreshController.refreshingWithLoadingView();
            }
          },
        ),
        BlocListener(
          bloc: _collectBloc,
          listener: (context, state) {
            if (state is CollectSuccessState) {
              _refreshController.loadingEnd(toastMsg:IntlUtil.getString(context, Ids.collect_success));
              for (int i = 0; i < publicList.length; i++) {
                if (publicList[i].id == state.id) {
                  publicList[i].collect = true;
                  setState(() {});
                  break;
                }
              }
            }

            if (state is CollectFailedState) {
              _refreshController.loadingEnd(toastMsg: IntlUtil.getString(context, Ids.collect_failed));
            }

            if (state is CancelCollectSuccessState) {
              _refreshController.loadingEnd(toastMsg: IntlUtil.getString(context, Ids.cancel_collect_success));
              for (int i = 0; i < publicList.length; i++) {
                if (publicList[i].id == state.id) {
                  publicList[i].collect = false;
                  setState(() {});
                  break;
                }
              }
            }

            if (state is CancelCollectFailedState) {
              _refreshController.loadingEnd(toastMsg: IntlUtil.getString(context, Ids.cancel_collect_failed));
            }
          },
        ),
      ],
      child: BlocBuilder(
        bloc: _projectBloc,
        builder: (context, state) {
          if (state is InitPublicState) {
            _refreshController.refreshingWithLoadingView();
          }

          if (publicList == null) {
            publicList = new List();
          }

          if (state is GetPublicState) {
            if (publicList == null) {
              publicList = new List();
            }
            publicList.clear();
            publicList.addAll(state.publicList);
            page = state.page;
          }

          return MyZekingRefresh(
            controller: _refreshController,
            onRefresh: onRefresh,
            onLoading: onLoading,
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                return buildItem(index);
              },
              itemCount: (null == publicList ? 0 : publicList.length),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(index) {
//    return ProjectItem(publicList[index], () => itemClick(index));
    return InkWell(
      onTap: () => itemClick(index),
      child: Container(
          child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.size(32),
          right: Dimens.size(32),
          top: Dimens.size(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              publicList[index].title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.sp(28),
                  color: ColorT.color_333333),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Gaps.vGap10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '时间：' + publicList[index].niceDate,
                  style: TextStyles.size22color999999,
                ),
                InkWell(
                  onTap: () => collectClick(index),
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.size(20)),
                    child: Icon(
                      MyIcon.collection2,
                      color: publicList[index].collect
                          ? ColorT.color_FFC529
                          : ColorT.color_999999,
                      size: Dimens.size(45),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.vGap10,
            DividerHorizontal()
          ],
        ),
      )),
    );
  }

  ///================================= 网络请求 ================================

  void onRefresh() {
    _projectBloc.dispatch(
        GetPublicEvent(publicList, page, widget.id, _refreshController, true));
  }

  void onLoading() {
    _projectBloc.dispatch(
        GetPublicEvent(publicList, page, widget.id, _refreshController, false));
  }

  void itemClick(index) {
    NavigatorUtils.goWebView(
        context, publicList[index].link, publicList[index].title);
  }

  void collectClick(index) {
    if (SpHelper.getIsLogin()) {
      _refreshController.loading();
      if (publicList[index].collect) {
        _collectBloc.dispatch(CancelCollectEvent(publicList[index].id));
      } else {
        _collectBloc.dispatch(CollectEvent(publicList[index].id));
      }
    } else {
      showToast(IntlUtil.getString(context, Ids.please_login_first));
      NavigatorUtils.goLoginPage(context);
    }
  }

  void onTitleRightButtonClick() {
    NavigatorUtils.goProjectClassify(context);
//    NavigatorUtil2.pushPage(context, ProjectClassifyPage());
  }

  @override
  bool get wantKeepAlive => true;
}
