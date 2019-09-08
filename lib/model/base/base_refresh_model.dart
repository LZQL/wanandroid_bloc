
/// 分页 基类
class BaseRefreshModel {
  int curPage;
  List datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  BaseRefreshModel(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  BaseRefreshModel.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    datas = json['datas'];
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}
