import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provitask_app/models/data/client_information.dart';
import 'package:provitask_app/utility/graphql.dart';

class UpdateClient {
  static const String _document = r'''
mutation updateClient(
  $id: ID!
  $name: String
  $lastName: String
  $email: String
  $postalCode: String
  $phone: String
  $idImage: ID
  $token: String
  $forgotCode: String
) {
  updateClient(
    id: $id
    data: {
      name: $name
      last_name: $lastName
      email: $email
      postal_code: $postalCode
      phone: $phone
      avatar_image: $idImage
      token: $token
      forgot_code: $forgotCode
    }
  ) {
    data {
      id
    }
  }
}
''';

  static FutureOr<bool> run({
    String? name,
    String? lastName,
    String? email,
    String? postalCode,
    String? phone,
    String? idImage,
    String? token,
    String? forgotCode,
  }) async {
    name ?? ClientInformation.clientName;
    lastName ?? ClientInformation.clientSurname;
    email ?? ClientInformation.clientEmail;
    postalCode ?? ClientInformation.clientPostalCode;
    phone ?? ClientInformation.clientPhone;
    idImage ?? ClientInformation.clientImage!;
    token ?? ClientInformation.clientToken;
    forgotCode ?? ClientInformation.forgotCode;
    final client = clientG();
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(_document),
        variables: {
          "id": int.parse(ClientInformation.clientId!),
          "name": name,
          "lastName": lastName,
          "email": email,
          "postalCode": postalCode,
          "phone": phone,
          "idImage": idImage,
          "token": token
        },
      ),
    );
    if (result.hasException) {
      print(result.exception);
      return true;
    }
    if (result.data!['createProvider']['data'].isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
