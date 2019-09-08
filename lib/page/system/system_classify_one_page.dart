import 'package:flutter/scheduler.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 体系 一级分类 页面
class SystemClassifyOnePage extends StatefulWidget {
  @override
  _SystemClassifyOnePageState createState() => _SystemClassifyOnePageState();
}

class _SystemClassifyOnePageState extends State<SystemClassifyOnePage>
    with AutomaticKeepAliveClientMixin {
  ZekingRefreshController _refreshController;

  SystemClassifyBloc _systemClassifyBloc;

  List<SystemTabModel> systemClassifyList;

  List<GlobalKey> itemKeys;

  double bottomHeight = 0;

  int selectIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    itemKeys = new List();
    super.initState();
    _refreshController = new ZekingRefreshController();
    _systemClassifyBloc = BlocProvider.of<SystemClassifyBloc>(context);

    _refreshController.refreshingWithLoadingView();
  }

  @override
  void dispose() {
    _systemClassifyBloc.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTitleBar(
        IntlUtil.getString(context, Ids.systemTab),
        leftImageVisible: false,
        userThemeStyle: true,
      ),
      body: buildRoot(),
    );
  }

  Widget buildRoot() {
    var height = SystemScreenUtil.getInstance().screenHeight -
        50 -
        Dimens.size(88) -
        SystemScreenUtil.getStatusBarH(context) -
        SystemScreenUtil.getInstance().bottomBarHeight;

    return BlocBuilder(
        bloc: _systemClassifyBloc,
        builder: (context, state) {
          if (state is GetSystemClassifyState) {
            if (systemClassifyList == null) {
              systemClassifyList = new List();
            }

            systemClassifyList.clear();
            systemClassifyList.addAll(state.systemClassifyList);
          }

          return MyZekingRefresh(
            canRefresh: false,
            canLoadMore: false,
            onRefresh: onRefresh,
            controller: _refreshController,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Dimens.size(180),
//                  height: Dimens.size(200),
                  height: height,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return buildTagItem(index);
                    },
                    itemCount: (null == systemClassifyList
                        ? 0
                        : systemClassifyList.length),
                  ),
                ),


                Container(
                  width: SystemScreenUtil.getInstance().screenWidth -
                      Dimens.size(180),
                  height: height,
                  child: systemClassifyList == null
                      ? Container()
                      : PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: systemClassifyList.length,
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      return SystemClassifyTwoPage(systemClassifyList[index].children);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildTagItem(index) {
    return Material(
//      color: selectIndex == index ? Colors.white :Theme.of(context).primaryColor,
      color: selectIndex == index
          ? Colors.white
          : Color.fromARGB(
              11,
              Theme.of(context).primaryColor.red,
              Theme.of(context).primaryColor.green,
              Theme.of(context).primaryColor.blue),
//      color: selectIndex == index ? Theme.of(context).primaryColor : ColorT.gray_f0,
      child: InkWell(
        onTap: () => tagClick(index),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: Dimens.size(100),
                child: Text(
                  systemClassifyList[index].name,
                  textAlign: TextAlign.center,
                  style:
//                      TextStyle(color: ColorT.gray_33, fontSize: Dimens.sp(26)),
                      TextStyle(
                    color: selectIndex == index
                        ? Theme.of(context).primaryColor
                        : ColorT.color_666666,
                    fontSize: Dimens.sp(22),
                    fontWeight: selectIndex == index
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                )),
//            DividerHorizontal(dividerColor:Colors.white)
          ],
        ),
      ),
    );
  }

  void tagClick(index) {
    setState(() {
      selectIndex = index;
    });

    _pageController.jumpToPage(index);
  }


  void onRefresh() {
    _systemClassifyBloc.dispatch(GetSystemClassifyEvent(_refreshController));
  }

  @override
  bool get wantKeepAlive => true;
}
