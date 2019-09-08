import 'package:wanandroid_bloc/common/index_all.dart';

/// 项目的 列表Item
class ProjectItem extends StatefulWidget {
  final Function onItemClick;
  final ItemModel model;
  final Function collectClick;

  ProjectItem(this.model, this.onItemClick, {this.collectClick});

  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onItemClick,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
            left: Dimens.size(32),
            right: Dimens.size(32),
            top: Dimens.size(20),
          ),
          child: Column(
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CachedNetworkImage(
                      width: Dimens.size(140),
                      height: Dimens.size(230),
                      fit: BoxFit.fill,
                      imageUrl: widget.model.envelopePic,
                      placeholder: (BuildContext context, String url) {
                        return Container(
                            width: Dimens.size(140),
                            height: Dimens.size(230),
                            child: ProgressView());
                      },
                      errorWidget:
                          (BuildContext context, String url, Object error) {
                        return Container(
                            width: Dimens.size(140),
                            height: Dimens.size(230),
                            child: Icon(Icons.error));
                      },
                    ),
                    Gaps.hGap20,
                    Container(
                      width: SystemScreenUtil.getInstance().screenWidth -
                          Dimens.size(32) -
                          Dimens.size(32) -
                          Dimens.size(20) -
                          Dimens.size(140),
                      height: Dimens.size(250),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.model.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Dimens.sp(28),
                                color: ColorT.color_333333),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            widget.model.desc,
                            style: TextStyles.size26color999999,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '作者：' +
                                      widget.model.author +
                                      '    时间：' +
                                      widget.model.niceDate,
                                  style: TextStyles.size22color999999,
                                ),
                              ),
                              InkWell(
                                onTap: widget.collectClick,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(Dimens.size(20)),
                                  child: Icon(
                                    MyIcon.collection2,
                                    color: widget.model.collect
                                        ? ColorT.color_FFC529
                                        : ColorT.color_999999,
                                    size: Dimens.size(45),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
              DividerHorizontal()
            ],
          ),
        ),
      ),
    );
  }
}
