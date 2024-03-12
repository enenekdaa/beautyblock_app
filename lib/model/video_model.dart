class VideoModel {
  String? createAt;
  String? status;
  String? thumbNail;
  String? updateAt;
  String? video;
  int? videoId;
  String? videoName;
  String? videoDescription;
  bool? isActiveReview;

  VideoModel(
      {this.createAt,
        this.status,
        this.thumbNail,
        this.updateAt,
        this.video,
        this.videoId,
        this.videoName,
        this.videoDescription,
       this.isActiveReview,
      });

  VideoModel.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    status = json['status'];
    thumbNail = json['thumbNail'];
    updateAt = json['updateAt'];
    video = json['video'];
    videoId = json['videoId'];
    videoName = json['videoName'];
    videoDescription = json['videoDescription'];
    isActiveReview = json['isActiveReview'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createAt'] = this.createAt;
    data['status'] = this.status;
    data['thumbNail'] = this.thumbNail;
    data['updateAt'] = this.updateAt;
    data['video'] = this.video;
    data['videoId'] = this.videoId;
    data['videoName'] = this.videoName;
    data['videoDescription'] = this.videoDescription;
    data['isActiveReview'] = this.isActiveReview;

    return data;
  }
}