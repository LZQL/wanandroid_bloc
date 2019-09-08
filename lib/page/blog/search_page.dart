import 'package:wanandroid_bloc/common/index_all.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  ZekingRefreshController _refreshController;

  SearchBloc _searchBloc;
  ApplicationBloc _applicationBloc;
  CollectBloc _collectBloc;
  List<ItemModel> searchList;
  int page = 0;

  String k;

  bool firstGoin = true;

  @override
  void initState() {
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    _collectBloc = BlocProvider.of<CollectBloc>(context);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _refreshController = new ZekingRefreshController();
    super.initState();
//    _refreshController.refreshingWithLoadingView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[buildSearchTitle(), buildRootList(context)],
      ),
    );
  }

  Widget buildSearchTitle() {
    List<Color> tempColor;
    tempColor = [
      Color.fromARGB(
          170,
          Theme.of(context).primaryColor.red,
          Theme.of(context).primaryColor.green,
          Theme.of(context).primaryColor.blue),
      Theme.of(context).primaryColor
    ];

    return SizedBox(
      height: Dimens.size(88) + SystemScreenUtil.getStatusBarH(context),
      child: PreferredSize(
        preferredSize: Size.fromHeight(
            Dimens.size(88) + SystemScreenUtil.getStatusBarH(context)),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            width: SystemScreenUtil.getInstance().screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: tempColor),
            ),
            padding:
                EdgeInsets.only(top: SystemScreenUtil.getStatusBarH(context)),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      height: Dimens.size(88),
                      child: Row(
                        children: <Widget>[
                          /// 左边 图片 按钮
                          GestureDetector(
                            child: Container(
                              color: Colors.transparent,
                              height: Dimens.size(88),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimens.size(34),
                                  right: Dimens.size(32),
                                ),
                                child: Image.asset(
                                  MyUtil.getImgPath('back'),
                                  width: Dimens.size(20),
                                  height: Dimens.size(36),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              NavigatorUtils.goBack(context);
                            },
                          ),

                          /// 搜索框
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: Dimens.size(32)),
                              child: TextField(
                                controller: _controller,
                                autofocus: true,
                                textInputAction: TextInputAction.send,
                                focusNode: _focusNode,
                                cursorColor: Theme.of(context).primaryColor,
                                cursorWidth: 1,
                                style: TextStyles.size28color333333,
                                decoration: InputDecoration(
                                    hintText: IntlUtil.getString(context,
                                        Ids.please_input_search_keywords),
                                    hintStyle: TextStyles.size28color999999,
                                    fillColor: ColorT.color_F4F4F4,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: Dimens.size(30),
                                        vertical: Dimens.size(11)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(66),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(66),
                                    )),
                                onSubmitted: (String str) {
                                  if (str.isEmpty) {
                                    ToastUtil.showShort(
                                        IntlUtil.getString(context,
                                            Ids.please_input_search_keywords),
                                        context);
                                  } else {
//                                    print('str $str');
//                                    _controller.clear();
                                    searchClick(str);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          //设置没有返回按钮
        ),
      ),
    );
  }

  Widget buildRootList(BuildContext context) {
    return Expanded(
//      width: SystemScreenUtil.getInstance().screenWidth,
//      height: SystemScreenUtil.getInstance().screenHeight - Dimens.size(88) - SystemScreenUtil.getStatusBarH(context) - SystemScreenUtil.getInstance().bottomBarHeight,
      child: MultiBlocListener(
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
                _refreshController.loadingEnd(
                    toastMsg: IntlUtil.getString(context, Ids.collect_success));
                for (int i = 0; i < searchList.length; i++) {
                  if (searchList[i].id == state.id) {
                    searchList[i].collect = true;
                    setState(() {});
                    break;
                  }
                }
              }

              if (state is CollectFailedState) {
                _refreshController.loadingEnd(
                    toastMsg: IntlUtil.getString(context, Ids.collect_failed));
              }

              if (state is CancelCollectSuccessState) {
                _refreshController.loadingEnd(
                    toastMsg: IntlUtil.getString(
                        context, Ids.cancel_collect_success));
                for (int i = 0; i < searchList.length; i++) {
                  if (searchList[i].id == state.id) {
                    searchList[i].collect = false;
                    setState(() {});
                    break;
                  }
                }
              }

              if (state is CancelCollectFailedState) {
                _refreshController.loadingEnd(
                    toastMsg:
                        IntlUtil.getString(context, Ids.cancel_collect_failed));
              }
            },
          ),
        ],
        child: BlocBuilder(
            bloc: _searchBloc,
            builder: (context, state) {
              if (state is SearchState) {
                if (searchList == null) {
                  searchList = new List();
                }
                searchList.clear();
                searchList.addAll(state.searchList);
                page = state.page;
              }

              return firstGoin
                  ? Container()
                  : MyZekingRefresh(
                      displacement: Dimens.size(130),
                      controller: _refreshController,
                      onRefresh: onRefresh,
                      onLoading: onLoading,
//                canLoadMore: searchList == null ? false:true,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0.0),
                        itemBuilder: (context, index) {
                          return buildItem(context, index);
                        },
                        itemCount: (null == searchList ? 0 : searchList.length),
                      ),
                    );
            }),
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
                  decodeString(searchList[index].title)
                      .replaceAll("<em class='highlight'>", '')
                      .replaceAll("\</em>", '')
                  ,
                  style: TextStyle(
                      fontSize: Dimens.sp(28),
                      color: ColorT.gray_33,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimens.size(20),
                  ),
                  child: Text(
                    '作者：' +
                        searchList[index].author +
                        '    时间：' +
                        searchList[index].niceDate,
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
                          searchList[index].fresh
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
                          (searchList[index].tags == null ||
                                  searchList[index].tags.length == 0)
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
                                      searchList[index].tags[0].name,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimens.sp(22))),
                                ),
                          Padding(
                            padding: EdgeInsets.only(left: Dimens.size(20)),
                            child: Text(
                                searchList[index].superChapterName +
                                    "/" +
                                    searchList[index].chapterName,
                                style: TextStyles.size24color666666),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () => collectClick(index),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Dimens.size(20),
                              left: Dimens.size(20),
                              top: Dimens.size(20),
                              bottom: Dimens.size(20)),
                          child: Icon(
                            MyIcon.collection2,
                            color: searchList[index].collect
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

  void onRefresh() {
    _searchBloc.dispatch(SearchEvent(
        searchList: searchList,
        page: page,
        controller: _refreshController,
        isRefresh: true,
        k: k));
  }

  void onLoading() {
    _searchBloc.dispatch(SearchEvent(
        searchList: searchList,
        page: page,
        controller: _refreshController,
        isRefresh: false,
        k: k));
  }

  void searchClick(str) {
    firstGoin = false;
    setState(() {});
    k = str;
    _refreshController.refreshingWithLoadingView();
  }

  void collectClick(index) {
    if (SpHelper.getIsLogin()) {
      _refreshController.loading();
      if (searchList[index].collect) {
        _collectBloc.dispatch(CancelCollectEvent(searchList[index].id));
      } else {
        _collectBloc.dispatch(CollectEvent(searchList[index].id));
      }
    } else {
      showToast(IntlUtil.getString(context, Ids.please_login_first));
      NavigatorUtils.goLoginPage(context);
    }
  }

  void itemClick(index) {
    NavigatorUtils.goWebView(
        context, searchList[index].link, decodeString(searchList[index].title)
        .replaceAll("<em class='highlight'>", '')
        .replaceAll("\</em>", ''));
  }
}
