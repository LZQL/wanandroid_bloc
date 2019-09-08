import 'package:flutter/cupertino.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 0;

  int taskBadgeNo = 0;
  int workBadgeNo = 0;
  int trainingBadgeNo = 0;
  int projectBadgeNo = 0;
  int personalBadgeNo = 0;

  final _pageWidgetList = [
    BlocProvider(
        builder: (context) => BlogBloc(), child: BlogPage()),
    BlocProvider(
        builder: (context) => NewProjectBloc(), child: NewProjectPage()),
    BlocProvider(
        builder: (context) => PublicClassifyBloc(), child: PublicClassifyPage()),
    BlocProvider(
        builder: (context) => SystemClassifyBloc(), child: SystemClassifyOnePage()),
    PersonalPage(),
  ];

  var iconsUn = [
    MyIcon.task_un,
    MyIcon.work_un,
    MyIcon.train_un,
    MyIcon.pro_un,
    MyIcon.user_un
  ];

  var icons = [MyIcon.task, MyIcon.work, MyIcon.train, MyIcon.pro, MyIcon.user];

  PageController _pageController;

  Widget _build(BuildContext context) {
    List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: IconWithBadge(
              icon: Icon(iconsUn[0], size: Dimens.size(50)),
              badgeNumber: taskBadgeNo),
          activeIcon: IconWithBadge(
              icon: Icon(icons[0], size: Dimens.size(50)),
              badgeNumber: taskBadgeNo),
          title: Text(IntlUtil.getString(context, Ids.blogTab)),
          backgroundColor: Theme.of(context).primaryColor),
      BottomNavigationBarItem(
          icon: IconWithBadge(
              icon: Icon(iconsUn[1], size: Dimens.size(50)),
              badgeNumber: workBadgeNo),
          activeIcon: IconWithBadge(
              icon: Icon(icons[1], size: Dimens.size(50)),
              badgeNumber: workBadgeNo),
          title: Text(IntlUtil.getString(context, Ids.projectTab)),
          backgroundColor: Theme.of(context).primaryColor),
      BottomNavigationBarItem(
          icon: IconWithBadge(
              icon: Icon(iconsUn[2], size: Dimens.size(50)),
              badgeNumber: trainingBadgeNo),
          activeIcon: IconWithBadge(
              icon: Icon(icons[2], size: Dimens.size(50)),
              badgeNumber: trainingBadgeNo),
          title: Text(IntlUtil.getString(context, Ids.publicTab)),
          backgroundColor: Theme.of(context).primaryColor),
      BottomNavigationBarItem(
          icon: IconWithBadge(
              icon: Icon(iconsUn[3], size: Dimens.size(50)),
              badgeNumber: projectBadgeNo),
          activeIcon: IconWithBadge(
              icon: Icon(icons[3], size: Dimens.size(50)),
              badgeNumber: projectBadgeNo),
          title: Text(IntlUtil.getString(context, Ids.systemTab)),
          backgroundColor: Theme.of(context).primaryColor),
      BottomNavigationBarItem(
          icon: IconWithBadge(
              icon: Icon(iconsUn[4], size: Dimens.size(50)),
              badgeNumber: personalBadgeNo),
          activeIcon: IconWithBadge(
              icon: Icon(icons[4], size: Dimens.size(50)),
              badgeNumber: personalBadgeNo),
          title: Text(IntlUtil.getString(context, Ids.personalTab)),
          backgroundColor: Theme.of(context).primaryColor),
    ];

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(), // 滚动物理，不允许用户滚动。
        children: _pageWidgetList,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
        items: _bottomTabs,
        currentIndex: _currentPage,
//        inactiveColor: Colors.grey,
        activeColor: Theme.of(context).primaryColor,
        onTap: (int index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return _build(context);
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
