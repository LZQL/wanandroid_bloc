


class BannerModel {
	String desc;
	int id;
	String imagepath;
	int isvisible;
	int order;
	String title;
	int type;
	String url;

	BannerModel({this.desc, this.id, this.imagepath, this.isvisible, this.order, this.title, this.type, this.url});

	BannerModel.fromJson(Map<String, dynamic> json) {
		desc = json['desc'];
		id = json['id'];
		imagepath = json['imagePath'];
		isvisible = json['isVisible'];
		order = json['order'];
		title = json['title'];
		type = json['type'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['desc'] = this.desc;
		data['id'] = this.id;
		data['imagePath'] = this.imagepath;
		data['isVisible'] = this.isvisible;
		data['order'] = this.order;
		data['title'] = this.title;
		data['type'] = this.type;
		data['url'] = this.url;
		return data;
	}
}
