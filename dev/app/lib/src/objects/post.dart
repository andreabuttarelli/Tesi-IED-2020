class Post {
  String id;
  String userId;
  String userName;
  String url;
  String type;
  String placeId;

  Post(
      {this.id, this.userId, this.userName, this.url, this.type, this.placeId});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    url = json['url'];
    type = json['type'];
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['url'] = this.url;
    data['type'] = this.type;
    data['place_id'] = this.placeId;
    return data;
  }
}
