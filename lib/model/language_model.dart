/// {"titleId":"","languageCode":"","countryCode":"","isSelected":false}

/// 国际化 多语言
class LanguageModel {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageModel(this.titleId, this.languageCode, this.countryCode,
      {this.isSelected = false});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    titleId = json['titleId'];
    languageCode = json['languageCode'];
    countryCode = json['countryCode'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titleId'] = this.titleId;
    data['languageCode'] = this.languageCode;
    data['countryCode'] = this.countryCode;
    data['isSelected'] = this.isSelected;
    return data;
  }

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"titleId\":\"$titleId\"");
    sb.write(",\"languageCode\":\"$languageCode\"");
    sb.write(",\"countryCode\":\"$countryCode\"");
    sb.write('}');
    return sb.toString();
  }
}
