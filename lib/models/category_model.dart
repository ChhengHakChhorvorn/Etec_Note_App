class CategoryModel {
  int id;
  String categoryName;

  CategoryModel({required this.id, required this.categoryName});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "categoryName": categoryName,
    });
  }

  CategoryModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        categoryName = res["categoryName"];
}
