class blogModel {
  String? title;
  // String? imageUrl;
  bool read = false;
  String? blog;
  String? author;
  DateTime? createdOn;
  String? category;
  blogModel(
      { //required this.category,
      required this.author,
      required this.blog,
      required this.createdOn,
      //required this.imageUrl,
      required this.read,
      required this.title});

  Map<String, dynamic> toMap() {
    return {
      // "category": category,
      "title": title,
      //"imageUrl": imageUrl,
      "read": read,
      "blog": blog,
      "author": author,
      "createdOn": createdOn,
    };
  }

  blogModel.frommap(Map<String, dynamic> map) {
    //category = map["category"];
    title = map["title"];
    //imageUrl = map["imageUrl"];
    read = map["read"];
    blog = map["blog"];
    author = map['author'];
    createdOn = map["createdOn"];
  }
}
