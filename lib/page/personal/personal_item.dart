import 'package:wanandroid_bloc/common/index_all.dart';

class PersonalItem extends StatelessWidget {
  final String title;
  final String rightText;
  final Function onClick;
  final bool showGo;

  PersonalItem({@required this.title,@required  this.onClick, this.rightText,this.showGo = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          alignment: Alignment.center,
          height: Dimens.size(90),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: Dimens.size(33),
                child: Text(
                  title,
                  style: TextStyles.size28color333333,
                ),
              ),
              rightText == null?Container():
              Positioned(
                right: Dimens.size(65),
                child: Text(
                  rightText,
                  style: TextStyles.size28color999999,
                ),
              ),
              Positioned(
                    right: Dimens.size(32),
                    child:showGo? Image.asset(
                      ImageUtil.getImgPath('go'),
                      width: Dimens.size(15),
                      height: Dimens.size(28),
                    ):Container()),

            ],
          ),
        ),
      ),
    );
  }
}