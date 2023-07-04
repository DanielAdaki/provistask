import 'dart:convert';

ListcategoriasResponse listcategoriasResponseFromJson(String str) => ListcategoriasResponse.fromJson(json.decode(str));

String listcategoriasResponseToJson(ListcategoriasResponse data) => json.encode(data.toJson());

class ListcategoriasResponse {
    ListcategoriasResponse({
        required this.data,
    });

    final Data data;

    factory ListcategoriasResponse.fromJson(Map<String, dynamic> json) => ListcategoriasResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.docs,
        required this.totalDocs,
        required this.limit,
        required this.totalPages,
        required this.page,
        required this.pagingCounter,
        required this.hasPrevPage,
        required this.hasNextPage,
        this.prevPage,
        this.nextPage,
    });

    final List<Categorias> docs;
    final int totalDocs;
    final int limit;
    final int totalPages;
    final int page;
    final int pagingCounter;
    final bool hasPrevPage;
    final bool hasNextPage;
    final dynamic prevPage;
    final dynamic nextPage;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: List<Categorias>.from(json["docs"].map((x) => Categorias.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
    };
}

class Categorias {
    Categorias({
        required this.id,
        required this.title,
        required this.status,
        required this.subCategory,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String title;
    final bool status;
    final List<dynamic> subCategory;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Categorias.fromJson(Map<String, dynamic> json) => Categorias(
        id: json["_id"],
        title: json["title"],
        status: json["status"],
        subCategory: List<dynamic>.from(json["subCategory"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "status": status,
        "subCategory": List<dynamic>.from(subCategory.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}


ListSubCategoriasResponse listSubCategoriasResponseFromJson(String str) => ListSubCategoriasResponse.fromJson(json.decode(str));

String listSubCategoriasResponseToJson(ListSubCategoriasResponse data) => json.encode(data.toJson());

class ListSubCategoriasResponse {
    ListSubCategoriasResponse({
        required this.data,
    });

    List<SubCategoria> data;

    factory ListSubCategoriasResponse.fromJson(Map<String, dynamic> json) => ListSubCategoriasResponse(
        data: List<SubCategoria>.from(json["data"].map((x) => SubCategoria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SubCategoria {
    SubCategoria({
        required this.idSubcategory,
        required this.idCategory,
        required this.title,
        this.description,
        required this.status,
        this.createAt,
        this.updateAt,
    });

    int idSubcategory;
    int idCategory;
    String title;
    dynamic description;
    int status;
    dynamic createAt;
    dynamic updateAt;

    factory SubCategoria.fromJson(Map<String, dynamic> json) => SubCategoria(
        idSubcategory: json["id_subcategory"],
        idCategory: json["id_category"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        createAt: json["create_at"],
        updateAt: json["update_at"],
    );

    Map<String, dynamic> toJson() => {
        "id_subcategory": idSubcategory,
        "id_category": idCategory,
        "title": title,
        "description": description,
        "status": status,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
