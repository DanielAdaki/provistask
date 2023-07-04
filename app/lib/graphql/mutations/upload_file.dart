import 'dart:async';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import "package:http/http.dart" show MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:provitask_app/utility/graphql.dart';

class UploadFileMutation {
  static const String _document = r'''
mutation a($file: Upload!) {
  upload(
    file: $file
  ) {
    data {
      id
    }
  }
}
''';

  // Return the file ID in the server
  static FutureOr<int?> run(File file) async {
    final client = clientG();
    var byteData = file.readAsBytesSync();

    var multipartFile = MultipartFile.fromBytes(
      '',
      byteData,
      filename: '${DateTime.now().second}.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(_document),
        variables: {
          'file': multipartFile,
        },
      ),
    );
    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }
    if ((result.data!['upload']['data']).isNotEmpty) {
      return int.parse(result.data!['upload']['data']['id']);
    } else {
      return null;
    }
  }
}
