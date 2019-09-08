import 'package:wanandroid_bloc/common/index_all.dart';

/// 体系 二级 分类 页面
class SystemClassifyTwoPage extends StatefulWidget {
  final  List<TagModel> systemClassifyTwoList;

  SystemClassifyTwoPage(this.systemClassifyTwoList);

  @override
  _SystemClassifyTwoPageState createState() => _SystemClassifyTwoPageState();
}

class _SystemClassifyTwoPageState extends State<SystemClassifyTwoPage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
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
    return Container(
      child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                return buildItem(index);
              },
              itemCount: (null == widget.systemClassifyTwoList ? 0 : widget.systemClassifyTwoList.length),
            ),
    );
  }

  Widget buildItem(index) {

    return InkWell(
      onTap: ()=>rightItemClick(index),
      child: Container(

          child: Padding(
            padding: EdgeInsets.only(
              left: Dimens.size(32),
              right: Dimens.size(32),
              top: Dimens.size(50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.systemClassifyTwoList[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                      fontSize: Dimens.sp(28),
                      color: ColorT.color_333333),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),

                Gaps.vGap50,
                DividerHorizontal()
              ],
            ),
          )),
    );
  }

  ///================================= 网络请求 ================================

  void rightItemClick(index){
    NavigatorUtils.goSystemPage(context,widget.systemClassifyTwoList[index].id,widget.systemClassifyTwoList[index].name);
  }

  @override
  bool get wantKeepAlive => true;
}
