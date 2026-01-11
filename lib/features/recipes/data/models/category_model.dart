class CategoryModel {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  CategoryModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      idCategory: json['idCategory'] as String?,
      strCategory: json['strCategory'] as String?,
      strCategoryThumb: json['strCategoryThumb'] as String?,
      strCategoryDescription: json['strCategoryDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': idCategory,
      'strCategory': strCategory,
      'strCategoryThumb': strCategoryThumb,
      'strCategoryDescription': strCategoryDescription,
    };
  }
}

class CategoriesResponse {
  final List<CategoryModel> categories;

  CategoriesResponse({required this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    final categoriesList = json['categories'] as List<dynamic>?;
    return CategoriesResponse(
      categories: categoriesList != null
          ? categoriesList
              .map((category) => CategoryModel.fromJson(category as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}

// Model for list endpoints (list.php?c=list, list.php?a=list, list.php?i=list)
class ListItemModel {
  final String? name;

  ListItemModel({this.name});

  factory ListItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemModel(
      name: json['strCategory'] as String? ?? 
            json['strArea'] as String? ?? 
            json['strIngredient'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class ListResponse {
  final List<ListItemModel> items;

  ListResponse({required this.items});

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    final itemsList = json['meals'] as List<dynamic>?;
    return ListResponse(
      items: itemsList != null
          ? itemsList
              .map((item) => ListItemModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': items.map((item) => item.toJson()).toList(),
    };
  }
}
