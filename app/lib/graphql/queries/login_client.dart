import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String login = r''' 
mutation Login($input: UsersPermissionsLoginInput!) {
  login(input: $input) {
    jwt
    user {
      id
      email
      confirmed
      blocked
      phone
      postal_code
      avatar_image{
        id
        attributes {
          name
        	url
        }
      }
      role {
        name,
        type
        
      }
      confirmed
    }
  }
}
''';

// paso input como variable que tiene la forma de UsersPermissionsLoginInput

/*
{
  "input": {
    "identifier": "email",
    "password": "password",
    "provider": "local"
  }
}
*/

QueryOptions loginClientOptions(String email, String password) {
  return QueryOptions(
    document: gql(login),
    variables: {
      'input': {
        'identifier': email,
        'password': password,
        'provider': 'local',
      },
    },
  );
}
