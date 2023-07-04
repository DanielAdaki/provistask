import 'dart:async';

import 'package:graphql/client.dart';
import 'package:provitask_app/utility/graphql.dart';

class Register {
  static const String _document = r'''
mutation RegistroCliente(
  $username: String!
  $email: String!
  $password: String!
  $name: String!
  $last_name: String!
  $postal_code: String!
  $forgot_code: String
  $token: String
) {
  register(input: {
    username: $username
    email: $email
    password: $password
  }){
    user{
      username
    }
  }
  createClient(data: {
    name: $name,
    last_name: $last_name,
    email: $email,
    password: $password,
    postal_code: $postal_code,
    username: $username,
    forgot_code: $forgot_code,
    token: $token
  }) {
    data {
      id
      attributes {
        email
        
      }
    }
  }
}
''';

  static FutureOr<bool> run(
    String username,
    String email,
    String password,
    String name,
    String lastName,
    String postalCode,
    String forgotCode,
    String token,
  ) async {
    final client = clientG();
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(_document),
        variables: {
          "name": name,
          "last_name": lastName,
          "email": email,
          "password": password,
          "postal_code": postalCode,
          "username": username,
          "forgot_code": forgotCode,
          "token": token
        },
      ),
    );
    if (result.hasException) {
      // print(result.exception);
      return false;
    }
    return result.data!['createClient']['data']['attributes']['email'] != null;
  }
}
