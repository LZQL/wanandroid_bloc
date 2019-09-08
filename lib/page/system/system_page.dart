import 'package:wanandroid_bloc/common/index_all.dart';

/// 体系 页面
class SystemPage extends StatefulWidget {
  final String cid;
  final String name;

  SystemPage(this.cid,this.name);

  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  ZekingRefreshController _refreshController;

  List<ItemModel> systemList;
  int page = 0;
  SystemBloc _systemBloc;

  @override
  void initState() {
    _refreshController = new ZekingRefreshController();
    _systemBloc = BlocProvider.of<SystemBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String mName = FluroConvertUtils.fluroCnParamsDecode(widget.name);
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyTitleBar(
        mName,
        userThemeStyle: true,
      ),
      body: buildRootList(context),
    );
  }

  Widget buildRootList(BuildContext context) {
    return BlocBuilder(
      bloc: _systemBloc,
      builder: (context, state) {
        if (state is InitSystemState) {
          _refreshController.refreshingWithLoadingView();
        }

        if (systemList == null) {
          systemList = new List();
        }

        if (state is GetSystemState) {
          if (systemList == null) {
            systemList = new List();
          }
          systemList.clear();
          systemList.addAll(state.systemList);
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
            itemCount: (null == systemList ? 0 : systemList.length),
          ),
        );
      },
    );
  }

  Widget buildItem(index) {
//    return ProjectItem(systemList[index], () => itemClick(index));
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
              systemList[index].title,
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
                  '时间：' + systemList[index].niceDate,
                  style: TextStyles.size22color999999,
                ),
                Padding(
                  padding: EdgeInsets.only(right: Dimens.size(20)),
                  child: Icon(
                    MyIcon.collection2,
                    color: systemList[index].collect
                        ? ColorT.color_FFC529
                        : ColorT.color_999999,
                    size: Dimens.size(45),
                  ),
                ),
              ],
            ),
            Gaps.vGap30,
            DividerHorizontal()
          ],
        ),
      )),
    );
  }

  ///================================= 网络请求 ================================

  void onRefresh() {
    _systemBloc.dispatch(
        GetSystemEvent(systemList, page, widget.cid, _refreshController, true));
  }

  void onLoading() {
    _systemBloc.dispatch(GetSystemEvent(
        systemList, page, widget.cid, _refreshController, false));
  }

  void itemClick(index) {
    NavigatorUtils.goWebView(
        context, systemList[index].link, systemList[index].title);
  }

  void onTitleRightButtonClick() {
    NavigatorUtils.goProjectClassify(context);
//    NavigatorUtil2.pushPage(context, ProjectClassifyPage());
  }

  @override
  bool get wantKeepAlive => true;
}
