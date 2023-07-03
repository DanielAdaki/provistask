import { gql } from "@apollo/client";

export const CREATE_TASK = gql`
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
`;
