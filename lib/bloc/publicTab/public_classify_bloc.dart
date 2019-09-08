import 'package:wanandroid_bloc/common/index_all.dart';

class PublicClassifyBloc
    extends Bloc<PublicClassifyEvent, PublicClassifyState> {
  @override
  PublicClassifyState get initialState => InitPublicClassifyState();

  @override
  Stream<PublicClassifyState> mapEventToState(
      PublicClassifyEvent event) async* {
    try {

      /// 获取 公众号分类 数据
      if (event is GetPublicClassifyEvent) {
        List<TagModel> projectClassifyList =
            await HttpRequestFactory.getPublicClassify();
        event.controller.loadMoreSuccess();
        yield GetPublicClassifyState(publicClassifyList: projectClassifyList);
      }
    } catch (_) {
      if (event is GetPublicClassifyEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
