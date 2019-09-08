import 'package:wanandroid_bloc/common/index_all.dart';

class ProjectClassifyBloc
    extends Bloc<ProjectClassifyEvent, ProjectClassifyState> {
  @override
  ProjectClassifyState get initialState => InitProjectClassifyState();

  @override
  Stream<ProjectClassifyState> mapEventToState(
      ProjectClassifyEvent event) async* {
    try {

      /// 获取 项目分类 数据
      if (event is GetProjectClassifyEvent) {
        List<TagModel> projectClassifyList =
            await HttpRequestFactory.getProjectClassify();
        event.controller.loadMoreSuccess();
        yield GetProjectClassifyState(projectClassifyList: projectClassifyList);
      }
    } catch (_) {
      if (event is GetProjectClassifyEvent) {
        event.controller.refreshFaild();
      }
    }
  }
}
