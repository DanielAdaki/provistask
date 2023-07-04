import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../utility/graphql.dart';

class CreateProvider {
  static const String _document = r'''
mutation createProvider(
  $idClient: ID!
  $categories: [ID]
  $socialSecNumber: String
  $address: String
  $city: String
  $state: String
  $birthDay: String
  $photo: ID
) {
  createProvider(
    data: {
      client: $idClient
      categories: $categories
      security_number: $socialSecNumber
      address: $address
      city: $city
      state: $state
      birthday: $birthDay
      photo: $photo
    }
  ) {
    data{
      id
    }
  }
  updateClient(id:$idClient data:{
    isProvider: true
  }){
    data{
      attributes{
        isProvider
      }
    }
  }
}
''';

  static FutureOr<bool> run(
      List<int> categories,
      String socialSecNumber,
      String address,
      String city,
      String state,
      String birthDay,
      int photo) async {
    final client = clientG();
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(_document),
        variables: {
          // "idClient": int.parse(ClientInformation.clientId!),
          "idClient": 1,
          "skills": categories,
          "socialSecNumber": socialSecNumber,
          "address": address,
          "city": city,
          "state": state,
          "birthDay": birthDay,
          "photo": photo,
        },
      ),
    );
    if (result.hasException) {
      // print(result.exception);
      return false;
    }
    return result.data!['createProvider']['data'].isNotEmpty;
  }
}
