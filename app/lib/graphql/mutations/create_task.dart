import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provitask_app/utility/graphql.dart';

class CreateTask {
  static const String _document = r'''
mutation createTask(
  $idClient: ID
  $location: String
  $vehicle: ID
  $description: String
  $date: String
  $timeDay: ID
  $idProvider: ID
) {
  createTask(
    data: {
      client: $idClient
      location: $location
      transportation: $vehicle
      description: $description
      date: $date
      time_day: $timeDay
      provider: $idProvider
    }
  ) {
    data {
      id
    }
  }
}
''';

  static FutureOr<bool> run(
      int idClient,
      String location,
      int length,
      int vehicle,
      String description,
      String date,
      int timeDay,
      int idProvider) async {
    final client = clientG();
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(_document),
        variables: {
          "client": idClient,
          "location": location,
          "task_length": length,
          "transportation": vehicle,
          "description": description,
          "date": date,
          "time_day": timeDay,
          "provider": idProvider,
        },
      ),
    );
    if (result.data!['createTask']['data']['id'].isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
