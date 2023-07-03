import { gql } from "@apollo/client";

export const GET_CLIENT_DATA = gql`
  query GetClient($email: String!) {
    clients(publicationState: PREVIEW, filters: { email: { eq: $email } }) {
      data {
        id
        attributes {
          name
          last_name
          email
          postal_code
          phone
          isProvider
        }
      }
    }
  }
`;
