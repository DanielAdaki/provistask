import { gql } from "@apollo/client";

export const CREATE_PROVIDER = gql`
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
      data {
        id
      }
    }
    updateClient(id: $idClient, data: { isProvider: true }) {
      data {
        attributes {
          isProvider
        }
      }
    }
  }
`;
