import 'dart:async';

import 'package:graphql/client.dart';
import 'package:provitask_app/utility/graphql.dart';

class Auth {
  static const String _document = r'''
query login($email: String!, $password: String!) {
  clients(
    filters: { email: { eq: $email }, and: { password: { eq: $password } } }
  ) {
    data {
      id
      attributes {
        name
        last_name
        token
        email
        postal_code
        avatar_image {
          data {
            attributes{
              url
            }
          }
        }
        phone
        isProvider
        forgot_code
      }
    }
  }
}
''';

  static FutureOr<QueryResult> run(String email, String password) async {
    final client = clientG();
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(_document),
        variables: {"email": email, "password": password},
      ),
    );
    if (result.hasException) {
      print(result.exception);
      // return false;
    }
    return result;
  }
}
