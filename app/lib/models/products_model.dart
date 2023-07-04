import 'dart:convert';

List<ProductsModel> listProductsFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String listProductsToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
    ProductsModel({
        required this.idProduct,
        required this.idUser,
        required this.idCategory,
        required this.category,
        required this.idSubcategory,
        required this.subcategory,
        required this.title,
        required this.description,
        required this.quantity,
        required this.price,
        required this.state,
        required this.xLatitude,
        required this.yLatitude,
        required this.photosFile,
        required this.status,
        required this.createAt,
        required this.updateAt,
    });

    int idProduct;
    int idUser;
    int idCategory;
    String category;
    int idSubcategory;
    String subcategory;
    String title;
    String description;
    int quantity;
    double price;
    int state;
    String xLatitude;
    String yLatitude;
    String photosFile;
    int status;
    DateTime createAt;
    DateTime updateAt;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        idProduct: json["id_product"],
        idUser: json["id_user"],
        idCategory: json["id_category"],
        category: json["category"],
        idSubcategory: json["id_subcategory"],
        subcategory: json["subcategory"],
        title: json["title"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        state: json["state"],
        xLatitude: json["x_latitude"],
        yLatitude: json["y_latitude"],
        photosFile: json["photos_file"],
        status: json["status"],
        createAt: DateTime.parse(json["create_at"]),
        updateAt: DateTime.parse(json["update_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_product": idProduct,
        "id_user": idUser,
        "id_category": idCategory,
        "category": category,
        "id_subcategory": idSubcategory,
        "subcategory": subcategory,
        "title": title,
        "description": description,
        "quantity": quantity,
        "price": price,
        "state": state,
        "x_latitude": xLatitude,
        "y_latitude": yLatitude,
        "photos_file": photosFile,
        "status": status,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
    };
}
