import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provitask_app/utility/graphql.dart';

class GetCategories {
  static const String _document = r'''
query getCategories {
  categories(pagination: { limit: 300 }) {
    data {
      id

      attributes {
        title
      }
    }
  }
}
''';

  /// Return categories and id
  static FutureOr<List<Category>> run() async {
    final client = clientG();
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(_document),
      ),
    );
    if (result.hasException) {
      print(result.exception);
    }
    if ((result.data!['categories']['data'] as List).isNotEmpty) {
      List json = result.data!['categories']['data'];

      return List<Category>.from(json.map((e) => Category.fromJson(e)));
    } else {
      return [];
    }
  }
}

class Category {
  int id;
  String title;

  Category({required this.id, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: int.parse(json['id']), title: json['attributes']['title']);
}
