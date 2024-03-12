class PostModel {
  String? id;
  String? userId;
  String? imagePath;
  String? category;
  String? title;
  String? contents;
  String? tag;

  PostModel(
      {this.id,
        this.userId,
        this.imagePath,
        this.category,
        this.title,
        this.contents,
        this.tag});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    imagePath = json['imagePath'];
    category = json['category'];
    title = json['title'];
    contents = json['contents'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['imagePath'] = this.imagePath;
    data['category'] = this.category;
    data['title'] = this.title;
    data['contents'] = this.contents;
    data['tag'] = this.tag;
    return data;
  }
}