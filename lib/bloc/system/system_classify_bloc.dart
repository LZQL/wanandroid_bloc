import 'package:wanandroid_bloc/common/index_all.dart';

class SystemClassifyBloc
    extends Bloc<SystemClassifyEvent, SystemClassifyState> {
  @override
  SystemClassifyState get initialState => InitSystemClassifyState();

  @override
  Stream<SystemClassifyState> mapEventToState(
      SystemClassifyEvent event) async* {
    try {

      /// 获取 体系分类 数据
      if (event is GetSystemClassifyEvent) {
        List<SystemTabModel> systemClassifyList =
            await HttpRequestFactory.getSystemClassifyOne();
//        event.controller.loadMoreSuccess();
        event.controller.refreshSuccess();
        yield GetSystemClassifyState(systemClassifyList: systemClassifyList);
      }
    } catch (_) {
      if (event is GetSystemClassifyEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
