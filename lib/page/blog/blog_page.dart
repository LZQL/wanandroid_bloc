import 'package:wanandroid_bloc/common/index_all.dart';

/// 博文 页面
class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with AutomaticKeepAliveClientMixin {
  ZekingRefreshController _refreshController;

  BlogBloc _taskSquareBloc;
  ApplicationBloc _applicationBloc;
  CollectBloc _collectBloc;

  List<BannerModel> bannerList; // Banner 数据

  List<ItemModel> blogList; //  博文 数据
  ScrollController scrollController;
  int page = 0;

  bool _isNeedSetAlpha = true;
  bool isShowFloatBtn = false;
  int alpha = 0;

  ///============================ 系统方法 ==============================

  @override
  void initState() {
    scrollController = new ScrollController();
    _taskSquareBloc = BlocProvider.of<BlogBloc>(context);
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    _collectBloc = BlocProvider.of<CollectBloc>(context);
    _refreshController = new ZekingRefreshController();
    super.initState();
    _refreshController.refreshingWithLoadingView();

    /// 监听滚动，改变titibar的透明度
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        int offset = scrollController.offset.toInt();

        if (offset < Dimens.size(900) && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > Dimens.size(900) && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }

        if (offset < 120.0) {
          _isNeedSetAlpha = true;
          alpha = ((offset / 120) * 255).toInt();
          setState(() {});
        } else {
          if (_isNeedSetAlpha) {
            alpha = 255;
            _isNeedSetAlpha = false;
            setState(() {});
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _taskSquareBloc.dispose();
    _refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  ///================================= 布局 ==============================

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Stack(
          children: <Widget>[buildRootList(context), buildCustomTitleBar()],
        ),
        floatingActionButton: buildFloatingActionButton());
  }

  // 顶部搜索框 appBar
  Widget buildCustomTitleBar() {
    return SizedBox(
      height: Dimens.size(88) + SystemScreenUtil.getStatusBarH(context),
      child: PreferredSize(
        preferredSize: Size.fromHeight(
            Dimens.size(88) + SystemScreenUtil.getStatusBarH(context)),
        child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: _isNeedSetAlpha
                                ? Colors.transparent
                                : ColorT.divider,
                            width: Dimens.size(1)))),
                child: Padding(
                  padding: new EdgeInsets.only(
                      top: SystemScreenUtil.getStatusBarH(context),
                      left: Dimens.size(32),
                      right: Dimens.size(32)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: searchClick,
                      child: Container(
                        height: Dimens.size(64),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: Dimens.sp(30),
                            ),
                            Padding(padding: EdgeInsets.only(left: 4.0)),
                            Text(
                              IntlUtil.getString(
                                  context, Ids.please_input_search_keywords),
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(77, 0, 0, 0),
//                    border: Border.all(color: Color.fromARGB(77, 0, 0, 0), width: 1.0),
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ),
                )),
            brightness: Brightness.light,
            backgroundColor: Color.fromARGB(
                alpha, Colors.white.red, Colors.white.green, Colors.white.blue),
            centerTitle: true),
      ),
    );
  }

  // 滚到顶部 按钮
  Widget buildFloatingActionButton() {
//    widget.scrollController.;

    if (
//    if (widget.isFirstLoad ||
        scrollController == null ||
            !scrollController.hasClients ||
            scrollController.offset == null ||
            scrollController.offset.toInt() < Dimens.size(900)) {
      return Container();
    }

    return new FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          //_controller.scrollTo(0.0);
          scrollController.animateTo(0.0,
              duration: new Duration(milliseconds: 300), curve: Curves.linear);
        });
  }

  // 根布局 组件
  Widget buildRootList(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _applicationBloc,
          listener: (context, state) {
            if (state is UpdateDataState) {
              _isNeedSetAlpha = true;
              alpha = 0;
              _refreshController.refreshingWithLoadingView();
            }
          },
        ),
        BlocListener(
          bloc: _collectBloc,
          listener: (context, state) {
            if (state is CollectSuccessState) {
              _refreshController.loadingEnd(toastMsg: IntlUtil.getString(context, Ids.collect_success));
              for (int i = 0; i < blogList.length; i++) {
                if (blogList[i].id == state.id) {
                  blogList[i].collect = true;
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
              for (int i = 0; i < blogList.length; i++) {
                if (blogList[i].id == state.id) {
                  blogList[i].collect = false;
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
          bloc: _taskSquareBloc,
          builder: (context, state) {
            /// 如果是初始化 ，就请求 Banner 和 公司任务 数据
//          if (state is InitState) {
//            _refreshController.refreshingWithLoadingView();
//          }

            if (bannerList == null) {
              bannerList = new List();
            }

            /// 如果是 Banner ，更新 Banner 数据
            if (state is BannerState) {
              if (state.bannerList.length > 0) {
                bannerList.clear();
                bannerList.addAll(state.bannerList);
              }
            }

            /// 如果是 公司任务 数据，就更新 公司任务 数据
            if (state is CompanyTaskState) {
              if (blogList == null) {
                blogList = new List();
              }
              blogList.clear();
              blogList.addAll(state.blogList);
              page = state.page;
            }

            return MyZekingRefresh(
              displacement: Dimens.size(130),
              controller: _refreshController,
              onRefresh: onRefresh,
              onLoading: onLoading,
              scrollController: scrollController,
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return buildBanner(context);
                  } else {
                    return buildItem(context, index - 1);
//            return buildItem(context, index - (null == bannerList ? 0 : 1));
                  }
                },
                itemCount: 1 + (null == blogList ? 0 : blogList.length),
              ),
            );
          }),
    );
  }

  // Banner 头组件
  Widget buildBanner(BuildContext context) {
    if (ObjectUtil.isEmpty(bannerList)) {
      // 判断bannerList是否为空
      return new Container(height: 0.0);
    }

    return new AspectRatio(
      // 子部件的大小调整为特定的纵横比 布局
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.bottomEnd,
        circular: true,
        interval: const Duration(seconds: 5),
        indicator: NumberSwiperIndicator(),
        children: bannerList.map((model) {
          return new InkWell(
            onTap: () => bannerItemClick(model),
            child: new CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: model.imagepath,
              placeholder: (context, url) => ProgressView(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 博文 Item
  Widget buildItem(BuildContext context, int index) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => itemClick(index),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
                left: Dimens.size(32),
                right: Dimens.size(32),
                top: Dimens.size(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  blogList[index].title,
                  style: TextStyle(
                      fontSize: Dimens.sp(28),
                      color: ColorT.gray_33,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimens.size(20), ),
                  child: Text(
                    '作者：' +
                        blogList[index].author +
                        '    时间：' +
                        blogList[index].niceDate,
                    style: TextStyles.size22color666666,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          blogList[index].fresh
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(right: Dimens.size(20)),
                                  child: StrokeWidget(
                                    edgeInsets: EdgeInsets.symmetric(
                                        vertical: Dimens.size(4),
                                        horizontal: Dimens.size(20)),
                                    strokeWidth: Dimens.size(1),
                                    color: Colors.red,
                                    childWidget: Text('新',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: Dimens.sp(22))),
                                  ))
                              : Container(),
                          (blogList[index].tags == null ||
                                  blogList[index].tags.length == 0)
                              ? Text('分类：',
                                  style: TextStyle(
                                      color: ColorT.gray_66, fontSize: 11))
                              : StrokeWidget(
                                  edgeInsets: EdgeInsets.symmetric(
                                      vertical: Dimens.size(4),
                                      horizontal: Dimens.size(20)),
                                  strokeWidth: Dimens.size(1),
                                  color: Theme.of(context).primaryColor,
                                  childWidget: Text(
                                      blogList[index].tags[0].name,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimens.sp(22))),
                                ),
                          Padding(
                            padding: EdgeInsets.only(left: Dimens.size(20)),
                            child: Text(
                                blogList[index].superChapterName +
                                    "/" +
                                    blogList[index].chapterName,
                                style: TextStyles.size24color666666),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () => collectClick(index),
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimens.size(20),left: Dimens.size(20),top: Dimens.size(20),bottom: Dimens.size(20)),
                          child: Icon(
                            MyIcon.collection2,
                            color: blogList[index].collect
                                ? ColorT.color_FFC529
                                : ColorT.color_999999,
                            size: Dimens.size(45),
                          ),
                        ),
                      ),
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

  ///================================= 网络请求 ================================

  void onRefresh() {
    _taskSquareBloc.dispatch(BannerEvent());
    _taskSquareBloc
        .dispatch(CompanyTaskEvent(blogList, page, _refreshController, true));
  }

  void onLoading() {
    _taskSquareBloc
        .dispatch(CompanyTaskEvent(blogList, page, _refreshController, false));
  }

  ///================================= 点击事件 ================================

  void bannerItemClick(BannerModel model) {
    NavigatorUtils.goWebView(
      context,
      model.url,
      model.title,
    );
  }

  void itemClick(index) {
    NavigatorUtils.goWebView(
        context, blogList[index].link, blogList[index].title);
  }

  void collectClick(index) {
    if(SpHelper.getIsLogin()){
      _refreshController.loading();
      if (blogList[index].collect) {
        _collectBloc.dispatch(CancelCollectEvent(blogList[index].id));
      } else {
        _collectBloc.dispatch(CollectEvent(blogList[index].id));
      }
    }else{
      showToast(IntlUtil.getString(context, Ids.please_login_first));
      NavigatorUtils.goLoginPage(context);
    }
  }

  void searchClick(){
//    ToastUtil.showShort(
//        IntlUtil.getString(
//            context, Ids.please_input_search_keywords),
//        context);
    NavigatorUtils.goSearchPage(context);
  }

}
