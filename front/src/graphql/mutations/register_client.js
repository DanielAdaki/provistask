import { gql } from "@apollo/client";

export const REGISTER_CLIENT = gql`
  mutation RegistroCliente(
    $username: String!
    $email: String!
    $password: String!
    $name: String!
    $last_name: String!
    $phone: String!
    $postal_code: String!
    $token: String!
  ) {
    register(
      input: { username: $username, email: $email, password: $password }
    ) {
      user {
        username
      }
    }
    createClient(
      data: {
        name: $name
        last_name: $last_name
        email: $email
        password: $password
        postal_code: $postal_code
        phone: $phone
        username: $username
        token: $token
      }
    ) {
      data {
        id
        attributes {
          email
        }
      }
    }
  }
`;
