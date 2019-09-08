import 'package:wanandroid_bloc/common/index_all.dart';
class SystemTabModel {
  List<TagModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  SystemTabModel(
      {
        this.children,
        this.courseId,
        this.id,
        this.name,
        this.order,
        this.parentChapterId,
        this.userControlSetTop,
        this.visible});

  SystemTabModel.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = new List<TagModel>();
      json['children'].forEach((v) { children.add(new TagModel.fromJson(v)); });
    }
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['courseId'] = this.courseId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['parentChapterId'] = this.parentChapterId;
    data['userControlSetTop'] = this.userControlSetTop;
    data['visible'] = this.visible;
    return data;
  }
}
