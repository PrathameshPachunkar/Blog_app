class userModel {
  String? name;
  String? uid;
  String? profilepic;
  String? description;
  DateTime? createdon;

  userModel(
      {this.name, this.uid, this.description, this.profilepic, this.createdon});
  Map<String, dynamic> tomap() {
    return {
      "createdon": createdon,
      "profilepic": profilepic,
      "description": description,
      "name": name,
      "uid": uid,
    };
  }

  userModel.frommap(Map<String, dynamic> map) {
    createdon = map["createdon"].toDate();
    profilepic = map["profilepic"];
    description = map["description"];
    name = map["name"];
    uid = map["uid"];
  }
}
