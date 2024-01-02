class detailsModel {
  String name;
  String profilepic;
  DateTime createdon;
  String description;
  detailsModel(
      {required this.name,
      required this.createdon,
      required this.description,
      required this.profilepic});

  Map<String, dynamic> tomap() {
    return {
      "createdon": createdon,
      "authorName": name,
      "profilepic": profilepic,
      "description": description
    };
  }

  frommap(Map<String, dynamic> map) {
    createdon = map["createdon"];
    name = map["authorName"];
    profilepic = map["profilepic"];
    description = map["description"];
  }
}
