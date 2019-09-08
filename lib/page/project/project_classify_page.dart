import 'package:wanandroid_bloc/common/index_all.dart';

//import 'package:flutter/material.dart';
/// 项目分类
class ProjectClassifyPage extends StatefulWidget {
  @override
  _ProjectClassifyPageState createState() => _ProjectClassifyPageState();
}

class _ProjectClassifyPageState extends State<ProjectClassifyPage>
    with SingleTickerProviderStateMixin {
  ZekingRefreshController _refreshController;

  ProjectClassifyBloc _projectClassifyBloc;

  List<TagModel> projectClassifyList;

  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  var _isPageCanChanged = true;
  @override
  void initState() {
    super.initState();
    _refreshController = new ZekingRefreshController();
    _projectClassifyBloc = BlocProvider.of<ProjectClassifyBloc>(context);

    _refreshController.refreshingWithLoadingView();
  }

  @override
  void dispose() {
    _projectClassifyBloc.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTitleBar(
        IntlUtil.getString(context, Ids.projectClassify),
        userThemeStyle: true,
      ),
      body:  buildRoot(context),
    );
  }

  Widget buildRoot(BuildContext context) {
    return BlocBuilder(
      bloc: _projectClassifyBloc,
      builder: (context, ProjectClassifyState state) {
        if (state is GetProjectClassifyState) {
          if (projectClassifyList == null) {
            projectClassifyList = new List();
          }

          projectClassifyList.clear();
          projectClassifyList.addAll(state.projectClassifyList);

          if (_tabController == null) {
            _tabController = new TabController(
                length: projectClassifyList.length, vsync: this);
          }
        }

        return MyZekingRefresh(
            canRefresh: false,
            canLoadMore: false,
            onRefresh: onRefresh,
            controller: _refreshController,
            child:
            ListView(
              children: <Widget>[
                Container(
                  height: Dimens.size(100),
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: Dimens.size(15)),
                  child: projectClassifyList==null? Container():TabBar(
                      onTap: (index) {
                        if (!mounted) {
                          return;
                        }

                        _pageController.jumpToPage(index);
                      },
                      isScrollable: true,
                      controller: _tabController,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: ColorT.color_666666,
                      labelStyle: TextStyle(
                          fontSize: Dimens.sp(32),
                          color: Theme.of(context).primaryColor),
                      unselectedLabelStyle: TextStyles.size32color666666,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: Dimens.size(4),
                      indicatorPadding: EdgeInsets.only(
                          left: Dimens.size(50), right: Dimens.size(50)),
                      tabs:  projectClassifyList.map((model) {
                        return Tab(
                          child: Text(model.name),
                        );
                      }).toList()),
                ),
                DividerHorizontal(),
                Container(
                  height: SystemScreenUtil.getInstance().screenHeight -
                      Dimens.size(88) -
                      SystemScreenUtil.getStatusBarH(context) -
                      Dimens.size(100) -
                      SystemScreenUtil.getInstance().statusBarHeight -
                      Dimens.size(1),
                  color: Colors.black,
                  child: projectClassifyList==null? Container(): PageView.builder(
                    itemCount: projectClassifyList.length,
                    onPageChanged: (index) {
                        if (_isPageCanChanged) {
                          //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                          _onPageChange(index);
                        }
                    },
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      return BlocProvider(builder: (context) => ProjectBloc(), child: ProjectPage(projectClassifyList[index].id));
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }

  void onRefresh() {
    _projectClassifyBloc.dispatch(GetProjectClassifyEvent(_refreshController));
  }

  _onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //判断是哪一个切换
      _isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      _isPageCanChanged = true;
    } else {
      _tabController.animateTo(index); //切换Tabbar
    }
  }
}
