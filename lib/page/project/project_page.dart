import 'package:wanandroid_bloc/common/index_all.dart';

/// 项目列表 页面
class ProjectPage extends StatefulWidget {
  final int cid;

  ProjectPage(this.cid);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  ZekingRefreshController _refreshController;

  List<ItemModel> projectList; // 最新项目 数据
  int page = 0;
  ProjectBloc _projectBloc;
  CollectBloc _collectBloc;
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    _refreshController = new ZekingRefreshController();
    _projectBloc = BlocProvider.of<ProjectBloc>(context);
    _collectBloc = BlocProvider.of<CollectBloc>(context);
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _projectBloc.dispose();
    _refreshController.dispose();
    super.dispose();
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
              _refreshController.loadingEnd(toastMsg:  IntlUtil.getString(context, Ids.collect_success));
              for (int i = 0; i < projectList.length; i++) {
                if (projectList[i].id == state.id) {
                  projectList[i].collect = true;
                  setState(() {});
                  break;
                }
              }
            }

            if (state is CollectFailedState) {
              _refreshController.loadingEnd(toastMsg: IntlUtil.getString(context, Ids.collect_failed));
            }

            if (state is CancelCollectSuccessState) {
              _refreshController.loadingEnd(toastMsg:  IntlUtil.getString(context, Ids.cancel_collect_success));
              for (int i = 0; i < projectList.length; i++) {
                if (projectList[i].id == state.id) {
                  projectList[i].collect = false;
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
          if (state is InitProjectState) {
            _refreshController.refreshingWithLoadingView();
          }

          if (projectList == null) {
            projectList = new List();
          }

          if (state is GetProjectState) {
            if (projectList == null) {
              projectList = new List();
            }
            projectList.clear();
            projectList.addAll(state.projectList);
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
              itemCount: (null == projectList ? 0 : projectList.length),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(index) {
    return ProjectItem(
      projectList[index],
      () => itemClick(index),
      collectClick: () => collectClick(index),
    );
  }

  ///================================= 网络请求 ================================

  void onRefresh() {
    _projectBloc.dispatch(GetProjectEvent(
        projectList, page, widget.cid, _refreshController, true));
  }

  void onLoading() {
    _projectBloc.dispatch(GetProjectEvent(
        projectList, page, widget.cid, _refreshController, false));
  }

  void itemClick(index) {
    NavigatorUtils.goWebView(
        context, projectList[index].link, projectList[index].title);
  }

  void collectClick(index) {
    if (SpHelper.getIsLogin()) {
      _refreshController.loading();
      if (projectList[index].collect) {
        _collectBloc.dispatch(CancelCollectEvent(projectList[index].id));
      } else {
        _collectBloc.dispatch(CollectEvent(projectList[index].id));
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
