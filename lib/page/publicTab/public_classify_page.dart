import 'package:wanandroid_bloc/common/index_all.dart';

/// 公众号 分类页面
class PublicClassifyPage extends StatefulWidget {
  @override
  _PublicClassifyPageState createState() => _PublicClassifyPageState();
}

class _PublicClassifyPageState extends State<PublicClassifyPage>
    with AutomaticKeepAliveClientMixin {
  ZekingRefreshController _refreshController;

  PublicClassifyBloc _publicClassifyBloc;

  List<TagModel> publicClassifyList;

  PageController _pageController = PageController(initialPage: 0);

  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = new ZekingRefreshController();
    _publicClassifyBloc = BlocProvider.of<PublicClassifyBloc>(context);

    _refreshController.refreshingWithLoadingView();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyTitleBar(
        IntlUtil.getString(context, Ids.publicTab),
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
      bloc: _publicClassifyBloc,
      builder: (context, state) {
        if (state is GetPublicClassifyState) {
          if (publicClassifyList == null) {
            publicClassifyList = new List();
          }

          publicClassifyList.clear();
          publicClassifyList.addAll(state.publicClassifyList);
        }

        return MyZekingRefresh(
            canLoadMore: false,
            canRefresh: false,
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
                    itemCount: (null == publicClassifyList
                        ? 0
                        : publicClassifyList.length),
                  ),
                ),
                Container(
                  width: SystemScreenUtil.getInstance().screenWidth -
                      Dimens.size(180),
                  height: height,
                  child: publicClassifyList == null
                      ? Container()
                      : PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: publicClassifyList.length,
                          controller: _pageController,
                          itemBuilder: (BuildContext context, int index) {
                            return BlocProvider(
                                builder: (context) => PublicBloc(),
                                child:
                                    PublicPage(publicClassifyList[index].id));
                          },
                        ),
                )
              ],
            ));
      },
    );
  }

  Widget buildTagItem(index) {
    return Material(
//      color: selectIndex == index ? Colors.white :Theme.of(context).primaryColor,
      color: selectIndex == index ? Colors.white : Color.fromARGB(
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
                  publicClassifyList[index].name,
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

  void onRefresh() {
    _publicClassifyBloc.dispatch(GetPublicClassifyEvent(_refreshController));
  }

  void tagClick(index) {
    setState(() {
      selectIndex = index;
    });

    _pageController.jumpToPage(index);
  }

  @override
  bool get wantKeepAlive => true;
}
