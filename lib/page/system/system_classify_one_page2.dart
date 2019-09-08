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

  @override
  void initState() {
    itemKeys = new List();
    super.initState();
    _refreshController = new ZekingRefreshController();
    _systemClassifyBloc = BlocProvider.of<SystemClassifyBloc>(context);

    _refreshController.refreshingWithLoadingView();


//    SchedulerBinding.instance.addPostFrameCallback((_) {
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      print('WidgetsBinding.instance');
//      if(mounted){
//        print('mounted');
//      }else{
//        print('mounted not ');
//      }
////      if (itemKeys != null &&
////          itemKeys.length != null &&
////          systemClassifyList != null &&
////          systemClassifyList.length != 0 &&
////          itemKeys.length == systemClassifyList.length) {
////        setState(() {
////          bottomHeight = SystemScreenUtil.getInstance().screenHeight -
////              50 -
////              Dimens.size(88) -
////              SystemScreenUtil.getStatusBarH(context) -
////              SystemScreenUtil.getInstance().bottomBarHeight -
////              itemKeys[itemKeys.length - 1].currentContext.size.height;
////        });
////      }
//    });
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
//    if(mounted) {
//      if(itemKeys != null && itemKeys.length == systemClassifyList.length){
//        setState(() {
//          bottomHeight = SystemScreenUtil.getInstance().screenHeight -
//              50 -
//              Dimens.size(88) -
//              SystemScreenUtil.getStatusBarH(context) -
//              SystemScreenUtil.getInstance().bottomBarHeight -
//              itemKeys[itemKeys.length - 1]
//                  .currentContext
//                  .size
//                  .height;
//        });
//      }
//    }

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
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                if (index == systemClassifyList.length) {


//                  bottomHeight = SystemScreenUtil.getInstance().screenHeight -
//              50 -
//              Dimens.size(88) -
//              SystemScreenUtil.getStatusBarH(context) -
//              SystemScreenUtil.getInstance().bottomBarHeight -
//              itemKeys[itemKeys.length - 1]
//                  .currentContext
//                  .size
//                  .height;

                  return Container(
                    color: Colors.red,
                    height: bottomHeight,
//                    mounted ? ( itemKeys == null
//                        ? 0
//                        : (itemKeys.length == systemClassifyList.length
//                            ? SystemScreenUtil.getInstance().screenHeight -
//                                50 -
//                                Dimens.size(88) -
//                                SystemScreenUtil.getStatusBarH(context) -
//                                SystemScreenUtil.getInstance().bottomBarHeight -
//                                itemKeys[itemKeys.length - 1]
//                                    .currentContext
//                                    .size
//                                    .height
//                            : 0)):0,
                  );
                } else {
                  return buildItem(index);
                }
              },
              itemCount: (null == systemClassifyList
                  ? 1
                  : systemClassifyList.length + 1),
            ),
          );
        });
  }

  Widget buildItem(index) {
    /// 体系一级分类
    final List<Widget> cardChildren = <Widget>[
      new Text(
        systemClassifyList[index].name,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Dimens.sp(28),
            color: ColorT.color_333333),
      ),
      Gaps.vGap10,
    ];

    /// 体系 二级 分类
    List<Widget> chips =
        systemClassifyList[index].children.map<Widget>((TagModel _model) {
      return Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        key: ValueKey<String>(_model.name),
        backgroundColor: MyUtil.getChipBgColor(_model.name),
        label: Text(
          _model.name,
          style: new TextStyle(fontSize: Dimens.sp(24)),
        ),
      );
    }).toList();

    /// 组合 一级 分类 ， 二级 分类
    cardChildren.add(Wrap(
        children: chips.map((Widget chip) {
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: chip,
      );
    }).toList()));

    GlobalKey itemKey = GlobalKey();
    itemKeys.add(itemKey);

    return Container(
      key: itemKeys[index],
      padding: EdgeInsets.all(Dimens.size(32)),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(
                  width: Dimens.size(1), color: ColorT.divider))),
    );
  }

  void onRefresh() {
    _systemClassifyBloc.dispatch(GetSystemClassifyEvent(_refreshController));
  }

  @override
  bool get wantKeepAlive => true;
}
